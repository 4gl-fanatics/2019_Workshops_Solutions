/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/  
/*------------------------------------------------------------------------
    File        : InputFormHelper
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Mike Fechner / Consultingwerk Ltd.
    Created     : Sat Oct 05 12:27:14 CEST 2019
    Notes       : 
  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING 4GlFanatics.UI.*                     FROM PROPATH .
USING 4GlFanatics.UI.Implementation.*      FROM PROPATH .
USING 4GlFanatics.UI.Implementation.Form.* FROM PROPATH.
USING Progress.Lang.*                      FROM PROPATH .
USING System.Windows.Forms.*               FROM ASSEMBLY .

CLASS 4GlFanatics.UI.Implementation.GuiInputFormHelper 
    IMPLEMENTS IInputFormHelper: 

    METHOD PUBLIC DialogResultEnum PerformInput (pcTitle AS CHARACTER,
                                                 poValueObject AS Progress.Lang.Object,
                                                 poPropertySpecs AS IPropertySpec EXTENT,
                                                 poValidator AS IInputValidator):

        DEFINE VARIABLE oForm         AS InputFormDialog  NO-UNDO .
        DEFINE VARIABLE oDialogResult AS DialogResult     NO-UNDO .

        oForm = NEW InputFormDialog () .

        oForm:Text = pcTitle .
        oForm:SetProperties (poValueObject, poPropertySpecs, poValidator) .

        WAIT-FOR oForm:ShowDialog () SET oDialogResult .

        IF oDialogResult = DialogResult:OK THEN 
            RETURN DialogResultEnum:OK .

        RETURN DialogResultEnum:Cancel .

    END METHOD . 

END CLASS.
