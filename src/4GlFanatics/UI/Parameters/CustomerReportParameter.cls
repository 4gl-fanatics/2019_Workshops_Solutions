/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/
/*------------------------------------------------------------------------
    File        : CustomerReportParameter
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Mike Fechner / Consultingwerk Ltd.
    Created     : Sat Oct 05 12:08:54 CEST 2019
    Notes       : 
  ----------------------------------------------------------------------*/


BLOCK-LEVEL ON ERROR UNDO, THROW.

using 4GlFanatics.UI.Validators.IHasDateRange.

CLASS 4GlFanatics.UI.Parameters.CustomerReportParameter 
    IMPLEMENTS IHasDateRange: 

    DEFINE PUBLIC PROPERTY CustomerFrom AS INTEGER   NO-UNDO GET. SET. 
    DEFINE PUBLIC PROPERTY CustomerTo   AS INTEGER   NO-UNDO GET. SET. 

    DEFINE PUBLIC PROPERTY DateFrom     AS DATE      NO-UNDO GET. SET. 
    DEFINE PUBLIC PROPERTY DateTo       AS DATE      NO-UNDO GET. SET. 

    DEFINE PUBLIC PROPERTY OutputFile   AS CHARACTER NO-UNDO GET. SET. 

    /*------------------------------------------------------------------------------
       Purpose:
       Notes:
    ------------------------------------------------------------------------------*/
    METHOD OVERRIDE PUBLIC CHARACTER ToString(  ):
        
        RETURN SUBSTITUTE ("Object of type: &1~n~n" + 
                           "Customer:       &2 - &3~n" +
                           "Date:           &4 - &5~n" +
                           "Output file:    &6",
                           THIS-OBJECT:GetClass():TypeName,
                           THIS-OBJECT:CustomerFrom, 
                           THIS-OBJECT:CustomerTo,
                           THIS-OBJECT:DateFrom,
                           THIS-OBJECT:DateTo,
                           THIS-OBJECT:OutputFile) .

    END METHOD.

END CLASS.
