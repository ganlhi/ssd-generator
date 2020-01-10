module Data.Weapons exposing (..)

import Dict
import Weapons exposing (..)



{--------------------------------

        Manticore weapons

---------------------------------}
-- Missiles


mk34AntiShipMissile : Weapon
mk34AntiShipMissile =
    { name = "Mk34 Anti-Ship Missile"
    , category = Missile
    , rangeBands =
        [ { range = ( 0, 6 ), accuracy = 4, damage = 3, penetration = 1 }
        , { range = ( 7, 18 ), accuracy = 6, damage = 3, penetration = 1 }
        , { range = ( 19, 26 ), accuracy = 9, damage = 3, penetration = 1 }
        ]
    , properties =
        Dict.fromList
            [ ( "Evasion", "6+" )
            ]
    }



-- Lasers


mk32_70mmLaser : Weapon
mk32_70mmLaser =
    { name = "Mk32 70mm Laser"
    , category = Laser
    , rangeBands =
        [ { range = ( 0, 1 ), accuracy = 3, damage = 6, penetration = 1 }
        , { range = ( 2, 2 ), accuracy = 4, damage = 4, penetration = 1 }
        ]
    , properties = Dict.empty
    }


mk31_60mmLaser : Weapon
mk31_60mmLaser =
    { name = "Mk31 60mm Laser"
    , category = Laser
    , rangeBands =
        [ { range = ( 0, 1 ), accuracy = 3, damage = 5, penetration = 1 }
        , { range = ( 2, 2 ), accuracy = 4, damage = 3, penetration = 1 }
        ]
    , properties = Dict.empty
    }



{--------------------------------

        Haven weapons

---------------------------------}
-- Missiles


e14AntiShipMissile : Weapon
e14AntiShipMissile =
    { name = "E14 Anti-Ship Missile"
    , category = Missile
    , rangeBands =
        [ { range = ( 0, 6 ), accuracy = 5, damage = 3, penetration = 1 }
        , { range = ( 7, 17 ), accuracy = 7, damage = 3, penetration = 1 }
        , { range = ( 18, 26 ), accuracy = 10, damage = 3, penetration = 1 }
        ]
    , properties =
        Dict.fromList
            [ ( "Evasion", "7+" )
            ]
    }



-- Lasers


l75Laser : Weapon
l75Laser =
    { name = "L/75 Laser"
    , category = Laser
    , rangeBands =
        [ { range = ( 0, 1 ), accuracy = 3, damage = 6, penetration = 1 }
        , { range = ( 2, 2 ), accuracy = 4, damage = 4, penetration = 1 }
        ]
    , properties = Dict.empty
    }


l66Laser : Weapon
l66Laser =
    { name = "L/66 Laser"
    , category = Laser
    , rangeBands =
        [ { range = ( 0, 1 ), accuracy = 3, damage = 5, penetration = 1 }
        , { range = ( 2, 2 ), accuracy = 4, damage = 3, penetration = 1 }
        ]
    , properties = Dict.empty
    }
