/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/  
/*------------------------------------------------------------------------
    File        : CustomerReportParameterValidator
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Mike Fechner / Consultingwerk Ltd.
    Created     : Sat Oct 05 12:38:14 CEST 2019
    Notes       : 
  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING 4GlFanatics.UI.*            FROM PROPATH .
USING 4GlFanatics.UI.Validators.* FROM PROPATH .
USING Progress.Lang.*             FROM PROPATH .
USING OpenEdge.Core.*             FROM PROPATH .
USING tests.Sample.*              FROM PROPATH .

CLASS tests.Sample.CustomerReportParameterValidator 
    IMPLEMENTS IInputValidator: 

    DEFINE VARIABLE oDateRangeValidator AS DateRangeValidator NO-UNDO . 

    METHOD PUBLIC LOGICAL IsValid (poValueObject AS Progress.Lang.Object):
        
        DEFINE VARIABLE oInstance AS CustomerReportParameter NO-UNDO . 
        
        Assert:IsType (poValueObject, GET-CLASS (CustomerReportParameter)) .

        ASSIGN oInstance = CAST (poValueObject, CustomerReportParameter) .

        IF oInstance:CustomerFrom = ? OR oInstance:CustomerTo = ? THEN 
            RETURN FALSE . 

        IF oInstance:CustomerFrom > oInstance:CustomerTo THEN 
            RETURN FALSE .
        
        IF oInstance:OutputFile = ? OR oInstance:OutputFile = "":U THEN 
            RETURN FALSE . 

        /* Use default DateRangeValidator as delegate */        
        IF NOT VALID-OBJECT (oDateRangeValidator) THEN 
            oDateRangeValidator = NEW DateRangeValidator () .

        RETURN oDateRangeValidator:IsValid(poValueObject) . 
             
    END METHOD.

END CLASS.
