module Toast.Update exposing (addToast, addToastEffect, update)

import Toast.Effect as ToastEffect exposing (ToastEffect)
import Toast.Model as ToastModel exposing (ToastModel)
import Toast.Msg exposing (ToastMsg(..))


addToastEffect : (toast -> Maybe Float) -> toast -> ToastModel toast -> ( ToastModel toast, ToastEffect )
addToastEffect toDelay toast model =
    ToastModel.addToast toast model
        |> Tuple.mapSecond
            (\id ->
                Maybe.map (ToastEffect.removeAfter id) (toDelay toast)
                    |> Maybe.withDefault ToastEffect.none
            )


addToast : (toast -> Maybe Float) -> toast -> ToastModel toast -> ( ToastModel toast, Cmd ToastMsg )
addToast toDelay toast model =
    addToastEffect toDelay toast model
        |> Tuple.mapSecond (ToastEffect.perform identity)


update : ToastMsg -> ToastModel toast -> ToastModel toast
update msg model =
    case msg of
        RemoveDelayFinished key ->
            ToastModel.removeToast key model

        RemoveButtonPressed key ->
            ToastModel.removeToast key model

        NoOp ->
            model
