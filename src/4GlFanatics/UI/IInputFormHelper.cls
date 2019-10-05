/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/
/*------------------------------------------------------------------------
    File        : IInputFormHelper
    Description : 
    Author(s)   : Mike Fechner / Consultingwerk Ltd.
    Notes       : 
  ----------------------------------------------------------------------*/

USING 4GlFanatics.UI.*  FROM PROPATH .

INTERFACE 4GlFanatics.UI.IInputFormHelper:  

    METHOD PUBLIC DialogResultEnum PerformInput (pcTitle AS CHARACTER,
                                                 poValueObject AS Progress.Lang.Object,
                                                 poPropertySpecs AS IPropertySpec EXTENT,
                                                 poValidator AS IInputValidator).

END INTERFACE.
