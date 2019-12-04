module Core.Messages exposing (..)

import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode


type Request
    = Increment
    | Reset
    | Get


type Response
    = Count Int


encodeResponse : Response -> Encode.Value
encodeResponse r =
    Encode.object <|
        ( "tag"
        , case r of
            Count _ ->
                Encode.string "count"
        )
            :: (case r of
                    Count n ->
                        [ ( "value", Encode.int n ) ]
               )


decodeResponse : Decoder Response
decodeResponse =
    Decode.field "tag" Decode.string
        |> Decode.andThen
            (\tag ->
                case tag of
                    "count" ->
                        Decode.map Count <|
                            Decode.field "value" Decode.int

                    _ ->
                        Decode.fail <| "Unknown tag '" ++ tag ++ "'"
            )


encodeRequest : Request -> Encode.Value
encodeRequest r =
    Encode.object <|
        [ ( "tag"
          , case r of
                Increment ->
                    Encode.string "increment"

                Reset ->
                    Encode.string "reset"

                Get ->
                    Encode.string "get"
          )
        ]


decodeRequest : Decoder Request
decodeRequest =
    Decode.field "tag" Decode.string
        |> Decode.andThen
            (\tag ->
                case tag of
                    "increment" ->
                        Decode.succeed Increment

                    "reset" ->
                        Decode.succeed Reset

                    "get" ->
                        Decode.succeed Get

                    _ ->
                        Decode.fail <| "Unknown tag '" ++ tag ++ "'"
            )
