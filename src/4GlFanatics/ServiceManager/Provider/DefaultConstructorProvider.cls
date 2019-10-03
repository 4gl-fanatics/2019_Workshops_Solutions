/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/
 /*------------------------------------------------------------------------
    File        : DefaultConstructorRunner
    Purpose     : Instantiates (NEWs) a class using the empty constructor
    Author(s)   : pjudge
    Notes       : 
  ----------------------------------------------------------------------*/
block-level on error undo, throw.

using 4GlFanatics.ServiceManager.IProvider.
using Ccs.Common.IService.
using OpenEdge.Core.Assert.

class 4GlFanatics.ServiceManager.Provider.DefaultConstructorProvider implements IProvider: 
    
    /* Instantiates (NEWs) a class.
       
       The type cannot be ABSTRACT or an INTERFACE
       
       @param  Progress.Lang.Class  The Type to instantiate
       @param  Progress.Lang.Object Context for the provider; use depends on the implementation 
       @return Progress.Lang.Object An object of that type */
    method public Progress.Lang.Object invokeService(input pImplType as Progress.Lang.Class,
                                                     input pContext as Progress.Lang.Object):
        define variable svc as Progress.Lang.Object no-undo.
        
        Assert:NotNull(pImplType, 'Implementation type').
        
        Assert:NotAbstract(pImplType).
        Assert:NotInterface(pImplType).
        
        svc = pImplType:New().
        
        if type-of(svc, IService) then
            cast(svc, IService):initialize().
        
        return svc.
    end method.

end class.
