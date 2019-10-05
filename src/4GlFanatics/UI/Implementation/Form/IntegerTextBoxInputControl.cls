/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/  
/*------------------------------------------------------------------------
    File        : TextBoxInputControl
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Mike Fechner / Consultingwerk Ltd.
    Created     : Sat Oct 05 13:30:45 CEST 2019
    Notes       : 
  ----------------------------------------------------------------------*/

USING 4GlFanatics.UI.Implementation.Form.* FROM PROPATH.
USING Infragistics.Win.UltraWinEditors.* FROM ASSEMBLY.
USING Progress.Lang.*.
USING System.Windows.Forms.* FROM ASSEMBLY.
USING Progress.Util.* FROM ASSEMBLY.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS 4GlFanatics.UI.Implementation.Form.IntegerTextBoxInputControl
    INHERITS UltraNumericEditor
    IMPLEMENTS IInputFormControl: 

    /**
     * Purpose: Constructor for the TextBoxInputControl class
     * Notes:
     */
    CONSTRUCTOR PUBLIC IntegerTextBoxInputControl ():

        THIS-OBJECT:Anchor = CAST (EnumHelper:Or (EnumHelper:Or (AnchorStyles:Top, 
                                                                 AnchorStyles:Left), 
                                                                 AnchorStyles:Right), AnchorStyles) .

        THIS-OBJECT:NumericType = NumericType:Integer.

    END CONSTRUCTOR.

    /**
     * Purpose: Assigns the current Control input value to a property of the
     *          value object
     * Notes:
     * @param poObject The value object
     * @param pcPropertyName The name of the object property to display
     */
    METHOD PUBLIC VOID AssignPropertyValue (poObject AS Progress.Lang.Object,
                                            pcPropertyName AS CHARACTER):

        DYNAMIC-PROPERTY (poObject, pcPropertyName) = TRIM (THIS-OBJECT:Text, THIS-OBJECT:PromptChar) .

    END METHOD.

    /**
     * Purpose: Reads a property of the input value object and assigns it to
     *          the Control input
     * Notes:
     * @param poObject The value object
     * @param pcPropertyName The name of the object property to display
     */
    METHOD PUBLIC VOID DisplayPropertyValue (poObject AS Progress.Lang.Object, pcPropertyName AS CHARACTER):

        THIS-OBJECT:Value = BOX (DYNAMIC-PROPERTY (poObject, pcPropertyName)) .

    END METHOD.
    
END CLASS.
