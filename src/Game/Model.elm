module Game.Model where

type alias Model =
  { table : List (List Int)
  , cur : Int
  , size : Int
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
    , size = 3
    , winner = 0
    , draw = False
  }
