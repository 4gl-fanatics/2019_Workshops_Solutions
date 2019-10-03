/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/ 
/*------------------------------------------------------------------------
    File        : RequestScope
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : pjudge
    Created     : Wed Oct 02 11:16:03 EDT 2019
    Notes       : 
  ----------------------------------------------------------------------*/
block-level on error undo, throw.

using Ccs.ServiceManager.IRequestScope.

class 4GlFanatics.ServiceManager.Scope.RequestScope implements IRequestScope:
    
    method public Progress.Lang.Object getScope():
        define variable reqId as character no-undo.
        
        reqId = session:current-request-info:RequestId.
        
        return new OpenEdge.Core.String(reqId).
    end method.
    
end class.