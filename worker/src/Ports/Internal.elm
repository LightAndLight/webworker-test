port module Ports.Internal exposing (..)

import Core.Messages as Core
import Json.Encode as Encode


port sendResponse : Encode.Value -> Cmd msg


port receiveRequest : (Encode.Value -> msg) -> Sub msg
