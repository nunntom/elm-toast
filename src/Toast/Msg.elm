module Toast.Msg exposing (ToastMsg(..))


type ToastMsg
    = RemoveDelayFinished Int
    | RemoveButtonPressed Int
    | NoOp
