module Models exposing (Model, Note)

import Array exposing (..)
import Browser.Navigation exposing (Key, pushUrl)
import Routing
import Time


type alias Note =
    { id : Routing.NoteSlug
    , text : String
    , ts : Time.Posix
    }



-- Setup a model type


type alias Model =
    { notes : Array Note -- All stored notes, uses elm's Array to allow index access
    , route : Routing.Route -- Current route
    , key : Key -- Route key, required by Elm's internals
    , focusedNote : Note -- The note being edited or created
    }
