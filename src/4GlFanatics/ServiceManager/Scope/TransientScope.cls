/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/ 
/*------------------------------------------------------------------------
    File        : TransientScope
    Description : Returns a null ("nothing").
    Author(s)   : pjudge
    Notes       : 
  ----------------------------------------------------------------------*/
block-level on error undo, throw.

using Ccs.ServiceManager.ITransientScope.

class 4GlFanatics.ServiceManager.Scope.TransientScope implements ITransientScope:
    
    method public Progress.Lang.Object getScope():
        return ?.
    end method.

end class.