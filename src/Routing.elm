module Routing exposing (NoteSlug, Route(..), matchers, notePath, notesPath, parseUrl)

import Url exposing (Url)
import Url.Parser exposing (..)


type alias NoteSlug =
    String


type Route
    = NoteRoute NoteSlug
    | NotesRoute
    | NotFoundRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map NotesRoute top
        , map NoteRoute (s "" </> string)
        , map NotesRoute (s "")
        ]


parseUrl : Url -> Route
parseUrl url =
    case parse matchers url of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


notesPath : String
notesPath =
    "/"


notePath : NoteSlug -> String
notePath id =
    "/" ++ id
