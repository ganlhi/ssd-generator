module Weapons exposing (RangeBand, Weapon, WeaponCategory(..))

import Dict exposing (Dict)


type alias Weapon =
    { name : String
    , category : WeaponCategory
    , rangeBands : List RangeBand
    , properties : Dict String String
    }


type WeaponCategory
    = Laser
    | Graser
    | Missile


type alias RangeBand =
    { range : ( Int, Int )
    , accuracy : Int
    , damage : Int
    , penetration : Int
    }
