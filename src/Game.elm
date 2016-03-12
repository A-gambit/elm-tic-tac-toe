module Game where

import Html exposing (Html)
import StartApp.Simple as StartApp

import Game.Model exposing (initialModel)
import Game.View exposing (view)
import Game.Update exposing (update)

main : Signal Html
main =
  StartApp.start
    { model = initialModel
    , view = view
    , update = update
    }

