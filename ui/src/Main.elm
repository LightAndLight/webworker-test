module Main exposing (main)

import Browser
import Core.Messages as Core
import Html
import Html.Events as Event
import Platform.Cmd as Cmd
import Ports exposing (receiveResponse, sendRequest)


type Msg
    = Response Core.Response
    | Request Core.Request
    | None


type alias Model =
    { count : Maybe Int }


main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> ( { count = Nothing }, Cmd.none )
        , update =
            \msg model ->
                case msg of
                    None ->
                        ( model, Cmd.none )

                    Request r ->
                        ( model, sendRequest r )

                    Response (Core.Count n) ->
                        ( { model | count = Just n }
                        , Cmd.none
                        )
        , view =
            \model ->
                Html.div
                    []
                    [ Html.button
                        [ Event.onClick <| Request Core.Increment ]
                        [ Html.text "increment" ]
                    , Html.button
                        [ Event.onClick <| Request Core.Get ]
                        [ Html.text "get" ]
                    , Html.button
                        [ Event.onClick <| Request Core.Reset ]
                        [ Html.text "reset" ]
                    , Html.text <|
                        case model.count of
                            Nothing ->
                                "No count"

                            Just n ->
                                String.fromInt n
                    ]
        , subscriptions =
            \_ ->
                Sub.map
                    (\r ->
                        case r of
                            Err err ->
                                None

                            Ok a ->
                                Response a
                    )
                    receiveResponse
        }
