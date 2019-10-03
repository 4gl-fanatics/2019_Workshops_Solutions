/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/ 
/*------------------------------------------------------------------------
    File        : ServiceManagerScope 
    Description : Scope for objects that are part of a Service Manager's lifecycle
    Author(s)   : pjudge
    Notes       : 
  ----------------------------------------------------------------------*/
block-level on error undo, throw.

using Ccs.Common.IServiceManager.
using Ccs.ServiceManager.IContainerScope.

class 4GlFanatics.ServiceManager.Scope.ServiceManagerScope implements IContainerScope:
    
    method public Progress.Lang.Object getScope():
        return get-class(IServiceManager).
    end method.
    
end class.