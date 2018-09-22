module Init exposing (init)

import Array exposing (Array, fromList, length)
import Browser.Navigation exposing (Key, pushUrl)
import Models exposing (Model, Note)
import Msgs exposing (Msg)
import Routing exposing (parseUrl)
import Time exposing (millisToPosix)
import Url exposing (Url)
import Utils exposing (filterNotes, idFromPath)



-- No Flags


type alias Flags =
    {}



-- Helper to generate some initial seed notes


initialNotes : Array Note
initialNotes =
    let
        -- Hardcoding for demonstration
        defaultTimestamp =
            millisToPosix 1537625034436
    in
    fromList
        [ { id = "0", text = "First Note", ts = defaultTimestamp }
        , { id = "1", text = "Second Note", ts = defaultTimestamp }
        , { id = "2", text = "Third Note", ts = defaultTimestamp }
        ]



-- Initialise function to bootstrap the program's model


init : Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags url key =
    let
        -- Hardcode initial note to 0
        initialId =
            if url.path == "/" then
                "0"

            else
                idFromPath url.path

        initialFocused =
            filterNotes initialId initialNotes

        currentRoute =
            parseUrl url
    in
    ( Model initialNotes currentRoute key initialFocused, Cmd.none )
