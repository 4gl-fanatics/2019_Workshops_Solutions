/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/ 
/*------------------------------------------------------------------------
    File        : SessionScope
    Description : Returns an integer value representing the session; if this 
                  session isn't in an AppServer, then  returns 42.  
    Author(s)   : pjudge
    Notes       : 
  ----------------------------------------------------------------------*/
block-level on error undo, throw.

using Ccs.ServiceManager.ISessionScope.

class 4GlFanatics.ServiceManager.Scope.SessionScope implements ISessionScope:
    
    method public Progress.Lang.Object getScope():
        define variable sessionId as integer no-undo.
        
        sessionId = session:current-request-info:SessionId.
        if sessionId eq ? then
            sessionId = 42.
        
        return new OpenEdge.Core.Integer(sessionId).
    end method.
    
end class.