/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/
/*------------------------------------------------------------------------
    File        : PropertySpecProvider
    Description : Provider for implementations of the 4GlFanatics.UI.IPropertySpec service  
    Author(s)   : pjudge
    Notes       : 
  ----------------------------------------------------------------------*/
block-level on error undo, throw.

using 4GlFanatics.ServiceManager.IProvider.
using 4GlFanatics.UI.IPropertySpec.
using Ccs.Common.IService.
using OpenEdge.Core.Assert.
using Progress.Json.ObjectModel.JsonDataType.
using Progress.Json.ObjectModel.JsonObject.

class 4GlFanatics.ServiceManager.Provider.PropertySpecProvider implements IProvider: 
    
    /* Provider for an instance of IPropertySpec.
       The context for the property spec is 
        {
            "name": "<property-name>",
            "label": "<property-label>",
            "controlType": "<control-type>"
        }
       @param  Progress.Lang.Class  The Type to instantiate
       @param  Progress.Lang.Object Context for the provider; use depends on the implementation 
       @return Progress.Lang.Object An object of that type */
    method public Progress.Lang.Object invokeService(input pImplType as Progress.Lang.Class,
                                                     input pContext as Progress.Lang.Object ):
        define variable svc as Progress.Lang.Object no-undo.
        define variable ctx as JsonObject no-undo.
        
        Assert:NotNull(pImplType, 'Implementation type').
        Assert:NotAbstract(pImplType).
        Assert:NotInterface(pImplType).
        
        if    not valid-object(pContext)
           or not type-of(pContext, JsonObject)
        then
            ctx = new JsonObject().
        else
            ctx = cast(pContext, JsonObject).
        
        svc = pImplType:New().
        
        if     ctx:Has('name')
           and ctx:GetType('name') eq JsonDataType:STRING
        then
            cast(svc, IPropertySpec):Name = ctx:GetCharacter('name').
        
        if     ctx:Has('label')
           and ctx:GetType('label') eq JsonDataType:STRING
        then
            cast(svc, IPropertySpec):Label =ctx:GetCharacter('label').
            
        if     ctx:Has('controlType')
           and ctx:GetType('controlType') eq JsonDataType:STRING
        then
            cast(svc, IPropertySpec):ControlType =ctx:GetCharacter('controlType').
        
        if type-of(svc, IService) then
            cast(svc, IService):initialize().
        
        return svc.
    end method.

end class.