module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Msgs exposing (Msg)
import Models exposing (Mode)
import RemoteData

fetchModes : Cmd Msg
fetchModes = Http.get fetchModesUrl modesDecoder
             |> RemoteData.sendRequest
             |> Cmd.map Msgs.OnFetchModes

fetchModesUrl : String
fetchModesUrl = "http://localhost:9292/v1/modes?format=json"

modesDecoder : Decode.Decoder (List Mode)
modesDecoder =
    Decode.at ["modes"] <|Decode.list modeDecoder

modeDecoder : Decode.Decoder Mode
modeDecoder =
    decode Mode
        |> required "name" Decode.string
        |> required "url" Decode.string
