port module Ports.Internal exposing (..)

import Json.Encode as Encode


port sendRequest : Encode.Value -> Cmd msg


port receiveResponse : (Encode.Value -> msg) -> Sub msg
