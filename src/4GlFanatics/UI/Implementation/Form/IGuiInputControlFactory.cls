/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/
/*------------------------------------------------------------------------
    File        : IGuiInputControlFactory
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Mike Fechner / Consultingwerk Ltd.
    Created     : Sat Oct 05 13:37:02 CEST 2019
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING 4GlFanatics.UI.* FROM PROPATH.

INTERFACE 4GlFanatics.UI.Implementation.Form.IGuiInputControlFactory:  

    /*------------------------------------------------------------------------------
       Purpose:
       Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC System.Windows.Forms.Control CreateInputControl (poValueObjectType AS Progress.Lang.Class,
                                                                   poPropertySpec AS IPropertySpec).

END INTERFACE.
