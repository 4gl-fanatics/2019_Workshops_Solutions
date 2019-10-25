/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/
/*------------------------------------------------------------------------
    File        : InputFormDialog
    Purpose     : Dialog Form used by the GuiInputFormHelper:PerformInput
                  method
    Syntax      :
    Description :
    Author(s)   : Mike Fechner / Consultingwerk Ltd.
    Created     : Sat Jul 21 16:21:21 CEST 2018
    Notes       :
  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Infragistics.Win.Misc.*                                 FROM ASSEMBLY.
USING Progress.Lang.*                                         FROM PROPATH .
USING 4GlFanatics.UI.*                                        FROM PROPATH.
USING 4GlFanatics.UI.Implementation.Form.*                    FROM PROPATH.
USING 4GlFanatics.UI.Util.* FROM PROPATH.
using Infragistics.Win.UltraWinEditors.UltraTextEditor.
using Infragistics.Win.UltraWinEditors.UltraNumericEditor.
using Infragistics.Win.UltraWinEditors.UltraDateTimeEditor.

CLASS 4GlFanatics.UI.Implementation.Form.InputFormDialog
    INHERITS Progress.Windows.Form:

    DEFINE PRIVATE VARIABLE btnOK AS Infragistics.Win.Misc.UltraButton NO-UNDO.
    DEFINE PRIVATE VARIABLE btnCancel AS Infragistics.Win.Misc.UltraButton NO-UNDO.
    DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE panel1 AS System.Windows.Forms.Panel NO-UNDO.

    DEFINE VARIABLE oValueObject      AS Progress.Lang.Object                NO-UNDO .
    DEFINE VARIABLE oPropertyControls AS IInputFormControl            EXTENT NO-UNDO .
    DEFINE VARIABLE oPropertySpecs    AS IPropertySpec                EXTENT NO-UNDO . 
    DEFINE VARIABLE oValidator        AS IInputValidator                     NO-UNDO .

    /**
     * Purpose: Constructor for the InputFormDialog class
     * Notes:
     */
    CONSTRUCTOR PUBLIC InputFormDialog ():

        SUPER().

        InitializeComponent().

        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.

    END CONSTRUCTOR.

    /**
     * Purpose: Assign's the object's properties
     * Notes:
     */
    METHOD PUBLIC VOID AssignProperites ():

        DEFINE VARIABLE i AS INTEGER NO-UNDO.

        DO i = 1 TO EXTENT (oPropertyControls):
            oPropertyControls[i]:AssignPropertyValue (oValueObject, oPropertySpecs[i]:Name) .
        END.

    END METHOD.

    /**
     * Purpose: Event handler for the Click event of the btnOK
     * Notes:
     * @param sender The reference to the object that raised the event
     * @param e The System.EventArgs with the data for this event
     */
    METHOD PRIVATE VOID btnOK_Click (sender AS System.Object,
                                     e AS System.EventArgs):

        THIS-OBJECT:AssignProperites() .

        CATCH err AS Progress.Lang.Error:
            MESSAGE err:GetMessage(1)
                VIEW-AS ALERT-BOX ERROR .
        END CATCH.

    END METHOD.

    /*------------------------------------------------------------------------------
       Purpose:
       Notes:
    ------------------------------------------------------------------------------*/
    METHOD PROTECTED System.Windows.Forms.Control CreateControl (poValueObjectType AS Progress.Lang.Class,
                                                                 poPropertySpec AS IPropertySpec):
        DEFINE VARIABLE oFactory AS IGuiInputControlFactory      NO-UNDO.
        
        oFactory = {get-service.i IGuiInputControlFactory}.

        RETURN oFactory:CreateInputControl (poValueObjectType, poPropertySpec) .
    END METHOD.

    /**
     * Purpose: Displays the object's properties
     * Notes:
     */
    METHOD PUBLIC VOID DisplayProperites ():

        DEFINE VARIABLE i AS INTEGER NO-UNDO.

        DO i = 1 TO EXTENT (oPropertyControls):
            oPropertyControls[i]:DisplayPropertyValue(oValueObject, oPropertySpecs[i]:Name) .
        END.

    END METHOD.

    /**
     * Purpose: Initializes the Visual Design
     * Notes:
     */
    @InitializeComponent.
    METHOD PRIVATE VOID InitializeComponent ():

        /* NOTE: The following method is automatically generated.

        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.

        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        @VisualDesigner.FormMember (NeedsInitialize="true":U).
        DEFINE VARIABLE resources AS Progress.Util.ResourceManager NO-UNDO.
        resources = NEW Progress.Util.ResourceManager("4GlFanatics.UI.Implementation.Form.InputFormDialog":U).
        THIS-OBJECT:btnOK = NEW Infragistics.Win.Misc.UltraButton().
        THIS-OBJECT:btnCancel = NEW Infragistics.Win.Misc.UltraButton().
        THIS-OBJECT:panel1 = NEW System.Windows.Forms.Panel().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* btnOK */
        /*  */
        resources:ApplyResources(THIS-OBJECT:btnOK, "btnOK":U).
        THIS-OBJECT:btnOK:DialogResult = System.Windows.Forms.DialogResult:OK.
        THIS-OBJECT:btnOK:Name = "btnOK":U.
        THIS-OBJECT:btnOK:Click:Subscribe(THIS-OBJECT:btnOK_Click).
        /*  */
        /* btnCancel */
        /*  */
        resources:ApplyResources(THIS-OBJECT:btnCancel, "btnCancel":U).
        THIS-OBJECT:btnCancel:DialogResult = System.Windows.Forms.DialogResult:Cancel.
        THIS-OBJECT:btnCancel:Name = "btnCancel":U.
        /*  */
        /* panel1 */
        /*  */
        resources:ApplyResources(THIS-OBJECT:panel1, "panel1":U).
        THIS-OBJECT:panel1:BackColor = System.Drawing.SystemColors:ControlLightLight.
        THIS-OBJECT:panel1:Name = "panel1":U.
        /*  */
        /* InputFormDialog */
        /*  */
        THIS-OBJECT:AcceptButton = THIS-OBJECT:btnOK.
        THIS-OBJECT:CancelButton = THIS-OBJECT:btnCancel.
        resources:ApplyResources(THIS-OBJECT, "$this":U).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:panel1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:btnCancel).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:btnOK).
        THIS-OBJECT:Name = "InputFormDialog":U.
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

    /**
     * Purpose: Raises the Shown event
     * Notes:
     * @param e The System.EventArgs with the data for this event
     */
    METHOD PROTECTED OVERRIDE VOID OnShown (e AS System.EventArgs):

        DEFINE VARIABLE oControl AS System.Windows.Forms.Control NO-UNDO .
        DEFINE VARIABLE i        AS INTEGER                      NO-UNDO .

        SUPER:OnShown (e) .

        controlLoop:
        DO i = 1 TO EXTENT (oPropertySpecs):
            IF oPropertySpecs[i]:ReadOnly = FALSE THEN DO:
                oControl = CAST (CAST(oPropertyControls[i], Progress.Lang.Object),
                                      System.Windows.Forms.Control) .
                oControl:Focus () .

                LEAVE controlLoop .
            END.
        END.

        IF VALID-OBJECT (oValidator) THEN
            btnOK:Enabled = oValidator:IsValid (oValueObject) .

    END METHOD.

    /**
     * Purpose: Sets the properties
     * Notes:
     * @param poValueObject The value object to update
     * @param poPropertySpecs The array of PropertyInputSpec instances
     * @param poValidator The IValueObjectValidator instance that validates the value object
     */
    METHOD PUBLIC VOID SetProperties (poValueObject AS Progress.Lang.Object,
                                      poPropertySpecs AS IPropertySpec EXTENT,
                                      poValidator AS IInputValidator):

        DEFINE VARIABLE i        AS INTEGER                      NO-UNDO .
        DEFINE VARIABLE iHeight  AS INTEGER                      NO-UNDO INITIAL 2 .

        DEFINE VARIABLE oLabel   AS UltraLabel                   NO-UNDO .
        DEFINE VARIABLE oControl AS System.Windows.Forms.Control NO-UNDO .
        DEFINE VARIABLE iCount   AS INTEGER                      NO-UNDO .
        
        ASSIGN iCount = EXTENT (poPropertySpecs)
        
        EXTENT (oPropertyControls) = ? .
        EXTENT (oPropertyControls) = iCount .

        DO i = 1 TO iCount:

            oLabel          = NEW UltraLabel () .
            oLabel:Text     = poPropertySpecs[i]:Label + (IF NOT poPropertySpecs[i]:Label MATCHES "*:":U THEN ":":U ELSE "":U) .
            oLabel:AutoSize = TRUE .
            oLabel:Location = NEW System.Drawing.Point (12, iHeight + 4) .

            THIS-OBJECT:panel1:Controls:Add (oLabel) .

            oControl = THIS-OBJECT:CreateControl (poValueObject:GetClass(), poPropertySpecs[i]) .

            oPropertyControls[i] = CAST (oControl, IInputFormControl) .

            oControl:Location = NEW System.Drawing.Point (150, iHeight) .
            oControl:Width    = THIS-OBJECT:panel1:Width - 167 .

            THIS-OBJECT:panel1:Controls:Add (oControl) .

            ASSIGN iHeight = iHeight + oControl:Height + 6 .

            IF poPropertySpecs[i]:ReadOnly = TRUE THEN DO:
                IF DotNetReflectionHelper:HasProperty (oControl, "ReadOnly":U) THEN
                    DotNetReflectionHelper:SetPropertyValue (oControl, "ReadOnly":U, BOX (TRUE)) .
                ELSE
                    oControl:Enabled = FALSE .
            END.
        END.

        THIS-OBJECT:Height = THIS-OBJECT:Height - panel1:Height + iHeight .

        ASSIGN oValueObject   = poValueObject
               oPropertySpecs = poPropertySpecs
               oValidator     = poValidator .

        THIS-OBJECT:DisplayProperites() .

        IF VALID-OBJECT (poValidator) THEN
        DO i = 1 TO EXTENT (poPropertySpecs):   
            oControl = CAST (CAST (oPropertyControls[i], Progress.Lang.Object),
                             System.Windows.Forms.Control) .
            // using VALUE-CHANGED makes it easier to get values
            if type-of(oControl, UltraTextEditor) then
                cast(oControl, UltraTextEditor):ValueChanged:Subscribe (TextChangedHandler) .
            else
            if type-of(oControl, UltraNumericEditor) then
                cast(oControl, UltraNumericEditor):ValueChanged:Subscribe (TextChangedHandler) .
            else
            if type-of(oControl, UltraDateTimeEditor) then
                cast(oControl, UltraDateTimeEditor):ValueChanged:Subscribe (TextChangedHandler) .
            else
                oControl:TextChanged:Subscribe (TextChangedHandler) .
        END.

    END METHOD.

    /**
     * Purpose: Event handler for the TextChanged event of the input controls
     * Notes:
     * @param sender The reference to the object that raised the event
     * @param e The System.EventArgs with the data of this event
     */
    METHOD PROTECTED VOID TextChangedHandler (sender AS System.Object,
                                              e AS System.EventArgs):

        THIS-OBJECT:AssignProperites () .

        IF VALID-OBJECT (oValidator) THEN
            btnOK:Enabled = oValidator:IsValid (oValueObject) .

        CATCH err AS Progress.Lang.Error:
            MESSAGE err:GetMessage(1)
                VIEW-AS ALERT-BOX ERROR .
        END CATCH.

    END METHOD.

END CLASS.
