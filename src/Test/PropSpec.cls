/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/
/*------------------------------------------------------------------------
    File        : PropSpec
    Description : 
    Author(s)   : pjudge
    Notes       : 
  ----------------------------------------------------------------------*/
block-level on error undo, throw.

USING 4GlFanatics.UI.* FROM PROPATH.

class Test.PropSpec implements IPropertySpec: 
    
    define public property Name as character no-undo get. set.  
    define public property Label as character no-undo get. set.
    define public property ControlType as ControlTypeEnum no-undo get. set.
    define public property ReadOnly as logical no-undo get. set.
    
end class.