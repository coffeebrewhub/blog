module Page.Index exposing (Data, Model, Msg, page)

import DataSource exposing (DataSource)
import Head
import Head.Seo as Seo
import Html exposing (Html)
import Html.Attributes exposing (class)
import Markdown.Block exposing (Block)
import Markdown.Parser exposing (deadEndToString)
import Markdown.Renderer exposing (defaultHtmlRenderer)
import Page exposing (Page, StaticPayload)
import Pages.PageUrl exposing (PageUrl)
import Pages.Url
import Shared
import View exposing (View)



type alias Model =
    ()


type alias Msg =
    Never


type alias RouteParams =
    {}


page : Page RouteParams Data
page =
    Page.single
        { head = head
        , data = data
        }
        |> Page.buildNoState { view = view }


data : DataSource Data
data =
    DataSource.succeed ()


head :
    StaticPayload Data RouteParams
    -> List Head.Tag
head static =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "BrewHub.coffee blog"
        , image =
            { url = Pages.Url.external "TODO"
            , alt = "elm-pages logo"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "Everything you need to know about coffee - brewing, equipment, news."
        , locale = Just "en_US"
        , title = "BrewHub.coffee blog - Everything you need to know about coffee brewing, from the experts at BrewHub."
        }
        |> Seo.website


type alias Data =
    ()


deadEndsToString deadEnds =
    deadEnds
        |> List.map Markdown.Parser.deadEndToString
        |> String.join "\n"


render renderer markdown =
    case
        markdown
            |> Markdown.Parser.parse
            |> Result.mapError deadEndsToString
            |> Result.andThen (\ast -> Markdown.Renderer.render renderer ast)
    of
        Ok rendered ->
            Html.div [] rendered

        Err errors ->
            Html.text errors


markdownContentRendered : Html msg
markdownContentRendered =
    render defaultHtmlRenderer "BrewHub blog"


view :
    Maybe PageUrl
    -> Shared.Model
    -> StaticPayload Data RouteParams
    -> View Msg
view maybeUrl sharedModel static =
    { title = "BrewHub blog"
    , body =
        [ Html.div
            [ class "page-root"]
            [ markdownContentRendered ]
        ]
    }



