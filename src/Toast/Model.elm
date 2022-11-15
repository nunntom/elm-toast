module Toast.Model exposing (ToastModel, addToast, init, removeToast, toToasts)

import Dict exposing (Dict)
import List.Extra


type ToastModel toast
    = Model (Dict Int toast)


init : ToastModel toast
init =
    Model Dict.empty


addToast : toast -> ToastModel toast -> ( ToastModel toast, Int )
addToast toast ((Model toasts) as model) =
    ( Model (Dict.insert (toLastKey model + 1) toast toasts), toLastKey model + 1 )


removeToast : Int -> ToastModel toast -> ToastModel toast
removeToast idx (Model toasts) =
    Model (Dict.remove idx toasts)


toToasts : ToastModel toast -> List ( Int, toast )
toToasts (Model toasts) =
    Dict.toList toasts


toLastKey : ToastModel toast -> Int
toLastKey (Model toasts) =
    Dict.keys toasts |> List.Extra.last |> Maybe.withDefault 0
