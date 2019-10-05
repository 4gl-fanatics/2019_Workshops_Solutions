/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/ 
/*------------------------------------------------------------------------
    File        : DateRangeValidator
    Purpose     : Validates that DateFrom <= DateTo
    Syntax      : 
    Description : 
    Author(s)   : Mike Fechner / Consultingwerk Ltd.
    Created     : Sat Oct 05 11:55:38 CEST 2019
    Notes       : 
  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING 4GlFanatics.UI.*            FROM PROPATH .
USING 4GlFanatics.UI.Validators.* FROM PROPATH .
USING Progress.Lang.*             FROM PROPATH .
USING OpenEdge.Core.*             FROM PROPATH .

CLASS 4GlFanatics.UI.Validators.DateRangeValidator 
    IMPLEMENTS IInputValidator: 

    METHOD PUBLIC LOGICAL IsValid (poValueObject AS Progress.Lang.Object):

        DEFINE VARIABLE oInstance AS IHasDateRange NO-UNDO . 
        
        Assert:IsType(poValueObject, GET-CLASS (IHasDateRange)) .

        ASSIGN oInstance = CAST (poValueObject, IHasDateRange) .

        IF oInstance:DateFrom = ? OR oInstance:DateTo = ? THEN 
            RETURN FALSE . 

        RETURN oInstance:DateFrom <= oInstance:DateTo .

    END METHOD.

END CLASS.
