/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/  
/*------------------------------------------------------------------------
    File        : DateTextBoxInputControl
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

CLASS 4GlFanatics.UI.Implementation.Form.DateTextBoxInputControl
    INHERITS UltraDateTimeEditor
    IMPLEMENTS IInputFormControl: 

    /**
     * Purpose: Constructor for the DateTextBoxInputControl class
     * Notes:
     */
    CONSTRUCTOR PUBLIC DateTextBoxInputControl ():

        THIS-OBJECT:Anchor = CAST (EnumHelper:Or (EnumHelper:Or (AnchorStyles:Top, 
                                                                 AnchorStyles:Left), 
                                                                 AnchorStyles:Right), AnchorStyles) .


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

        DYNAMIC-PROPERTY (poObject, pcPropertyName) = date(this-object:DateTime).
    END METHOD.

    /**
     * Purpose: Reads a property of the input value object and assigns it to
     *          the Control input
     * Notes:
     * @param poObject The value object
     * @param pcPropertyName The name of the object property to display
     */
    METHOD PUBLIC VOID DisplayPropertyValue (poObject AS Progress.Lang.Object, pcPropertyName AS CHARACTER):

        DEFINE VARIABLE dtDate AS DATE NO-UNDO.

        dtDate = DYNAMIC-PROPERTY (poObject, pcPropertyName) .
        
        THIS-OBJECT:Value = BOX (dtDate) .

    END METHOD.
    
END CLASS.
