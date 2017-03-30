module Main exposing (..)

import Html exposing (Html, p, h1, h2, div, section, input, text, program)
import Html.Attributes exposing (class, placeholder)
import Msgs exposing (Msg)
import Models exposing (..)
import RemoteData
import Commands exposing (fetchModes)


init : ( Model, Cmd Msg )
init =
    ( initialModel, fetchModes )


renderMode : Mode -> Html Msg
renderMode mode =
    p [ class "mode" ] [ text mode.name ]


showModes modes =
    case modes of
        RemoteData.Success m ->
            if List.isEmpty m then
                [ text "No matching modes found." ]
            else
                (List.map
                    renderMode
                    m
                )

        RemoteData.Failure f ->
            [ text <| (Debug.log "Error fetching modes:" (toString f)) ]

        otherwise ->
            [ text "Fetching…" ]


view : Model -> Html Msg
view model =
    div []
        [ section [ class "section hero is-primary" ]
            [ h1 [ class "title" ] [ text "mode-mode" ]
            , h2 [ class "subtitle" ] [ text "(emacs-mode-for-that-p 'x) => t" ]
            ]
        , section [ class "section" ]
            [ input [ class "input", placeholder "Search for a mode" ] []
            ]
        , section [ class "section" ] <| showModes model.currentModes
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.NoOp ->
            ( model, Cmd.none )

        Msgs.OnFetchModes response ->
            ( { model | currentModes = response }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
