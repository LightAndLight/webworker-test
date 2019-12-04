module Ports exposing (..)

import Core.Messages as Core
import Json.Decode as Decode
import Platform.Sub as Sub
import Ports.Internal as Internal


sendRequest : Core.Request -> Cmd msg
sendRequest =
    Internal.sendRequest << Core.encodeRequest


receiveResponse : Sub (Result Decode.Error Core.Response)
receiveResponse =
    Internal.receiveResponse
        (Decode.decodeValue Core.decodeResponse)
