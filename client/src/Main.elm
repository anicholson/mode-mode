module Main exposing (..)

import Html exposing (Html, p, h1, h2, div, section, input, text, program)
import Html.Attributes exposing (class, placeholder)


type alias Mode =
    { name : String
    , url : String
    }


type alias Model =
    { searchListing : Maybe String
    , currentModes : List Mode
    }


init : ( Model, Cmd Msg )
init =
    ( { searchListing = Nothing, currentModes = [] }, Cmd.none )


type Msg
    = NoOp


renderMode : Mode -> Html Msg
renderMode mode =
    p [ class "mode" ] [ text mode.name ]


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
        , section [ class "section" ]
            (List.map
                renderMode
                model.currentModes
            )
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


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
