/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/
/*------------------------------------------------------------------------
    File        : IHasDateRange
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Mike Fechner / Consultingwerk Ltd.
    Created     : Sat Oct 05 11:51:28 CEST 2019
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

INTERFACE 4GlFanatics.UI.Validators.IHasDateRange:  

    DEFINE PUBLIC PROPERTY DateFrom AS DATE NO-UNDO GET .
    DEFINE PUBLIC PROPERTY DateTo   AS DATE NO-UNDO GET .

END INTERFACE.

