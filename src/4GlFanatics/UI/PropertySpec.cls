/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/ 
/*------------------------------------------------------------------------
    File        : PropertySpec
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Mike Fechner / Consultingwerk Ltd.
    Created     : Sat Oct 05 11:41:26 CEST 2019
    Notes       : 
  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING 4GlFanatics.UI.* FROM PROPATH .
USING Progress.Lang.*  FROM PROPATH .

CLASS 4GlFanatics.UI.PropertySpec 
    IMPLEMENTS IPropertySpec: 

    DEFINE PUBLIC PROPERTY ControlType AS ControlTypeEnum NO-UNDO 
    GET.
    SET. 

    DEFINE PUBLIC PROPERTY Label AS CHARACTER NO-UNDO 
    GET.
    SET. 

    DEFINE PUBLIC PROPERTY Name AS CHARACTER NO-UNDO 
    GET.
    SET. 

    DEFINE PUBLIC PROPERTY ReadOnly AS LOGICAL NO-UNDO 
    GET.
    SET. 

    /*------------------------------------------------------------------------------
       Purpose: Constructor for the PropertySpec class
       Notes:
    ------------------------------------------------------------------------------*/
    CONSTRUCTOR PUBLIC PropertySpec (pcName AS CHARACTER, 
                                     pcLabel AS CHARACTER,
                                     plReadOnly AS LOGICAL,
                                     poControlType AS ControlTypeEnum):
        
        SUPER () .
        
        ASSIGN THIS-OBJECT:Name        = pcName 
               THIS-OBJECT:Label       = pcLabel
               THIS-OBJECT:ReadOnly    = plReadOnly
               THIS-OBJECT:ControlType = poControlType .
        
    END CONSTRUCTOR.

    /*------------------------------------------------------------------------------
       Purpose: Constructor for the PropertySpec class
       Notes:
    ------------------------------------------------------------------------------*/
    CONSTRUCTOR PUBLIC PropertySpec ():
        SUPER ().
        
    END CONSTRUCTOR.

    /*------------------------------------------------------------------------------
       Purpose: Constructor for the PropertySpec class
       Notes:
    ------------------------------------------------------------------------------*/
    CONSTRUCTOR PUBLIC PropertySpec (pcName AS CHARACTER, 
                                     pcLabel AS CHARACTER):
        
        THIS-OBJECT (pcName, pcLabel, FALSE, ControlTypeEnum:TextBox) .
        
    END CONSTRUCTOR.

    /*------------------------------------------------------------------------------
       Purpose: Constructor for the PropertySpec class
       Notes:
    ------------------------------------------------------------------------------*/
    CONSTRUCTOR PUBLIC PropertySpec (pcName AS CHARACTER, 
                                     pcLabel AS CHARACTER,
                                     plReadOnly AS LOGICAL):
        
        THIS-OBJECT (pcName, pcLabel, plReadOnly, ControlTypeEnum:TextBox) .
        
    END CONSTRUCTOR.

    /*------------------------------------------------------------------------------
       Purpose: Constructor for the PropertySpec class
       Notes:
    ------------------------------------------------------------------------------*/
    CONSTRUCTOR PUBLIC PropertySpec (pcName AS CHARACTER, 
                                     pcLabel AS CHARACTER,
                                     poControlType AS ControlTypeEnum):
        
        THIS-OBJECT (pcName, pcLabel, FALSE, poControlType) .
        
    END CONSTRUCTOR.

    /*------------------------------------------------------------------------------
       Purpose: Array constructor
       Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC STATIC IPropertySpec EXTENT Array (poPropertySpec1 AS IPropertySpec):
        
        DEFINE VARIABLE oArray AS IPropertySpec EXTENT 1 .

        ASSIGN oArray[1] = poPropertySpec1 .

        RETURN oArray .

    END METHOD.
    
    /*------------------------------------------------------------------------------
       Purpose: Array constructor
       Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC STATIC IPropertySpec EXTENT Array (poPropertySpec1 AS IPropertySpec, poPropertySpec2 AS IPropertySpec):
        
        DEFINE VARIABLE oArray AS IPropertySpec EXTENT 2 .

        ASSIGN oArray[1]  = poPropertySpec1
               oArray[2]  = poPropertySpec2 .

        RETURN oArray .

    END METHOD.

    /*------------------------------------------------------------------------------
       Purpose: Array constructor
       Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC STATIC IPropertySpec EXTENT Array (poPropertySpec1 AS IPropertySpec, poPropertySpec2 AS IPropertySpec, poPropertySpec3 AS IPropertySpec):
        
        DEFINE VARIABLE oArray AS IPropertySpec EXTENT 3 .

        ASSIGN oArray[1]  = poPropertySpec1
               oArray[2]  = poPropertySpec2 
               oArray[3]  = poPropertySpec3 .

        RETURN oArray .

    END METHOD.

    /*------------------------------------------------------------------------------
       Purpose: Array constructor
       Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC STATIC IPropertySpec EXTENT Array (poPropertySpec1 AS IPropertySpec, poPropertySpec2 AS IPropertySpec, poPropertySpec3 AS IPropertySpec, 
                                                     poPropertySpec4 AS IPropertySpec):
        
        DEFINE VARIABLE oArray AS IPropertySpec EXTENT 4 .

        ASSIGN oArray[1]  = poPropertySpec1
               oArray[2]  = poPropertySpec2 
               oArray[3]  = poPropertySpec3 
               oArray[4]  = poPropertySpec4 .

        RETURN oArray .

    END METHOD.

    /*------------------------------------------------------------------------------
       Purpose: Array constructor
       Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC STATIC IPropertySpec EXTENT Array (poPropertySpec1 AS IPropertySpec, poPropertySpec2 AS IPropertySpec, poPropertySpec3 AS IPropertySpec, 
                                                     poPropertySpec4 AS IPropertySpec, poPropertySpec5 AS IPropertySpec):
        
        DEFINE VARIABLE oArray AS IPropertySpec EXTENT 5 .

        ASSIGN oArray[1]  = poPropertySpec1
               oArray[2]  = poPropertySpec2 
               oArray[3]  = poPropertySpec3 
               oArray[4]  = poPropertySpec4 
               oArray[5]  = poPropertySpec5 .

        RETURN oArray .

    END METHOD.

    /*------------------------------------------------------------------------------
       Purpose: Array constructor
       Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC STATIC IPropertySpec EXTENT Array (poPropertySpec1 AS IPropertySpec, poPropertySpec2 AS IPropertySpec, poPropertySpec3 AS IPropertySpec, 
                                                     poPropertySpec4 AS IPropertySpec, poPropertySpec5 AS IPropertySpec, poPropertySpec6 AS IPropertySpec):
        
        DEFINE VARIABLE oArray AS IPropertySpec EXTENT 6 .

        ASSIGN oArray[1]  = poPropertySpec1
               oArray[2]  = poPropertySpec2 
               oArray[3]  = poPropertySpec3 
               oArray[4]  = poPropertySpec4 
               oArray[5]  = poPropertySpec5 
               oArray[6]  = poPropertySpec6 .

        RETURN oArray .

    END METHOD.

    /*------------------------------------------------------------------------------
       Purpose: Array constructor
       Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC STATIC IPropertySpec EXTENT Array (poPropertySpec1 AS IPropertySpec, poPropertySpec2 AS IPropertySpec, poPropertySpec3 AS IPropertySpec, 
                                                     poPropertySpec4 AS IPropertySpec, poPropertySpec5 AS IPropertySpec, poPropertySpec6 AS IPropertySpec,
                                                     poPropertySpec7 AS IPropertySpec):
        
        DEFINE VARIABLE oArray AS IPropertySpec EXTENT 7 .

        ASSIGN oArray[1]  = poPropertySpec1
               oArray[2]  = poPropertySpec2 
               oArray[3]  = poPropertySpec3 
               oArray[4]  = poPropertySpec4 
               oArray[5]  = poPropertySpec5 
               oArray[6]  = poPropertySpec6 
               oArray[7]  = poPropertySpec7 .

        RETURN oArray .

    END METHOD.

    /*------------------------------------------------------------------------------
       Purpose: Array constructor
       Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC STATIC IPropertySpec EXTENT Array (poPropertySpec1 AS IPropertySpec, poPropertySpec2 AS IPropertySpec, poPropertySpec3 AS IPropertySpec, 
                                                     poPropertySpec4 AS IPropertySpec, poPropertySpec5 AS IPropertySpec, poPropertySpec6 AS IPropertySpec,
                                                     poPropertySpec7 AS IPropertySpec, poPropertySpec8 AS IPropertySpec):
        
        DEFINE VARIABLE oArray AS IPropertySpec EXTENT 8 .

        ASSIGN oArray[1]  = poPropertySpec1
               oArray[2]  = poPropertySpec2 
               oArray[3]  = poPropertySpec3 
               oArray[4]  = poPropertySpec4 
               oArray[5]  = poPropertySpec5 
               oArray[6]  = poPropertySpec6 
               oArray[7]  = poPropertySpec7 
               oArray[8]  = poPropertySpec8 .

        RETURN oArray .

    END METHOD.

    /*------------------------------------------------------------------------------
       Purpose: Array constructor
       Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC STATIC IPropertySpec EXTENT Array (poPropertySpec1 AS IPropertySpec, poPropertySpec2 AS IPropertySpec, poPropertySpec3 AS IPropertySpec, 
                                                     poPropertySpec4 AS IPropertySpec, poPropertySpec5 AS IPropertySpec, poPropertySpec6 AS IPropertySpec,
                                                     poPropertySpec7 AS IPropertySpec, poPropertySpec8 AS IPropertySpec, poPropertySpec9 AS IPropertySpec):
        
        DEFINE VARIABLE oArray AS IPropertySpec EXTENT 9 .

        ASSIGN oArray[1]  = poPropertySpec1
               oArray[2]  = poPropertySpec2 
               oArray[3]  = poPropertySpec3 
               oArray[4]  = poPropertySpec4 
               oArray[5]  = poPropertySpec5 
               oArray[6]  = poPropertySpec6 
               oArray[7]  = poPropertySpec7 
               oArray[8]  = poPropertySpec8 
               oArray[9]  = poPropertySpec9 .

        RETURN oArray .

    END METHOD.

    /*------------------------------------------------------------------------------
       Purpose: Array constructor
       Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC STATIC IPropertySpec EXTENT Array (poPropertySpec1 AS IPropertySpec, poPropertySpec2 AS IPropertySpec, poPropertySpec3 AS IPropertySpec, 
                                                     poPropertySpec4 AS IPropertySpec, poPropertySpec5 AS IPropertySpec, poPropertySpec6 AS IPropertySpec,
                                                     poPropertySpec7 AS IPropertySpec, poPropertySpec8 AS IPropertySpec, poPropertySpec9 AS IPropertySpec, 
                                                     poPropertySpec10 AS IPropertySpec):
        
        DEFINE VARIABLE oArray AS IPropertySpec EXTENT 10 .

        ASSIGN oArray[1]  = poPropertySpec1
               oArray[2]  = poPropertySpec2 
               oArray[3]  = poPropertySpec3 
               oArray[4]  = poPropertySpec4 
               oArray[5]  = poPropertySpec5 
               oArray[6]  = poPropertySpec6 
               oArray[7]  = poPropertySpec7 
               oArray[8]  = poPropertySpec8 
               oArray[9]  = poPropertySpec9
               oArray[10] = poPropertySpec10 .

        RETURN oArray .

    END METHOD.

END CLASS.
