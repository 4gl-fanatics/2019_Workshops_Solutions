/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/
 /*------------------------------------------------------------------------
    File        : AbstractServiceManager
    Description : An abstract service manager that can cache implementations per scope 
    Author(s)   : pjudge
    Notes       : 
  ----------------------------------------------------------------------*/
block-level on error undo, throw.

using 4GlFanatics.ServiceManager.IProvider.
using 4GlFanatics.ServiceManager.Provider.DefaultConstructorProvider.
using Ccs.Common.IService.
using Ccs.Common.IServiceManager.
using Ccs.ServiceManager.IContainerScope.
using Ccs.ServiceManager.ILifecycleScope.
using Ccs.ServiceManager.IRequestScope.
using Ccs.ServiceManager.ISessionScope.
using Ccs.ServiceManager.ITransientScope.
using OpenEdge.Core.Assert.
using 4GlFanatics.ServiceManager.Scope.ServiceManagerScope.

class 4GlFanatics.ServiceManager.AbstractServiceManager abstract
                implements IServiceManager:
    
    define public property DefaultProvider as IProvider no-undo
        get.
        set.
    
    define private temp-table serviceCache no-undo
        field svcName  as character
        field svcAlias as character initial ?
        field svcScope as integer   initial 1   //TRANSIENT
        
        field impl    as Progress.Lang.Object   serialize-hidden
        
        index idx1 svcName svcAlias svcScope
        index idx2 svcScope
        .
    
    /* Default constructor */
    constructor public AbstractServiceManager ():
        // pick a default
        DefaultProvider = new DefaultConstructorProvider().
    end constructor.
    
    method public void initialize():
    end method.
    
    method public void dispose():
        define buffer cache for serviceCache.
        define query qCache for cache.
        
        open query qCache preselect each cache.
        get first qCache.
        do while not query qCache:query-off-end:
            destroyService(cache.impl).
            
            get next qCache.
        end.
    end method.
    
    method protected void destroyService(input pService as Progress.Lang.Object):
        if not valid-object(pService) then
            return.
        
        if type-of(pService, IService) then
            cast(pService, IService):dispose().
        
        delete object pService.
    end method.
    
    method protected IProvider getProvider(input pProviderType as character):
        define variable provider as Progress.Lang.Object no-undo.
        define variable providerType as Progress.Lang.Class no-undo.
        
        providerType = Progress.Lang.Class:GetClass(pProviderType) no-error.
        if error-status:error then
            assign provider           = DefaultProvider
                   error-status:error = false
                   .
        else
        do:
            provider = retrieveFromCache(get-class(IProvider), pProviderType, get-class(ServiceManagerScope)).
            if not valid-object(provider) then
            do:
                Assert:IsType(providerType, get-class(IProvider)).
                
                provider = providerType:New().
                
                // the service manager is the container in this case.
                cacheService(get-class(IProvider), pProviderType, get-class(ServiceManagerScope), provider).
            end.
        end.
        
        return cast(provider, IProvider).
    end method.
    
    method private integer getScopeIndex(input pScopeType as Progress.Lang.Class):
        if valid-object(pScopeType) then
        case true:
            when pScopeType:IsA(get-class(ITransientScope)) then return  1.
            when pScopeType:IsA(get-class(IRequestScope))   then return  2.
            when pScopeType:IsA(get-class(ISessionScope))   then return  3.
            when pScopeType:IsA(get-class(IContainerScope)) then return  4.
            otherwise                                            return  5.
        end.
        else
            return  1.
    end method.
    
    /* Retrieves a service implementation from the cache
       
       If an alias is provided then we look for service+alias
       
       Scope breadth is (in decreasing order)
                Ccs.ServiceManager.IContainerScope
                Ccs.ServiceManager.ISessionScope
                Ccs.ServiceManager.IRequestScope
                Ccs.ServiceManager.ITransientScope (same as no scope)
       If a scope is provided, look for a service of that scope or broader. 
       
       @param Progress.Lang.Class The service
       @param ILifecycleScope A optional scope
       @param character An optional alias
       @return Progress.Lang.Object An implementation of the service */
    method protected Progress.Lang.Object retrieveFromCache(input pService as Progress.Lang.Class,
                                                            input pAlias as character,
                                                            input pScopeType as Progress.Lang.Class):
        define variable idx as integer no-undo.
        define buffer cache for serviceCache.
        
        Assert:NotNull(pService, 'Service type').
        Assert:IsType(pScopeType, get-class(ILifecycleScope)).
        
        find first cache
             where cache.svcName  eq pService:TypeName
               and cache.svcAlias eq pAlias
               and cache.svcScope ge getScopeIndex(pScopeType)
               no-error.
        
        if available cache then
            return cache.impl.
        
        return ?.
    end method.
    
    method protected void cacheService(input pService as Progress.Lang.Class,
                                       input pAlias as character,
                                       input pScopeType as Progress.Lang.Class,
                                       input pImplementation as Progress.Lang.Object ):
        define variable idx as integer no-undo.
        define buffer cache for serviceCache.
        
        Assert:NotNull(pService, 'Service type').
        Assert:NotNull(pImplementation, 'Service implementation').
        Assert:IsType(pScopeType, get-class(ILifecycleScope)).
        
        idx = getScopeIndex(pScopeType).
        
        // don't cache transient scopes 
        if    idx eq 1
           or idx eq ?
        then
            return.
        
        find  cache
        where cache.svcName  eq pService:TypeName 
          and cache.svcScope eq idx 
          and cache.svcAlias eq pAlias
          no-error.
        if not available cache then
        do:
            create cache.
            assign cache.svcName  = pService:TypeName
                   cache.svcScope = idx
                   cache.svcAlias = pAlias
                   cache.impl     = pImplementation
                   .
        end.
    end method.
    
    method abstract public Progress.Lang.Object getService(input pService as Progress.Lang.Class).
    
    method abstract public Progress.Lang.Object getService(input pService as Progress.Lang.Class,
                                                           input pScope as ILifecycleScope ).
    
    method abstract public Progress.Lang.Object getService(input pService as Progress.Lang.Class,
                                                           input pAlias as character ).
    
    method public void stopServices( input pScope as ILifecycleScope ):
        define variable scopeIdx as integer no-undo.
        
        Assert:NotNull(pScope, 'Service scope').
        
        define buffer cache for serviceCache.
        define query qryCache for cache.
        
        case true:
            when type-of(pScope, ITransientScope) then scopeIdx = 1.
            when type-of(pScope, IRequestScope)   then scopeIdx = 2.
            when type-of(pScope, ISessionScope)   then scopeIdx = 3.
            when type-of(pScope, IContainerScope) then scopeIdx = 4.
            otherwise                                  scopeIdx = 5.
        end.
        
        open query qryCache preselect each cache where cache.svcScope eq scopeIdx.
        
        get first qryCache.
        do while not query qryCache:query-off-end:
            destroyService(cache.impl).
            
            get next qryCache.
        end.
    end method.
    
end class.