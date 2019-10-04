/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/ 
 /*------------------------------------------------------------------------
    File        : ConfigFileSvcMgr
    Description : 
    Author(s)   : pjudge
    Notes       : 
  ----------------------------------------------------------------------*/
block-level on error undo, throw.

using 4GlFanatics.ServiceManager.AbstractServiceManager.
using Ccs.ServiceManager.IContainerScope.
using Ccs.ServiceManager.ILifecycleScope.
using Ccs.ServiceManager.IRequestScope.
using Ccs.ServiceManager.ISessionScope.
using Ccs.ServiceManager.ITransientScope.
using OpenEdge.Core.Assert.
using OpenEdge.Core.String.
using Progress.Json.ObjectModel.JsonArray.
using Progress.Json.ObjectModel.JsonDataType.
using Progress.Json.ObjectModel.JsonObject.
using Progress.Json.ObjectModel.ObjectModelParser.

class 4GlFanatics.ServiceManager.ConfigFileSvcMgr inherits AbstractServiceManager:
    
    // this could be made into an ENUM
    define private variable mClientType as character no-undo.
    
    //this data can come from a file, from a DB table
    define private temp-table svcRegistry no-undo
        field svcName         as character
        field svcAlias        as character initial ?
        field svcScope        as character
        field implType        as character
        field providerType    as character initial ?
        field providerContext as Progress.Lang.Object
        
        index idx1 svcName svcAlias svcScope. 
    
    /* Default contructor */
    constructor public ConfigFileSvcMgr():
        if session:client-type eq '4GLCLIENT' then
        case session:window-system:
            when 'tty' then
                mClientType = 'tty'.
            otherwise 
                mClientType = 'gui'.
        end case.
        else
            mClientType = 'web'.
    end constructor.
    
    /* Constructor 
       
       @param character The client type for which to find services. This CTOR allows mocking etc */
    constructor public ConfigFileSvcMgr(input pClientType as character):
        super(). 
        
        assign mClientType = pClientType.
    end constructor.
    
    destructor ConfigFileSvcMgr():
        dispose().
    end destructor.
    
    /* Loads services from a JSON file */
    method override public void initialize( ):
        define variable configFile as character no-undo.
        define variable svcData as JsonArray no-undo.
        define variable loop as integer no-undo.
        define variable cnt as integer no-undo.
        define variable svc as JsonObject no-undo.
        define variable provider as JsonObject no-undo.
        
        define buffer registry for svcRegistry.
        
        super:initialize().
        
        configFile = substitute('cfg/&1.services.json', mClientType).
        
        svcData = cast(new ObjectModelParser():ParseFile(configFile), JsonArray).
        
        // in case 
        if not valid-object(svcData) then
            return.
        
        cnt = svcData:Length.
        do loop = 1 to cnt:
            if not svcData:GetType(loop) eq JsonDataType:OBJECT then
                next.
            
            svc = svcData:GetJsonObject(loop).
            
            create registry.
            registry.svcName = svc:GetCharacter('service').
            
            // The service may be a concrete implementation
            if     svc:Has('implementation')
               and svc:GetType('implementation') eq JsonDataType:STRING
            then
                registry.implType = svc:GetCharacter('implementation').
            else
                registry.implType = registry.svcName. 
            
            if     svc:Has('alias') 
               and svc:GetType('alias') eq JsonDataType:STRING
            then
                registry.svcAlias = svc:GetCharacter('alias').
            
            if     svc:Has('scope') 
               and svc:GetType('scope') eq JsonDataType:STRING
            then
                registry.svcScope = svc:GetCharacter('scope').
            else
                registry.svcScope = get-class(ITransientScope):TypeName.
            
            if svc:Has('provider') then
            case svc:GetType('provider'):
                when JsonDataType:STRING then
                    registry.providerType = svc:GetCharacter('provider').
                when JsonDataType:OBJECT then
                do:
                    provider = svc:GetJsonObject('provider').
                    registry.providerType = provider:GetCharacter('type').
                    
                    if provider:Has('context') then
                    case provider:GetType('context'):
                        when JsonDataType:ARRAY then 
                            registry.providerContext = provider:GetJsonArray('context'). 
                        when JsonDataType:OBJECT then 
                            registry.providerContext = provider:GetJsonObject('context'). 
                        when JsonDataType:NULL then
                            /*NO-OP*/ . 
                        otherwise
                            registry.providerContext = new String(provider:GetJsonText('context')).
                    end case. 
                end.    // provider=JsonObject
            end case.
        end.
    end method.
    
    method override public void dispose():
        empty temp-table svcRegistry.
        
        super:dispose().
    end method.
    
    method private void FindRegistry(input pService as Progress.Lang.Class,
                                     input pAlias as character,
                                     buffer pRegistry for svcRegistry):
        release pRegistry.
        
        find pRegistry
        where pRegistry.svcName  eq pService:TypeName
          and pRegistry.svcAlias eq pAlias
          and pRegistry.svcScope eq get-class(ITransientScope):TypeName
        no-error.
        
        if not available pRegistry then
            find pRegistry
            where pRegistry.svcName  eq pService:TypeName
              and pRegistry.svcAlias eq pAlias
              and pRegistry.svcScope eq get-class(IRequestScope):TypeName
            no-error.
        
        if not available pRegistry then
            find pRegistry
            where pRegistry.svcName  eq pService:TypeName
              and pRegistry.svcAlias eq pAlias
              and pRegistry.svcScope eq get-class(IContainerScope):TypeName
            no-error.
        
        if not available pRegistry then
            find pRegistry
            where pRegistry.svcName  eq pService:TypeName
              and pRegistry.svcAlias eq pAlias
              and pRegistry.svcScope eq get-class(ISessionScope):TypeName
            no-error.
        
        if not available pRegistry then
            find pRegistry
            where pRegistry.svcName  eq pService:TypeName
              and pRegistry.svcAlias eq pAlias
              and pRegistry.svcScope eq get-class(ILifecycleScope):TypeName
            no-error.
    end method.
    
    method override public Progress.Lang.Object getService(input pService as Progress.Lang.Class):
        define variable svc as Progress.Lang.Object no-undo.
        define variable scopeType as Progress.Lang.Class no-undo.
        
        define buffer registry for svcRegistry.
        
        Assert:NotNull(pService, 'Service type').
        
        FindRegistry(pService, ?, buffer registry).
        if not available registry then
            return svc.
        
        scopeType = Progress.Lang.Class:GetClass(registry.svcScope).
        
        // we may have cached this
        svc = retrieveFromCache(pService, ?, scopeType).
        if valid-object(svc) then
            return svc.
        
        svc = getProvider(registry.providerType)
                :invokeService(Progress.Lang.Class:GetClass(registry.implType),
                               registry.providerContext).
        
        Assert:IsType(svc, pService).
        
        cacheService(pService,
                     ?,     //alias
                     scopeType,
                     svc).
        
        return svc.
    end method.
    
    method override public Progress.Lang.Object getService(input pService as Progress.Lang.Class,
                                                           input pAlias as character):
        define variable svc as Progress.Lang.Object no-undo.
        define variable scopeType as Progress.Lang.Class no-undo.
        
        define buffer registry for svcRegistry.
        
        FindRegistry(pService, pAlias, buffer registry).
        if not available registry then
            return svc.
        
        scopeType = Progress.Lang.Class:GetClass(registry.svcScope).
        // we may have cached this
        svc = retrieveFromCache(pService, pAlias, scopeType).
        if valid-object(svc) then
            return svc.
        
        svc = getProvider(registry.providerType)
                :invokeService(Progress.Lang.Class:GetClass(registry.implType),
                               registry.providerContext).
        
        Assert:IsType(svc, pService).
        
        cacheService(pService,
                     pAlias,
                     scopeType,
                     svc).
        
        return svc.
    end method.
    
    method public override Progress.Lang.Object getService(input pService as Progress.Lang.Class,
                                                           input pScope as ILifecycleScope ):
        // This implementation uses the config-file's SCOPE and not the input value
        return this-object:getService(pService).
    end method.
    
end class.