module Ui.SSD exposing (ssdView)

import Dict exposing (Dict)
import Element exposing (Attribute, Element, alignLeft, alignRight, alignTop, centerX, centerY, column, el, fill, fillPortion, height, maximum, padding, paddingEach, paragraph, px, row, spaceEvenly, spacing, table, text, width, wrappedRow)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import List.Extra
import SSD exposing (Boxes(..), Defenses, HitLocation, MountedWeapon, SSD, Shielding(..), System(..), WeaponMounts, WrapMode(..), boxesNumber, weapons)
import Ui.Colors as Colors
import Weapons exposing (RangeBand, Weapon, WeaponCategory(..))



-- Main view function


ssdView : SSD -> Element msg
ssdView ssd =
    column
        [ Font.size 14
        , Font.color Colors.darkgray
        , alignTop
        , width fill
        , spacing 16
        , padding 8
        ]
        [ header ssd
        , row
            [ width fill
            , spacing 16

            --, Element.explain Debug.todo
            ]
            [ hitLocations ssd
            , column
                [ width <| fillPortion 2
                , height fill
                , alignTop
                , spacing 8
                ]
                [ structuralIntegrity ssd.structuralIntegrity
                , facings ssd
                ]
            , weaponCards ssd
            , actionPoints ssd.actionPoints
            ]
        ]



-- Header


header : SSD -> Element msg
header ssd =
    let
        pointsTxt =
            String.fromInt ssd.baseCost ++ " Points"

        boxesTxt =
            String.fromInt (boxesNumber ssd) ++ " Boxes"

        placeholderFieldsAttrs =
            [ Border.color Colors.gray
            , Border.width 2
            , Border.rounded 4
            , Font.color Colors.gray
            , Font.size 16
            , Font.center
            , padding 4
            ]
    in
    row
        [ spaceEvenly
        , width fill
        , padding 8
        , Border.rounded 4
        , Background.color Colors.lightgray
        ]
        [ el [ Font.size 12 ] <| text <| String.join " / " [ pointsTxt, boxesTxt ]
        , el [ Font.size 16, Font.bold ] <| text (SSD.toString ssd ++ ", " ++ ssd.faction)
        , row [ spacing 8 ]
            [ el ((width <| px 40) :: placeholderFieldsAttrs) <| text "#"
            , el ((width <| px 80) :: placeholderFieldsAttrs) <| text "Crew"
            , el ((width <| px 200) :: placeholderFieldsAttrs) <| text "Unit name"
            ]
        ]



-- Hit locations


hitLocations : SSD -> Element msg
hitLocations ssd =
    List.indexedMap hitLocation ssd.hitLocations
        |> column
            [ width <| fillPortion 2
            , height fill
            , alignTop
            , spacing 8
            ]


hitLocation : Int -> HitLocation -> Element msg
hitLocation index hl =
    let
        wrapModeTxt =
            case hl.wrap of
                NextLocation ->
                    ">"

                StructuralIntegrity ->
                    "#"

        nbSystems =
            List.length hl.systems

        ( extraEl, lengthWithExtra ) =
            if nbSystems >= 3 then
                ( Element.none, nbSystems )

            else
                case List.Extra.last hl.systems of
                    Just (WithBoxes _ _) ->
                        ( el [ width <| fillPortion 1 ] Element.none, nbSystems + 1 )

                    _ ->
                        ( Element.none, nbSystems )
    in
    row
        [ width fill
        , height <| px 50
        , Border.width 1
        , Border.color Colors.gray
        ]
        [ column [ width <| px 36, height fill, padding 8, Font.size 16, Background.color Colors.gray ]
            [ el [ centerX, centerY ] <| text <| String.fromInt (index + 1)
            ]
        , wrappedRow [ height fill, padding 8, width fill, spaceEvenly ] <|
            List.indexedMap (system lengthWithExtra) hl.systems
                ++ [ extraEl ]
        , el [ width <| px 24, height fill, padding 8, Font.size 16, Background.color Colors.gray ] <|
            el [ centerX, centerY ] (text wrapModeTxt)
        ]


system : Int -> Int -> System -> Element msg
system nb index s =
    let
        alignment =
            if index == 0 then
                alignLeft

            else if index == nb - 1 then
                alignRight

            else
                centerX

        systemEl =
            case s of
                CallOut name ->
                    el [ alignment ] <| text name

                WithBoxes name bxs ->
                    row [ alignment, spacing 4 ]
                        [ el [] <| text name
                        , boxes bxs
                        ]
    in
    el [ width <| fillPortion 1 ] systemEl



-- SI


structuralIntegrity : Boxes -> Element msg
structuralIntegrity siBoxes =
    row
        [ width fill
        , padding 8
        , spaceEvenly
        , Background.color Colors.lightgray
        , Border.rounded 4
        ]
        [ el [ Font.size 16 ] <| text "Structural Integrity"
        , boxes siBoxes
        ]



-- Facings


facings : SSD -> Element msg
facings ssd =
    column [ spacing 8, width fill ]
        [ facing "Forward" ssd.weaponMounts.f ssd.defenses.f
        , facing "Aft" ssd.weaponMounts.a ssd.defenses.a
        , facing "Port" ssd.weaponMounts.p ssd.defenses.p
        , facing "Starboard" ssd.weaponMounts.s ssd.defenses.s
        , facing "Top" [] ssd.defenses.t
        , facing "Bottom" [] ssd.defenses.b
        ]


facing : String -> List MountedWeapon -> Defenses -> Element msg
facing name mountedWeapons defenses =
    column [ width fill ]
        [ el
            [ Background.color Colors.gray
            , padding 8
            , Border.roundEach { topLeft = 4, topRight = 4, bottomLeft = 0, bottomRight = 0 }
            ]
          <|
            text name
        , row
            [ width fill
            , spacing 8
            , padding 8
            , Border.color Colors.gray
            , Border.width 1
            , Border.roundEach { topLeft = 0, topRight = 0, bottomLeft = 4, bottomRight = 4 }
            ]
            [ mountedWeaponsView mountedWeapons
            , defensesView defenses
            ]
        ]


mountedWeaponsView : List MountedWeapon -> Element msg
mountedWeaponsView mountedWeapons =
    column [ width <| fillPortion 2, spacing 8, alignTop ] <|
        List.map mountedWeaponView mountedWeapons


mountedWeaponView : MountedWeapon -> Element msg
mountedWeaponView mw =
    let
        ammunition =
            case mw.ammunition of
                Just nb ->
                    ammunitionsView nb

                Nothing ->
                    Element.none
    in
    column [ spacing 4 ]
        [ weaponName mw.weapon
        , el [ padLeft 16 ] <| boxes mw.boxes
        , el [ padLeft 16 ] <| ammunition
        ]


ammunitionsView : Int -> Element msg
ammunitionsView nb =
    (el
        [ Border.width 1
        , Border.rounded 6
        , width <| px 12
        , height <| px 12
        ]
     <|
        text ""
    )
        |> List.repeat nb
        |> wrappedRow [ spacing 4, width <| maximum 200 <| fill ]


defensesView : Defenses -> Element msg
defensesView defenses =
    column [ width <| fillPortion 1, alignTop, spacing 8 ]
        [ shieldingView defenses.shielding
        , activeDefenseView "CM" defenses.counterMissiles
        , activeDefenseView "PD" defenses.pointDefenses
        , armorView defenses.armor
        ]


shieldingView : Shielding -> Element msg
shieldingView shielding =
    case shielding of
        None ->
            Element.none

        Wedge ->
            el [] <| text "Wedge"

        Sidewall bxs ->
            row [ spacing 4 ]
                [ text "Sidewall"
                , boxes bxs
                ]


activeDefenseView : String -> Maybe Boxes -> Element msg
activeDefenseView name maybeBoxes =
    case maybeBoxes of
        Nothing ->
            Element.none

        Just bxs ->
            row [ spacing 4 ]
                [ text name
                , boxes bxs
                ]


armorView : Maybe Int -> Element msg
armorView =
    Maybe.map (\armor -> text <| "Armor " ++ String.fromInt armor)
        >> Maybe.withDefault Element.none



-- Weapon card


weaponCards : SSD -> Element msg
weaponCards ssd =
    ssd
        |> weapons
        |> List.map weaponCard
        |> column
            [ spacing 8
            , width <| fillPortion 1
            , height fill
            , alignTop
            ]


weaponCard : Weapon -> Element msg
weaponCard weapon =
    column [ padding 4, spacing 8, Border.width 1, width fill ]
        [ weaponName weapon
        , row [ spacing 16 ]
            [ rangeBandsTable weapon.rangeBands
            , propertiesList weapon.properties
            ]
        ]


rangeBandsTable : List RangeBand -> Element msg
rangeBandsTable rangeBands =
    table [ alignTop, spacing 4, Font.alignRight ]
        { data = rangeBands
        , columns =
            [ { header = text "RNG"
              , width = fillPortion 1
              , view = .range >> rangeToString >> text
              }
            , { header = text "ACC"
              , width = fillPortion 1
              , view = .accuracy >> String.fromInt >> (\s -> s ++ "+") >> text
              }
            , { header = text "DMG"
              , width = fillPortion 1
              , view = .damage >> String.fromInt >> text
              }
            , { header = text "PEN"
              , width = fillPortion 1
              , view = .penetration >> String.fromInt >> text
              }
            ]
        }


rangeToString : ( Int, Int ) -> String
rangeToString ( min, max ) =
    if min == max then
        String.fromInt min

    else
        String.fromInt min ++ "-" ++ String.fromInt max


propertiesList : Dict String String -> Element msg
propertiesList props =
    Dict.foldl addProp [] props
        |> column [ alignTop, Font.italic ]


addProp : String -> String -> List (Element msg) -> List (Element msg)
addProp prop value els =
    el [] (text <| String.join " " [ prop, value ]) :: els



-- Action points


actionPoints : Int -> Element msg
actionPoints nb =
    List.range 1 10
        |> List.map (actionPoint nb)
        |> column
            [ alignTop
            , spacing 8
            , height fill
            ]


actionPoint : Int -> Int -> Element msg
actionPoint max value =
    let
        commonAttrs =
            [ Font.size 16
            , Font.bold
            , Border.width 2
            , Border.rounded 4
            , width <| px 24
            , height <| px 24
            , Font.center
            ]

        attrs =
            if value <= max then
                [ Background.color Colors.lightgray
                , Border.color Colors.darkgray
                ]
                    ++ commonAttrs

            else
                [ Background.color Colors.white
                , Font.color Colors.lightgray
                , Border.color Colors.lightgray
                ]
                    ++ commonAttrs
    in
    String.fromInt value
        |> text
        |> List.singleton
        |> paragraph
            attrs



-- Common utilities


type BoxPosition
    = First
    | Last
    | Other
    | Single


boxes : Boxes -> Element msg
boxes bxs =
    case bxs of
        Amount nb ->
            List.repeat nb Nothing
                |> List.indexedMap (\i bx -> box bx (boxPos i nb))
                |> row []

        Values values ->
            let
                nb =
                    List.length values
            in
            values
                |> List.map (String.fromInt >> Just)
                |> List.indexedMap (\i bx -> box bx (boxPos i nb))
                |> row []


boxPos : Int -> Int -> BoxPosition
boxPos index total =
    let
        lastIndex =
            total - 1
    in
    if total == 1 then
        Single

    else if index == 0 then
        First

    else if index == lastIndex then
        Last

    else
        Other


box : Maybe String -> BoxPosition -> Element msg
box content pos =
    let
        txt =
            text <| Maybe.withDefault "" content

        borders3 =
            Border.widthEach { top = 1, bottom = 1, left = 1, right = 0 }

        borders =
            case pos of
                First ->
                    borders3

                Last ->
                    Border.width 1

                Other ->
                    borders3

                Single ->
                    Border.width 1
    in
    el
        [ borders
        , width <| px 12
        , height <| px 15
        ]
        txt


weaponName : Weapon -> Element msg
weaponName weapon =
    el
        [ if weapon.category == Missile then
            Font.underline

          else
            Font.regular
        ]
        (text weapon.name)


padLeft : Int -> Attribute msg
padLeft p =
    paddingEach
        { top = 0
        , right = 0
        , bottom = 0
        , left = p
        }
