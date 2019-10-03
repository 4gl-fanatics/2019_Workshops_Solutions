/*
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.
*/
/*------------------------------------------------------------------------
    File        : InputFormHelper
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : pjudge
    Created     : Thu Oct 03 09:12:43 EDT 2019
    Notes       : 
  ----------------------------------------------------------------------*/
block-level on error undo, throw.

using 4GlFanatics.UI.IInputFormHelper.
using 4GlFanatics.UI.IInputValidator.
using 4GlFanatics.UI.IPropertySpec.

class Test.InputFormHelper implements IInputFormHelper:
     
    constructor public InputFormHelper(input pValidator as IInputValidator):
        message 
        'using ctor: input IInputValidator'
        view-as alert-box.
    end constructor.
    
    constructor public InputFormHelper(input pValidator as IInputValidator,
                                       input pPropSpec as IPropertySpec extent):
        message 
        'using ctor: input IInputValidator, input IPropertySpec extent'
        view-as alert-box.
    end.
    
    constructor public InputFormHelper():
        message 
        'using default ctor'
        view-as alert-box.
        
    end constructor.
    
    constructor public InputFormHelper(input pValidator as IInputValidator,
                                       input pForceValidate as logical):
        message 
        'using ctor: input IInputValidator, input logical'
        view-as alert-box.
    end constructor.
    
end class.