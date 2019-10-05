/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/
/*------------------------------------------------------------------------
    File        : IInputFormControl
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Mike Fechner / Consultingwerk Ltd.
    Created     : Sat Oct 05 13:07:41 CEST 2019
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

INTERFACE 4GlFanatics.UI.Implementation.Form.IInputFormControl:  

    /**
     * Purpose: Assigns the current Control input value to a property of the
     *          value object
     * Notes:
     * @param poObject The value object
     * @param pcPropertyName The name of the object property to display
     */
    METHOD PUBLIC VOID AssignPropertyValue (poObject AS Progress.Lang.Object,
                                            pcPropertyName AS CHARACTER).

    /**
     * Purpose: Reads a property of the input value object and assigns it to
     *          the Control input
     * Notes:
     * @param poObject The value object
     * @param pcPropertyName The name of the object property to display
     */
    METHOD PUBLIC VOID DisplayPropertyValue (poObject AS Progress.Lang.Object,
                                             pcPropertyName AS CHARACTER).
  
END INTERFACE.
