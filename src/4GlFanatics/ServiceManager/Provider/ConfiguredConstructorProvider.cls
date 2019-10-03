/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/
/*------------------------------------------------------------------------
    File        : ConfiguredConstructorProvider
    Description : Instantiates a class using the constructor in the type determined by
                  JSON configuration
    Author(s)   : pjudge
    Notes       : Schema of JSON array for Context
                    [
                      "<ooabl-type-name>" 
                      | 
                      { "type": "<ooabl-type-name>|character|logical|int64|datetime-tz",  //REQ
                        "isPrimitive": "true|false",
                        "isArray": "true|false",
                        "value": "character|value-JsonObject|value-JsonArray",
                      }
                    ]
                   The "type" property is the type that the parameter is defined as.
                   Only arrays of objects are allowed.
                   If a string is provided it must be <ooabl-type-name> 
                   
                   Schema of value-JsonObject
                   { "service": "<ooabl-type-name>",
                      "alias": null | ""
                   }
                   
                   Schema of value-JsonArray
                   [
                      "value" | value-JsonObject 
                   ]
  ----------------------------------------------------------------------*/
block-level on error undo, throw.

using 4GlFanatics.ServiceManager.IProvider.
using Ccs.Common.IService.
using OpenEdge.Core.Assert.
using Progress.Json.ObjectModel.JsonArray.
using Progress.Json.ObjectModel.JsonDataType.
using Progress.Json.ObjectModel.JsonObject.
using Progress.Lang.ParameterList.

class 4GlFanatics.ServiceManager.Provider.ConfiguredConstructorProvider implements IProvider: 
    
    /* Instantiates (NEWs) a class.
       
       The type cannot be ABSTRACT or an INTERFACE
       
       @param  Progress.Lang.Class  The Type to instantiate
       @param  Progress.Lang.Object Context for the provider; use depends on the implementation 
       @return Progress.Lang.Object An object of that type */
    method public Progress.Lang.Object invokeService(input pImplType as Progress.Lang.Class,
                                                     input pContext as Progress.Lang.Object):
        define variable idx as integer no-undo.
        define variable contextA as JsonArray no-undo.
        define variable ctorArg as JsonObject no-undo.
        define variable ctorParamO as JsonObject no-undo.
        define variable ctorParamA as JsonArray no-undo.
        define variable paramType as character no-undo.
        define variable svcName as character no-undo.
        define variable svcAlias as character no-undo.
        define variable paramLoop as integer no-undo.
        define variable paramCnt as integer no-undo.
        
        define variable svc as Progress.Lang.Object no-undo.
        define variable loop as integer no-undo.
        define variable cnt as integer no-undo.
        define variable paramArg as Progress.Lang.Object no-undo.
        define variable paramArray as Progress.Lang.Object extent no-undo.
        define variable paramList as ParameterList no-undo.
        
        Assert:NotNull(pImplType, 'Implementation type').
        Assert:NotAbstract(pImplType).
        Assert:NotInterface(pImplType).
        
        if    not valid-object(pContext)
           or not type-of(pContext, JsonArray)
        then
            contextA = new JsonArray().
        else
            contextA = cast(pContext, JsonArray).
        
        cnt = contextA:Length.
        paramList = new ParameterList(cnt).
        
        do loop = 1 to cnt:
            if contextA:GetType(loop) eq JsonDataType:OBJECT then
                assign ctorArg   = contextA:GetJsonObject(loop)
                       paramType = ctorArg:GetCharacter('type')
                       .
            else
                assign paramType = contextA:GetCharacter(loop)
                       ctorArg   = new JsonObject()
                       .
            
            if ctorArg:Has('isPrimitive')
               and ctorArg:GetLogical('isPrimitive')
            then
            case paramType:
                when 'character' then
                    paramList:SetParameter(loop, paramType, 'input', ctorArg:GetCharacter('value')).
                when 'logical' then
                    paramList:SetParameter(loop, paramType, 'input', ctorArg:GetLogical('value')).
                when 'datetime-tz' then
                    paramList:SetParameter(loop, paramType, 'input', ctorArg:GetDatetimeTZ('value')).
                when 'int64' then
                    paramList:SetParameter(loop, paramType, 'input', ctorArg:GetInt64('value')).
            end case.
            else
            if     ctorArg:Has('isArray')
               and ctorArg:GetLogical('isArray')
            then
            do:
                extent(paramArray) = ?.
                
                ctorParamA = ctorArg:GetJsonArray('value').
                paramCnt = ctorParamA:Length.
                if paramCnt gt 0 then
                    extent(paramArray) = paramCnt.
                
                do paramLoop = 1 to paramCnt:
                    case ctorParamA:GetType(paramLoop):
                        when JsonDataType:STRING then
                            assign svcName  = ctorParamA:GetCharacter(paramLoop)
                                   svcAlias = ?
                                   .
                        when JsonDataType:OBJECT then
                            assign ctorParamO = ctorParamA:GetJsonObject(paramLoop)
                                   svcName    = ctorParamO:GetCharacter('service')
                                   svcAlias   = ctorParamO:GetCharacter('alias')
                                   .
                    end case.
                    
                    paramArray[paramLoop] = Ccs.Common.Application:ServiceManager:getService(Progress.Lang.Class:GetClass(svcName), svcAlias).
                end.
                
                paramList:SetParameter(loop, 'class ' + paramType + ' extent ', 'input', paramArray).
            end.
            else
            do:
                if ctorArg:Has('value') then
                case ctorArg:GetType('value'):
                    when JsonDataType:STRING then
                        assign svcName  = ctorArg:GetCharacter('value')
                               svcAlias = ?
                               .
                    when JsonDataType:OBJECT then
                        assign ctorParamO = ctorArg:GetJsonObject('value')
                               svcName    = ctorParamO:GetCharacter('service')
                               svcAlias   = ctorParamO:GetCharacter('alias')
                               .
                end case.
                else
                    assign svcName  = paramType
                           svcAlias = ?.
                
                paramArg = Ccs.Common.Application:ServiceManager:getService(Progress.Lang.Class:GetClass(svcName), svcAlias).
                paramList:SetParameter(loop, 'class ' + paramType, 'input', 
                                       dynamic-cast(paramArg, paramType)).
            end.
        end.
        
        svc = pImplType:New(paramList).
        
        if type-of(svc, IService) then
            cast(svc, IService):initialize().
        
        return svc.
    end method.
    
end class.