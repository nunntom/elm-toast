module Toast.Effect exposing (ToastEffect, none, perform, removeAfter, simulate)

import Process
import Task
import Toast.Msg exposing (ToastMsg(..))


type ToastEffect
    = RemoveAfter Int Float
    | None


removeAfter : Int -> Float -> ToastEffect
removeAfter =
    RemoveAfter


none : ToastEffect
none =
    None


perform : (ToastMsg -> msg) -> ToastEffect -> Cmd msg
perform tagger effect =
    case effect of
        RemoveAfter key delay ->
            Process.sleep delay
                |> Task.perform (\_ -> tagger (RemoveDelayFinished key))

        None ->
            Cmd.none


simulate :
    { sleep : Float -> simulatedTask
    , perform : (() -> msg) -> simulatedTask -> simulatedEffect
    }
    -> (ToastMsg -> msg)
    -> ToastEffect
    -> simulatedEffect
simulate conf tagger effect =
    case effect of
        RemoveAfter key delay ->
            conf.sleep delay
                |> conf.perform (\_ -> tagger (RemoveDelayFinished key))

        None ->
            conf.sleep 0
                |> conf.perform (\_ -> tagger NoOp)
