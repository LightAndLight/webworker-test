module Ports exposing (..)

import Core.Messages as Core
import Json.Decode as Decode
import Platform.Sub as Sub
import Ports.Internal as Internal


sendResponse : Core.Response -> Cmd msg
sendResponse =
    Internal.sendResponse << Core.encodeResponse


receiveRequest : Sub (Result Decode.Error Core.Request)
receiveRequest =
    Internal.receiveRequest
        (Decode.decodeValue Core.decodeRequest)
