/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/ 
/*------------------------------------------------------------------------
    File        : session_start.p
    Description : 
    Author(s)   : pjudge
    Notes       :
  ----------------------------------------------------------------------*/
block-level on error undo, throw.

/* ***************************  Main Block  *************************** */
Ccs.Common.Application:ServiceManager = new 4GlFanatics.ServiceManager.ConfigFileSvcMgr().
Ccs.Common.Application:ServiceManager:initialize().

/* EOF */