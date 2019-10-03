/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/
/*------------------------------------------------------------------------
    File        : LongestConstructorRunner
    Description : Instantiates a class using the longest constructor in the type,
                    - with all class-based parameters
                    - no array parameters 
    Author(s)   : pjudge
    Notes       : 
  ----------------------------------------------------------------------*/
block-level on error undo, throw.

using 4GlFanatics.ServiceManager.IProvider.
using Ccs.Common.IService.
using OpenEdge.Core.Assert.
using Progress.Lang.AppError.
using Progress.Lang.ParameterList.
using Progress.Reflect.Constructor.
using Progress.Reflect.Parameter.
using Progress.Reflect.ParameterMode.

class 4GlFanatics.ServiceManager.Provider.LongestConstructorProvider implements IProvider: 
    
    /* Instantiates (NEWs) a class.
       
       The type cannot be ABSTRACT or an INTERFACE
       
       @param  Progress.Lang.Class  The Type to instantiate
       @param  Progress.Lang.Object Context for the provider; use depends on the implementation 
       @return Progress.Lang.Object An object of that type */
    method public Progress.Lang.Object invokeService(input pImplType as Progress.Lang.Class,
                                                     input pContext as Progress.Lang.Object):
        define variable svc as Progress.Lang.Object no-undo.
        define variable ctor as Constructor extent no-undo.
        define variable params as Parameter extent no-undo.
        define variable idx as integer no-undo.
        define variable loop as integer no-undo.
        define variable cnt as integer no-undo.
        define variable paramLoop as integer no-undo.
        define variable paramCnt as integer extent no-undo.
        define variable paramList as ParameterList no-undo.
        define variable paramArg as Progress.Lang.Object no-undo.
        
        Assert:NotNull(pImplType, 'Implementation type').
        Assert:NotAbstract(pImplType).
        Assert:NotInterface(pImplType).
        
        ctor = pImplType:GetConstructors().
        cnt = extent(ctor).
        extent(paramCnt) = cnt.
        idx = 0.
        
        CTOR-LOOP:
        do loop = 1 to cnt:
            extent(params) = ?.
            params = ctor[loop]:GetParameters().
            paramCnt[loop] = ctor[loop]:NumParameters.
            
            do paramLoop = 1 to paramCnt[loop]:
                // if there are primitive parameters we can't do magic
                if params[paramLoop]:DataTypeName eq ? then
                    next CTOR-LOOP.
                
                // only support scalars parameters
                if not params[paramLoop]:Extent eq 0 then
                    next CTOR-LOOP.
                
                // only support INPUT parmeters
                if not params[paramLoop]:Mode eq ParameterMode:Input then
                    next CTOR-LOOP.
            end.
            
            // if this is the default ctor and we've not yet selected one, use the default ctor
            if idx eq 0 then
                idx = loop.
            else
            // which one of the ctors has the most constructor arguments?
            if paramCnt[loop] gt paramCnt[idx] then
               idx = loop.
        end.
        
        if idx eq 0 then
            return error new AppError(substitute('Unable to find usable constructor for &1', pImplType:TypeName), 0).
        
        paramList = new ParameterList(paramCnt[idx]).
        extent(params) = ?.
        params = ctor[idx]:GetParameters().
        
        do loop = 1 to paramCnt[idx]:
            paramArg = Ccs.Common.Application:ServiceManager:getService(Progress.Lang.Class:GetClass(params[loop]:DataTypeName)).
            paramList:SetParameter(loop, 'class ' + params[loop]:DataTypeName, 'input', paramArg).
        end.
        
        svc = pImplType:New(paramList).
        
        if type-of(svc, IService) then
            cast(svc, IService):initialize().
        
        return svc.
    end method.
    
end class.