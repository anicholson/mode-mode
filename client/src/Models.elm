module Models exposing (..)

import RemoteData exposing (WebData)


type alias Mode =
    { name : String
    , url : String
    }


type alias Model =
    { searchListing : Maybe String
    , currentModes : WebData (List Mode)
    }


initialModel : Model
initialModel =
    { searchListing = Nothing, currentModes = RemoteData.NotAsked }
