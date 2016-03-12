module Game.Style where

import Html exposing (Attribute)
import Html.Attributes exposing (style)

import Game.Model exposing (initialModel)

content : Attribute
content =
  style
    [ ("backgroundColor", "#fff")
    , ("height", "500px")
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

table : Attribute
table =
  style
    [ ("display", "block")
    , ("width", "198px" )
    , ("margin", "20px auto")
    ]

itemWrapper : Int -> Attribute
itemWrapper val =
  let
    styleList =
      [ ("width", "60px")
      , ("height", "60px")
      , ("display", "inline-block")
      , ("margin", "3px")
      , ("background", "#dedede")
      , ("border-radius", "4px")
      , ("vertical-align", "top")
      ]
    cursorStyle list =
      if val == 0 then
        ("cursor", "pointer") :: list
      else
        ("cursor", "default") :: list
  in
    style <| cursorStyle <| styleList


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
