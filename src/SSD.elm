module SSD exposing (Boxes(..), ClassCategory(..), Defenses, FacingDefenses, HitLocation, MountedWeapon, SSD, Shielding(..), System(..), WeaponMounts, WrapMode(..), boxesNumber, toString, weapons)

import List.Extra
import Weapons exposing (Weapon)


type alias SSD =
    { name : String
    , category : ClassCategory
    , faction : String
    , baseCost : Int
    , actionPoints : Int
    , structuralIntegrity : Boxes
    , movement : Boxes
    , hitLocations : List HitLocation
    , weaponMounts : WeaponMounts
    , defenses : FacingDefenses
    }


type ClassCategory
    = Destroyer
    | LightCruiser
    | HeavyCruiser
    | BattleCruiser
    | MerchantShip


type Boxes
    = Amount Int -- number of boxes
    | Values (List Int) -- list of boxes, each containing a value


type alias HitLocation =
    { systems : List System
    , wrap : WrapMode
    }


type WrapMode
    = NextLocation
    | StructuralIntegrity


type System
    = CallOut String
    | WithBoxes String Boxes


type alias WeaponMounts =
    { f : List MountedWeapon
    , a : List MountedWeapon
    , p : List MountedWeapon
    , s : List MountedWeapon
    }


type alias MountedWeapon =
    { weapon : Weapon
    , boxes : Boxes
    , ammunition : Maybe Int
    }


type alias FacingDefenses =
    { f : Defenses
    , a : Defenses
    , p : Defenses
    , s : Defenses
    , t : Defenses
    , b : Defenses
    }


type alias Defenses =
    { shielding : Shielding
    , counterMissiles : Maybe Boxes
    , pointDefenses : Maybe Boxes
    , armor : Maybe Int
    }


type Shielding
    = None
    | Wedge
    | Sidewall Boxes


toString : SSD -> String
toString { name, category } =
    let
        cat =
            case category of
                Destroyer ->
                    "DD"

                LightCruiser ->
                    "CL"

                HeavyCruiser ->
                    "CA"

                BattleCruiser ->
                    "BC"

                MerchantShip ->
                    "MS"
    in
    name ++ " (" ++ cat ++ ")"


weapons : SSD -> List Weapon
weapons { weaponMounts } =
    let
        allMounted =
            weaponMounts.a ++ weaponMounts.f ++ weaponMounts.s ++ weaponMounts.p
    in
    allMounted
        |> List.map .weapon
        |> List.Extra.uniqueBy .name


boxesNumber : SSD -> Int
boxesNumber ssd =
    let
        fromSi =
            boxesNumber_ ssd.structuralIntegrity

        fromMvt =
            boxesNumber_ ssd.movement

        fromHitLocs =
            ssd.hitLocations
                |> List.foldl (.systems >> (++)) []
                |> List.map
                    (\s ->
                        case s of
                            WithBoxes _ b ->
                                boxesNumber_ b

                            CallOut _ ->
                                0
                    )
                |> List.sum

        fromMounts =
            [ ssd.weaponMounts.f ++ ssd.weaponMounts.a ++ ssd.weaponMounts.p ++ ssd.weaponMounts.s ]
                |> List.foldl (++) []
                |> List.map (.boxes >> boxesNumber_)
                |> List.sum

        fromDefs =
            [ ssd.defenses.b, ssd.defenses.a, ssd.defenses.f, ssd.defenses.p, ssd.defenses.s, ssd.defenses.t ]
                |> List.map defenseBoxesNumber
                |> List.sum
    in
    fromSi + fromMvt + fromHitLocs + fromMounts + fromDefs


defenseBoxesNumber : Defenses -> Int
defenseBoxesNumber { shielding, counterMissiles, pointDefenses } =
    let
        fromShielding =
            case shielding of
                None ->
                    0

                Wedge ->
                    0

                Sidewall boxes ->
                    boxesNumber_ boxes

        fromCm =
            counterMissiles |> Maybe.map boxesNumber_ |> Maybe.withDefault 0

        fromPd =
            pointDefenses |> Maybe.map boxesNumber_ |> Maybe.withDefault 0
    in
    fromShielding + fromCm + fromPd


boxesNumber_ : Boxes -> Int
boxesNumber_ boxes =
    case boxes of
        Amount nb ->
            nb

        Values values ->
            List.length values
