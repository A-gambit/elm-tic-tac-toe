module Game.Model where

type alias Model =
  { table : List (List Int)
  , cur : Int
  , winner : Int
  , draw : Bool
  }

initialModel : Model
initialModel =
  { table =
    [ [ 0, 0, 0 ]
    , [ 0, 0, 0 ]
    , [ 0, 0, 0 ]
    ]
    , cur = 1
    , winner = 0
    , draw = False
  }
