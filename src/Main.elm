module Main exposing (main)

import Browser
import Data.Ships exposing (allShips)
import Element exposing (centerX, centerY, el, fill, focusStyle, height, layout, layoutWith, padding, row, spacing, text, width)
import Html exposing (Html)
import SSD exposing (SSD)
import Ui.SSD exposing (ssdView)
import Ui.Sidebar exposing (sidebar)


type Msg
    = Select SSD


type alias Model =
    { ssd : Maybe SSD }


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { ssd = Nothing }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Select ssd ->
            ( { model | ssd = Just ssd }, Cmd.none )


view : Model -> Html Msg
view { ssd } =
    let
        options =
            { options =
                [ focusStyle
                    { borderColor = Nothing
                    , backgroundColor = Nothing
                    , shadow = Nothing
                    }
                ]
            }
    in
    layoutWith options [] <|
        row [ width fill, height fill, padding 8, spacing 8 ]
            [ sidebar allShips ssd Select
            , case ssd of
                Nothing ->
                    el [ centerX, centerY ] (text "Select a SSD in the sidebar")

                Just s ->
                    ssdView s
            ]
