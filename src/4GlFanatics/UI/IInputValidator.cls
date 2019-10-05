/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/
/*------------------------------------------------------------------------
    File        : IInputValidator
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Mike Fechner / Consultingwerk Ltd.
    Created     : Thu Oct 03 09:08:28 EDT 2019
    Notes       : 
  ----------------------------------------------------------------------*/
  
INTERFACE 4GlFanatics.UI.IInputValidator:  

    /**
     * Purpose: Validates the properties of the given value object
     * Notes:
     * @param poValueObject The value object to validate
     * @return Logical value indicating if the object's properties are valid
     */
    METHOD PUBLIC LOGICAL IsValid (poValueObject AS Progress.Lang.Object).

END INTERFACE.
