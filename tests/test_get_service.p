
/*------------------------------------------------------------------------
    File        : test_providers.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : pjudge
    Created     : Thu Oct 03 15:28:03 EDT 2019
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

block-level on error undo, throw.

/* ********************  Preprocessor Definitions  ******************** */
session:error-stack-trace = true.

/* ***************************  Main Block  *************************** */
define variable svc as Progress.Lang.Object no-undo.

run session_start.p.

svc = Ccs.Common.Application:ServiceManager:getService(get-class(4GlFanatics.UI.IInputFormHelper)).

message svc
view-as alert-box.

catch e as Progress.Lang.Error :
    message e:GetMessage(1)skip
    e:CallStack
    view-as alert-box.    
        
end catch.