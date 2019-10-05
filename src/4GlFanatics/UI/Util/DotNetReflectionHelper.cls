/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/ 
/*------------------------------------------------------------------------
    File        : DotNetReflectionHelper
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Mike Fechner / Consultingwerk Ltd.
    Created     : Sat Oct 05 13:19:16 CEST 2019
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS 4GlFanatics.UI.Util.DotNetReflectionHelper: 

    /*------------------------------------------------------------------------------
        Purpose: Determines if the .NET object has a property with the given name
        Notes:
        @param poObject The object to test
        @param pcPropertyName The name of the property to test
        @return True when the property exists
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC STATIC LOGICAL HasProperty (poObject AS System.Object,
                                              pcPropertyName AS CHARACTER):

        DEFINE VARIABLE oType     AS System.Type                    NO-UNDO .
        DEFINE VARIABLE oProperty AS System.Reflection.PropertyInfo NO-UNDO .

        ASSIGN oType     = poObject:GetType ()
               oProperty = oType:GetProperty (pcPropertyName) .

        IF VALID-OBJECT (oProperty) THEN
            RETURN TRUE .

        RETURN FALSE .

    END METHOD .

    /*------------------------------------------------------------------------------
        Purpose: Dynamically Set a property value from a .NET object
        Notes:   Uses reflection, ABL Value types need to be BOXed
        @param poObject The object to set a property value for
        @param pcPropertyName The name of the property to set the value for
        @param poValue The value for the property
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC STATIC VOID SetPropertyValue (poObject AS System.Object,
                                                pcPropertyName AS CHARACTER,
                                                poValue AS System.Object):

        DEFINE VARIABLE oType     AS System.Type                    NO-UNDO .
        DEFINE VARIABLE oProperty AS System.Reflection.PropertyInfo NO-UNDO .

        ASSIGN oType     = poObject:GetType ()
               oProperty = oType:GetProperty (pcPropertyName) .

        IF VALID-OBJECT (oProperty) THEN
            oProperty:SetValue (poObject, poValue, ?) .

    END METHOD.
    
END CLASS.