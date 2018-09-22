module Subscriptions exposing (subscriptions)

import Models exposing (Model)
import Msgs exposing (Msg)



-- No subscriptions,
-- in a real app you could listen to note changes via websockets here


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
