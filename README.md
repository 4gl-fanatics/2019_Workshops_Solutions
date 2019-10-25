# 2019_Workshops_Solutions
This project contains example solutions for the starting code in https://github.com/4gl-fanatics/2019_Workshops_Before .


### 1. Input Form Helper


### 2. Service Manager
There are a couple of Service Manager implementations in this project, along with support code.


Additional file name | Commments 
---- | ----
session_start.p | Session startup procedure that starts a Service Manager, and assigns it to the global `Ccs.Common.Application:ServiceManager` property.
get-service.i  | An include to get a service and cast it to the service type


Service Manager Type | Commments 
---- | ----
4GlFanatics.ServiceManager.AbstractServiceManager | Base/parent that performs scope/cache management
4GlFanatics.ServiceManager.ConfConfigFileSvcMgr | Reads config from JSON (named `cfg/<abl-client-type>.services.json`.
4GlFanatics.ServiceManager.NameConventionSvcMgr | Uses a name convention to turn services into implementing classes. Takes the interface/service package name and appends `.implementation.` . Assumes interface names begins with `I`


Provider Type | Commments 
---- | ----
4GlFanatics.ServiceManager.Provider.DefaultConstructorProvider | Uses the default constructor
4GlFanatics.ServiceManager.Provider.LongestConstructorProvider | Reads all constructors via reflection and uses the constructor with the most input parameters that are class-based (so that the inputs can themselves be resolved using a Service manager)
4GlFanatics.ServiceManager.Provider.ConfiguredConstructorProvider | Reads Provider data from the JSON configuration, so that constructors with primitive or array parameters can be used
