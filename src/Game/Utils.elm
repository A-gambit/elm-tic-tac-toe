module Game.Utils where

import Signal exposing (Address)
import Html exposing (Attribute)
import Html.Events exposing (on, targetValue)

onInput : Address a -> (String -> a) -> Attribute
onInput address f =
  on "input" targetValue (\v -> Signal.message address (f v))
