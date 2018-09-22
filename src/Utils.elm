module Utils exposing (emptyNote, filterNotes, formatDate, idFromPath, setNoteText)

import Array exposing (..)
import Models exposing (Note)
import Routing exposing (notesPath)
import Time exposing (Month, millisToPosix, toDay, toHour, toMinute, toMonth, toYear, utc)



-- Feels weird but is apparently the go right now
-- https://github.com/elm/time/blob/master/src/Time.elm#L384


toMonthString : Month -> String
toMonthString month =
    case month of
        Time.Jan ->
            "Jan"

        Time.Feb ->
            "Feb"

        Time.Mar ->
            "Mar"

        Time.Apr ->
            "Apri"

        Time.May ->
            "May"

        Time.Jun ->
            "Jun"

        Time.Jul ->
            "Jul"

        Time.Aug ->
            "Aug"

        Time.Sep ->
            "Sep"

        Time.Oct ->
            "Oct"

        Time.Nov ->
            "Nov"

        Time.Dec ->
            "Dec"


formatDate timestamp =
    let
        hour =
            String.fromInt (toHour utc timestamp)

        minute =
            String.fromInt (toMinute utc timestamp)

        day =
            String.fromInt (toDay utc timestamp)

        month =
            toMonthString (toMonth utc timestamp)

        year =
            String.fromInt (toYear utc timestamp)
    in
    day ++ " " ++ month ++ " " ++ year


idFromPath path =
    String.replace notesPath "" path



-- Set nested note values


setNoteText : String -> Note -> Note
setNoteText text note =
    { note | text = text }



-- Filter a list of notes by slug or return a new note


filterNotes : String -> Array Note -> Note
filterNotes id notes =
    let
        filteredNotes =
            Array.filter (\n -> n.id == id) notes
    in
    case Array.get 0 filteredNotes of
        Nothing ->
            emptyNote id

        Just note ->
            note



-- Generate a blank note


emptyNote id =
    Note id "" (millisToPosix 0)
