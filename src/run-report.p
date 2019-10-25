/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/ 
/*------------------------------------------------------------------------
    File        : run-report.p
    Purpose     : 
    Syntax      :
    Description : 
    Author(s)   : Mike Fechner / Consultingwerk Ltd.
    Created     : Sat Oct 05 12:11:24 CEST 2019
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

using 4GlFanatics.UI.ControlTypeEnum.
using 4GlFanatics.UI.DialogResultEnum.
using 4GlFanatics.UI.IInputFormHelper.
using 4GlFanatics.UI.IInputValidator.
using 4GlFanatics.UI.Parameters.CustomerReportParameter.
using 4GlFanatics.UI.PropertySpec.

DEFINE VARIABLE oParameter       AS CustomerReportParameter NO-UNDO . 
DEFINE VARIABLE oInputFormHelper AS IInputFormHelper        NO-UNDO .  
DEFINE VARIABLE oValidator       AS IInputValidator         NO-UNDO .
DEFINE VARIABLE oResult          AS DialogResultEnum        NO-UNDO .
  

/* ***************************  Main Block  *************************** */
// starts and hooks up the service manager 
run session_start.p.

ASSIGN 
    oParameter            = NEW CustomerReportParameter () 
    oParameter:DateFrom   = DATE (1, 1, YEAR (TODAY))
    oParameter:DateTo     = DATE (12, 31, YEAR (TODAY))
    oParameter:OutputFile = "report.pdf" .

oInputFormHelper = {get-service.i IInputFormHelper}.
oValidator       = {get-service.i IInputValidator "CustomerReportParameter"}.

oResult = oInputFormHelper:PerformInput ("Customer Report Parameters", 
                                         oParameter, 
                                         PropertySpec:Array (NEW PropertySpec ("CustomerFrom", "Customer From"),
                                                             NEW PropertySpec ("CustomerTo", "Customer To"),
                                                             NEW PropertySpec ("DateFrom", "Date From",     ControlTypeEnum:DateField),
                                                             NEW PropertySpec ("DateTo", "Date To",         ControlTypeEnum:DateField),
                                                             NEW PropertySpec ("OutputFile", "Output File", ControlTypeEnum:FileNameSaveAs)), 
                                         oValidator) . 

IF oResult <> DialogResultEnum:OK THEN 
    RETURN . 

MESSAGE oParameter:ToString () SKIP (2)
        oResult
    VIEW-AS ALERT-BOX.
