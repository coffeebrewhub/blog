module Component.Header exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)

type alias Model =
    {}

type Msg =
    NoOp

view: Html msg
view =
    header [ class "header" ]
        [
            h2 [ class "blog-title" ] [ text "brewhub.coffee blog" ]
            , nav [ class "nav" ] []
            --[ ul [ class "nav-list"]
            --    [ li [] [ a [ href "/" ] [ text "Home" ] ]
            --    , li [] [ a [ href "/about" ] [ text "About" ] ]
            --    -- add more links here
            --    ]
            --]
        ]
