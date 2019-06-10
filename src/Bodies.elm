module Animations exposing (main)

import Html exposing (Html)
import Svg
import Svg.Attributes exposing (..)


type alias Body =
    { name : String
    , color : String
    , orbitalPeriod : Float
    }


bodies : List Body
bodies =
    [ { name = "Sun"
      , color = "#FFCC33"
      , orbitalPeriod = 0
      }
    , { name = "Mercury"
      , color = "#97979F"
      , orbitalPeriod = 2.4
      }
    , { name = "Venus"
      , color = "#BBB7AB"
      , orbitalPeriod = 6.2
      }
    , { name = "Earth"
      , color = "#8CB1DE"
      , orbitalPeriod = 10
      }
    , { name = "Mars"
      , color = "#E27B58"
      , orbitalPeriod = 18.8
      }
    , { name = "Jupiter"
      , color = "#A79C86"
      , orbitalPeriod = 118.6
      }
    , { name = "Saturn"
      , color = "#C5AB6E"
      , orbitalPeriod = 294.5
      }
    , { name = "Uranus"
      , color = "#BBE1E4"
      , orbitalPeriod = 890.2
      }
    , { name = "Neptune"
      , color = "#3E54E8"
      , orbitalPeriod = 1647.9
      }
    ]


centerInt : Int
centerInt =
    600


center : String
center =
    String.fromInt centerInt


centerOffset : Int -> String
centerOffset order =
    order
        * 50
        + centerInt
        |> String.fromInt


centerRotationStart : String
centerRotationStart =
    "0 " ++ String.fromInt centerInt ++ " " ++ String.fromInt centerInt


centerRotationEnd : String
centerRotationEnd =
    "360 " ++ String.fromInt centerInt ++ " " ++ String.fromInt centerInt


viewBody : Int -> Body -> Html msg
viewBody order body =
    Svg.circle
        [ cx center
        , cy (centerOffset order)
        , r "5"
        , fill body.color
        ]
        [ Svg.animateTransform
            [ attributeName "transform"
            , type_ "rotate"
            , from centerRotationStart
            , to centerRotationEnd
            , dur ((body.orbitalPeriod |> String.fromFloat) ++ "s")
            , repeatCount "indefinite"
            ]
            []
        ]


main : Html msg
main =
    Svg.svg
        [ width "1200"
        , height "1200"
        , viewBox "0 0 1200 1200"
        , transform "rotate(-10 50 100) translate(-36 45.5) skewX(40) scale(1 0.5)"
        ]
        (List.indexedMap (\index body -> viewBody index body) bodies)
