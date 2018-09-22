module Update exposing (update)

import Array exposing (..)
import Browser exposing (UrlRequest, application)
import Browser.Navigation exposing (Key, pushUrl)
import Models exposing (Model, Note)
import Msgs exposing (..)
import Routing
import Task
import Time
import Url exposing (Url)
import Utils exposing (emptyNote, filterNotes, idFromPath, setNoteText)



-- Helper for updating or creating note


updateOrCreateNote : Model -> Time.Posix -> Array Note
updateOrCreateNote model now =
    -- Destructure the focused notes id
    case String.toInt model.focusedNote.id of
        Nothing ->
            model.notes

        Just id ->
            if id < Array.length model.notes then
                Array.set
                    id
                    (Note model.focusedNote.id model.focusedNote.text now)
                    model.notes

            else
                Array.push
                    (Note (String.fromInt id) model.focusedNote.text now)
                    model.notes


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        -- Save note with a timestamp
        -- here you would persist to localstorage or an API.
        PersistNote now ->
            ( { model | notes = updateOrCreateNote model now }, Cmd.none )

        -- Mutate the 'Focused' note
        UpdateNote text ->
            ( { model | focusedNote = setNoteText text model.focusedNote }
            , Task.perform PersistNote Time.now
            )

        OnUrlChange url ->
            ( { model
                | route = Routing.parseUrl url
                , focusedNote = filterNotes (idFromPath url.path) model.notes
              }
            , Cmd.none
            )

        OnUrlRequest urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model
                    , Browser.Navigation.pushUrl model.key (Url.toString url)
                    )

                Browser.External url ->
                    ( model
                    , Browser.Navigation.load url
                    )
