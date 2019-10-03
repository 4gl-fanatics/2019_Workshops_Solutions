/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/ 
/*------------------------------------------------------------------------
    File        : NameConventionSvcMgr
    Description : 
    Author(s)   : pjudge
    Notes       : 
  ----------------------------------------------------------------------*/
block-level on error undo, throw.

using 4GlFanatics.ServiceManager.AbstractServiceManager.
using Ccs.ServiceManager.ILifecycleScope.
using Ccs.ServiceManager.ITransientScope.
using OpenEdge.Core.Assert.

class 4GlFanatics.ServiceManager.NameConventionSvcMgr inherits AbstractServiceManager: 
    
    /* Returns the implementation type for a requested service
       
       @param Progress.Lang.Class The service requested
       @return Progress.Lang.Class The implementation type, based on the name of the service */
    method protected Progress.Lang.Class getImplementationType(input pService as Progress.Lang.Class):
        define variable implType as Progress.Lang.Class no-undo.
        define variable className as character no-undo.
        
        className = entry(num-entries(pService:TypeName, '.'), pService:TypeName, '.').
        
        if     pService:IsInterface()
           and className begins 'I'
        then
            implType = Progress.Lang.Class:GetClass(pService:Package + '.'
                                                    // convert Ccs.ServiceManager.IRequestScope to RequestScope
                                                    + substring(className, 2)).
        else
            implType = pService.
        
        return implType.
    end method.

    method override public Progress.Lang.Object getService( input pService as Progress.Lang.Class ):
        define variable svc as Progress.Lang.Object no-undo.
        
        Assert:NotNull(pService, 'Service type').
        
        // we may have cached this at a broader scope
        svc = retrieveFromCache(pService, ?, get-class(ITransientScope)).
        if valid-object(svc) then
            return svc.
        
        svc = getProvider(?):invokeService(getImplementationType(pService), ?).
        
        Assert:IsType(svc, pService).
        
        // we don't cache Transient scoped objects
        
        return svc.
    end method.
    
    method override public Progress.Lang.Object getService(input pService as Progress.Lang.Class,
                                                           input pAlias as character):
        define variable svc as Progress.Lang.Object no-undo.
        
        Assert:NotNull(pService, 'Service type').
        
        // we may have cached this at a broader scope
        svc = retrieveFromCache(pService, pAlias, get-class(ITransientScope)).
        if valid-object(svc) then
            return svc.
        
        svc = getProvider(?):invokeService(getImplementationType(pService), ?).
        
        Assert:IsType(svc, pService).
        
        // we don't cache Transient scoped objects
        
        return svc.
    end method.
    
    method override public Progress.Lang.Object getService(input pService as Progress.Lang.Class,
                                                           input pScope as ILifecycleScope):
        define variable svc as Progress.Lang.Object no-undo.
        
        Assert:NotNull(pService, 'Service type').
        
        // we may have cached this at this or a broader scope
        svc = retrieveFromCache(pService, ?, pScope:GetClass()).
        if valid-object(svc) then
            return svc.
        
        svc = getProvider(?):invokeService(getImplementationType(pService), ?).
        
        Assert:IsType(svc, pService).
        
        cacheService(pService,
                     ?,     //alias
                     pScope:GetClass(),
                     svc).
        
        return svc.
    end method.

end class.