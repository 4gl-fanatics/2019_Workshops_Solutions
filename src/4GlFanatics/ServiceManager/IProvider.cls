/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/
/*------------------------------------------------------------------------
    File        : IProvider
    Description : 
    Author(s)   : pjudge
    Notes       : 
  ----------------------------------------------------------------------*/
interface 4GlFanatics.ServiceManager.IProvider:  
    /* Instantiates (NEWs) a class.
       
       The type cannot be ABSTRACT or an INTERFACE
       
       @param  Progress.Lang.Class  The Type to instantiate
       @param  Progress.Lang.Object Context for the provider; use depends on the implementation 
       @return Progress.Lang.Object An object of that type */
    method public Progress.Lang.Object invokeService(input pImplType as Progress.Lang.Class,
                                                     input pContext as Progress.Lang.Object).
  
end interface.