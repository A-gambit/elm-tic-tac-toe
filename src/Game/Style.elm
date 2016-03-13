module Game.Style where

import Html exposing (Attribute)
import Html.Attributes exposing (style)

import Game.Model exposing (initialModel, Mark (..))

itemSize : Int
itemSize = 60

marginSize : Int
marginSize = 3

blockWith : Int -> Int
blockWith size =
  size * 66

content : Int -> Attribute
content size =
  style
    [ ("backgroundColor", "#fff")
    , ("height", (++) (toString <| (+) 200 <| blockWith size) "px")
    , ("overflow", "hidden")
    , ("width", "100%")
    ]

title : Attribute
title =
  style
    [ ("display", "block")
    , ("margin", "40px 0 20px 0")
    , ("color", "#5a5b5f")
    , ("text-align", "center")
    , ("font-size", "32px")
    ]

sub : Attribute
sub =
  style [ ("text-align", "center") ]


sizeWrapper : Attribute
sizeWrapper =
  style
    [ ("display", "block")
    , ("margin", "0 auto 10px auto")
    , ("width", "105px")
    ]

sizeLabel : Attribute
sizeLabel =
  style
    [ ("display", "inline-block")
    , ("color", "#5a5b5f")
    , ("font-size", "18px")
    , ("cursor", "pointer")
    ]

sizeInput : Attribute
sizeInput =
  style
    [ ("display", "inline-block")
    , ("background", "#dedede")
    , ("font-size", "18px")
    , ("padding", "4px")
    , ("border", "none")
    , ("margin-left", "10px")
    , ("outline", "none")
    , ("width", "50px")
    ]


restart : Attribute
restart =
  style
    [ ("display", "inline-block")
    , ("color", "#acacae")
    , ("font-size", "18px")
    , ("cursor", "pointer")
    ]

win : Attribute
win =
  style
    [ ("display", "inline-block")
    , ("color", "#5a5b5f")
    , ("font-size", "18px")
    , ("margin-right", "15px")
    ]

table : Int -> Attribute
table size =
  style
    [ ("display", "block")
    , ("width", (++) (toString <| blockWith size ) "px" )
    , ("margin", "20px auto")
    ]

itemWrapper : Mark -> Attribute
itemWrapper val =
  let
    cursorStyle styleList =
      if val == NoN then
        ("cursor", "pointer") :: styleList
      else
        ("cursor", "default") :: styleList
  in
    style <| cursorStyle <|
      [ ("width", (++) (toString itemSize) "px")
      , ("height", (++) (toString itemSize) "px")
      , ("display", "inline-block")
      , ("margin", (++) (toString marginSize) "px")
      , ("background", "#dedede")
      , ("border-radius", "4px")
      , ("vertical-align", "top")
      ]

itemStyle : List (String, String)
itemStyle =
    [ ("line-height", "60px")
    , ("text-align", "center")
    , ("display", "block")
    , ("font-size", "30px")
    ]

cross : Attribute
cross =
   style <| ("color", "#5D45D2") :: itemStyle

circle : Attribute
circle =
   style <| ("color", "#F54444") :: itemStyle
