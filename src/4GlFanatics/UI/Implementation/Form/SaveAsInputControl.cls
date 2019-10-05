/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/  
/*------------------------------------------------------------------------
    File        : SaveAsInputControl
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

CLASS 4GlFanatics.UI.Implementation.Form.SaveAsInputControl
    INHERITS UltraTextEditor
    IMPLEMENTS IInputFormControl: 

    DEFINE VARIABLE cLabel AS CHARACTER NO-UNDO.

    /**
     * Purpose: Constructor for the SaveAsInputControl class
     * Notes:
     */
    CONSTRUCTOR PUBLIC SaveAsInputControl (pcLabel AS CHARACTER):

        DEFINE VARIABLE editorButton AS EditorButton NO-UNDO.

        THIS-OBJECT:Anchor = CAST (EnumHelper:Or (EnumHelper:Or (AnchorStyles:Top, 
                                                                 AnchorStyles:Left), 
                                                                 AnchorStyles:Right), AnchorStyles) .

        editorButton = NEW Infragistics.Win.UltraWinEditors.EditorButton ().
        editorButton:Key = "":U .
        editorButton:Text = "...":U.

        THIS-OBJECT:ButtonsRight:Add (editorButton).
        
        ASSIGN cLabel = pcLabel . 
        
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

        DYNAMIC-PROPERTY (poObject, pcPropertyName) = THIS-OBJECT:Text .

    END METHOD.

    /**
     * Purpose: Reads a property of the input value object and assigns it to
     *          the Control input
     * Notes:
     * @param poObject The value object
     * @param pcPropertyName The name of the object property to display
     */
    METHOD PUBLIC VOID DisplayPropertyValue (poObject AS Progress.Lang.Object, pcPropertyName AS CHARACTER):

        THIS-OBJECT:Text = DYNAMIC-PROPERTY (poObject, pcPropertyName) .

    END METHOD.
    
    /*------------------------------------------------------------------------------
        Purpose: Raises the EditorButtonClick event
        Notes:
        @param e The EditorButtonEventArgs with the data for this event
    ------------------------------------------------------------------------------*/
    METHOD PROTECTED OVERRIDE VOID OnEditorButtonClick (e AS Infragistics.Win.UltraWinEditors.EditorButtonEventArgs):
    
        DEFINE VARIABLE oSaveAsDialog AS SaveFileDialog                    NO-UNDO .
        DEFINE VARIABLE oForm         AS System.Windows.Forms.Form         NO-UNDO . 
        DEFINE VARIABLE oDialogResult AS System.Windows.Forms.DialogResult NO-UNDO . 
        
        oForm = THIS-OBJECT:FindForm () . 
        
        oSaveAsDialog = NEW SaveFileDialog () .
        oSaveAsDialog:AddExtension = TRUE . 
        oSaveAsDialog:CheckPathExists = TRUE . 
        oSaveAsDialog:DefaultExt = "pdf" .
        oSaveAsDialog:FileName = THIS-OBJECT:Text .
        oSaveAsDialog:Filter = "pdf Files|*.pdf|All Files|*.*" .
        oSaveAsDialog:OverwritePrompt = TRUE .
        oSaveAsDialog:RestoreDirectory = TRUE.
        oSaveAsDialog:Title = SUBSTITUTE ("Save &1", cLabel) .
    
        WAIT-FOR oSaveAsDialog:ShowDialog (oForm) SET oDialogResult .
    
        IF oDialogResult = DialogResult:OK THEN 
            ASSIGN THIS-OBJECT:Text = oSaveAsDialog:FileName . 
    
    END METHOD . 
    
END CLASS.
