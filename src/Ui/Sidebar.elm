module Ui.Sidebar exposing (sidebar)

import Element exposing (Element, alignTop, column, el, fill, height, htmlAttribute, padding, row, spacing, text)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html.Attributes exposing (class)
import SSD exposing (SSD)
import Ui.Colors as Colors


sidebar : List SSD -> Maybe SSD -> (SSD -> msg) -> Element msg
sidebar list current toMsg =
    let
        factions =
            List.map .faction list
    in
    factions
        |> List.map (factionEntry list current toMsg)
        |> column
            [ spacing 8
            , padding 8
            , height fill
            , alignTop
            , Border.widthEach { top = 0, bottom = 0, left = 0, right = 1 }
            , htmlAttribute <| class "sidebar"
            ]


factionList : String -> List SSD -> List SSD
factionList faction =
    List.filter <| (.faction >> (==) faction)


factionEntry : List SSD -> Maybe SSD -> (SSD -> msg) -> String -> Element msg
factionEntry list current toMsg faction =
    let
        l =
            factionList faction list
    in
    column [ spacing 4 ]
        (el [ Font.underline, Font.size 16 ] (text faction)
            :: List.map (ssdEntry current toMsg) l
        )


ssdEntry : Maybe SSD -> (SSD -> msg) -> SSD -> Element msg
ssdEntry current toMsg ssd =
    let
        isActive =
            case current of
                Nothing ->
                    False

                Just c ->
                    c == ssd

        color =
            if isActive then
                Colors.white

            else
                Colors.black

        bgColor =
            if isActive then
                Colors.blue

            else
                Colors.none
    in
    Input.button
        [ Background.color bgColor
        , Font.color color
        , Font.size 14
        , padding 4
        ]
        { label = text <| SSD.toString ssd
        , onPress = Just (toMsg ssd)
        }
