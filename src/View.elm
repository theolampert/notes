module View exposing (view)

import Array
import Browser
import Html exposing (..)
import Html.Attributes exposing (attribute, class, href, value)
import Html.Events exposing (onClick, onInput)
import Models exposing (Model, Note)
import Msgs exposing (..)
import Routing
import Time
import Utils exposing (filterNotes, formatDate)



-- Hacky way to load a stylesheet into elm reactor


stylesheet =
    let
        tag =
            "link"

        attrs =
            [ attribute "rel" "stylesheet"
            , attribute "property" "stylesheet"
            , attribute "href" "/style.css"
            ]

        children =
            []
    in
    node tag attrs children


focusedNote : Note -> Html Msg
focusedNote note =
    div [ class "note-detail" ]
        [ textarea [ onInput UpdateNote, value note.text ] []
        ]


noteListItemView : Note -> Html li
noteListItemView note =
    li []
        [ a [ href (Routing.notePath note.id) ]
            [ div [ class "note-list-text" ] [ text note.text ]
            , div [ class "note-list-date" ] [ text (formatDate note.ts) ]
            ]
        ]


noteListView : List Note -> Html Msg
noteListView notes =
    let
        newNotePath =
            Routing.notePath (String.fromInt (List.length notes))
    in
    div [ class "note-list" ]
        [ a [ href newNotePath, class "new-note", onClick (UpdateNote " ") ] [ text "➕ New Note" ]
        , ul []
            (List.map noteListItemView notes)
        ]


notesView : Model -> Html Msg
notesView model =
    div [ class "wrapper" ]
        [ noteListView (Array.toList model.notes)
        , focusedNote model.focusedNote
        ]


page : Model -> Html Msg
page model =
    notesView model


view : Model -> Browser.Document Msg
view model =
    { title = "🛰 Notes"
    , body = [ stylesheet, page model ]
    }
