/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/ 
/*------------------------------------------------------------------------
    File        : old-style.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : Mike Fechner / Consultingwerk Ltd.
    Created     : Sun Oct 06 14:22:04 CEST 2019 
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

DEFINE VARIABLE iCustomerFrom AS INTEGER   NO-UNDO.
DEFINE VARIABLE iCustomerTo   AS INTEGER   NO-UNDO.
DEFINE VARIABLE dtDateFrom    AS DATE      NO-UNDO.
DEFINE VARIABLE dtDateTo      AS DATE      NO-UNDO.
DEFINE VARIABLE cOutputFile   AS CHARACTER NO-UNDO.

DEFINE VARIABLE lContinue     AS LOGICAL   NO-UNDO.

/* ***************************  Main Block  *************************** */

ASSIGN dtDateFrom   = DATE (1, 1, YEAR (TODAY))
       dtDateTo     = DATE (12, 31, YEAR (TODAY))
       cOutputFile  = "report.pdf" .

RUN d-customereport-parameter.w (OUTPUT iCustomerFrom, 
                                 OUTPUT iCustomerTo,
                                 OUTPUT dtDateFrom,
                                 OUTPUT dtDateTo,
                                 OUTPUT cOutputFile,
                                 OUTPUT lContinue) . 
                                 
IF NOT lContinue THEN  
    RETURN .                                      

