module SSD exposing (..)

import Dict exposing (Dict)
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
    = DD -- Destroyer
    | CL -- Light cruiser
    | CA -- Heavy cruiser
    | BC -- Battlecruiser
    | MS -- Merchant ship


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
