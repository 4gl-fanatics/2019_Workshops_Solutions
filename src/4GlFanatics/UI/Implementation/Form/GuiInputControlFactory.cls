/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/  
/*------------------------------------------------------------------------
    File        : GuiInputControlFactory
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Mike Fechner / Consultingwerk Ltd.
    Created     : Sat Oct 05 13:39:06 CEST 2019
    Notes       : 
  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Progress.Lang.*.
USING 4GlFanatics.UI.Implementation.Form.* .
USING 4GlFanatics.UI.* FROM PROPATH.

CLASS 4GlFanatics.UI.Implementation.Form.GuiInputControlFactory IMPLEMENTS IGuiInputControlFactory: 

    METHOD PUBLIC System.Windows.Forms.Control CreateInputControl (poValueObjectType AS Progress.Lang.Class, 
                                                                   poPropertySpec AS 4GlFanatics.UI.IPropertySpec):
        
        DEFINE VARIABLE cPropertyType AS CHARACTER NO-UNDO.
        
        cPropertyType = poValueObjectType:GetProperty(poPropertySpec:Name):DataType:ToString() .
        
        CASE poPropertySpec:ControlType:
            
            WHEN ControlTypeEnum:DateField THEN 
                RETURN NEW DateTextBoxInputControl () .
                
            WHEN ControlTypeEnum:FileNameSaveAs THEN 
                RETURN NEW SaveAsInputControl (poPropertySpec:Label) .
                 
            /* Textbox */
            OTHERWISE DO:
                
                CASE cPropertyType:
                    WHEN "Integer" THEN 
                        RETURN NEW IntegerTextBoxInputControl () .
                    WHEN "Date" THEN 
                        RETURN NEW DateTextBoxInputControl () .
                END CASE . 

                RETURN NEW TextBoxInputControl () .
            END.
            
        END CASE . 

    END METHOD.

END CLASS.
