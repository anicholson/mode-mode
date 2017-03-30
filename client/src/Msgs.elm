module Msgs exposing (..)

import Models exposing (Mode)
import RemoteData exposing (WebData)


type Msg
    = NoOp
    | OnFetchModes (WebData (List Mode))
