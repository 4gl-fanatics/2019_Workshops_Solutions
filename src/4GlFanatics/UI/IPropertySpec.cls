/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/
/*------------------------------------------------------------------------
    File        : IPropertySpec
    Description : 
    Author(s)   : pjudge
    Notes       : 
  ----------------------------------------------------------------------*/
  
USING 4GlFanatics.UI.* FROM PROPATH . 
  
INTERFACE 4GlFanatics.UI.IPropertySpec:
    
    DEFINE PUBLIC PROPERTY Name         AS CHARACTER       NO-UNDO GET. SET.  
    DEFINE PUBLIC PROPERTY Label        AS CHARACTER       NO-UNDO GET. SET.
    DEFINE PUBLIC PROPERTY ReadOnly     AS LOGICAL         NO-UNDO GET. SET.
    DEFINE PUBLIC PROPERTY ControlType  AS ControlTypeEnum NO-UNDO GET. SET.

END INTERFACE.
