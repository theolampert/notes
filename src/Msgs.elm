module Msgs exposing (Msg(..))

import Browser exposing (UrlRequest)
import Models exposing (Note)
import Time exposing (Posix)
import Url exposing (Url)


type Msg
    = UpdateNote String
    | OnUrlChange Url
    | OnUrlRequest UrlRequest
    | PersistNote Posix
