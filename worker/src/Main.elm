module Main exposing (main)

import Core.Messages as Core
import Platform
import Platform.Cmd as Cmd
import Ports exposing (receiveRequest, sendResponse)


type Msg
    = Core Core.Request
    | None


type alias Model =
    { counter : Int }


main : Program () Model Msg
main =
    Platform.worker
        { init = \_ -> ( { counter = 0 }, Cmd.none )
        , update =
            \msg model ->
                case msg of
                    Core Core.Increment ->
                        ( { model | counter = model.counter + 1 }
                        , Cmd.none
                        )

                    Core Core.Reset ->
                        ( { model | counter = 0 }
                        , Cmd.none
                        )

                    Core Core.Get ->
                        ( model
                        , sendResponse <| Core.Count model.counter
                        )

                    None ->
                        ( model, Cmd.none )
        , subscriptions =
            \_ ->
                Sub.map
                    (\r ->
                        case r of
                            Err err ->
                                None

                            Ok a ->
                                Core a
                    )
                    receiveRequest
        }
