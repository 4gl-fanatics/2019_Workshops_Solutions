/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/ 
/*------------------------------------------------------------------------
    File        : sample-call.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : Mike Fechner / Consultingwerk Ltd.
    Created     : Sat Oct 05 12:11:24 CEST 2019
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING tests.Sample.*                  FROM PROPATH.
USING 4GlFanatics.UI.*                FROM PROPATH.
USING 4GlFanatics.UI.Implementation.* FROM PROPATH.

DEFINE VARIABLE oParameter       AS CustomerReportParameter NO-UNDO . 
DEFINE VARIABLE oInputFormHelper AS IInputFormHelper        NO-UNDO . 
DEFINE VARIABLE oResult          AS DialogResultEnum        NO-UNDO .  

/* ***************************  Main Block  *************************** */

ASSIGN 
    oParameter            = NEW CustomerReportParameter () 
    oParameter:DateFrom   = DATE (1, 1, YEAR (TODAY))
    oParameter:DateTo     = DATE (12, 31, YEAR (TODAY))
    oParameter:OutputFile = "report.pdf" .

/* to-do: replace with ServiceManager call */    
oInputFormHelper = NEW GuiInputFormHelper () .

oResult = oInputFormHelper:PerformInput ("Customer Report Parameters", 
                                         oParameter, 
                                         PropertySpec:Array (NEW PropertySpec ("CustomerFrom", "Customer From"),
                                                             NEW PropertySpec ("CustomerTo", "Customer To"),
                                                             NEW PropertySpec ("DateFrom", "Date From"),
                                                             NEW PropertySpec ("DateTo", "Date To"),
                                                             NEW PropertySpec ("OutputFile", "Output File", ControlTypeEnum:FileNameSaveAs)), 
                                         NEW CustomerReportParameterValidator ()) . 

IF oResult <> DialogResultEnum:OK THEN 
    RETURN . 

MESSAGE oParameter:ToString () SKIP (2)
        oResult
    VIEW-AS ALERT-BOX.
