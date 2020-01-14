module Data.Ships exposing (allShips)

import Data.Weapons as W
import Dict exposing (Dict)
import SSD exposing (..)


allShips : List SSD
allShips =
    [ rmn_dd_havok
    , pn_dd_bastogne
    ]


rmn_dd_havok : SSD
rmn_dd_havok =
    { name = "Havok"
    , category = Destroyer
    , faction = "RMN"
    , baseCost = 35
    , actionPoints = 1
    , structuralIntegrity = Amount 7
    , movement =
        Values [ 3, 3, 3, 2, 2, 2, 2, 1, 1, 1 ]
    , hitLocations =
        [ { systems =
                [ WithBoxes "Cargo" <| Amount 1
                , WithBoxes "Decoy" <| Amount 2
                , CallOut "M"
                ]
          , wrap = NextLocation
          }
        , { systems =
                [ WithBoxes "Hull" <| Amount 2
                , CallOut "PD"
                ]
          , wrap = NextLocation
          }
        , { systems =
                [ WithBoxes "Hull" <| Amount 2
                , WithBoxes "Fwd Imp" <| Amount 5
                ]
          , wrap = NextLocation
          }
        , { systems =
                [ WithBoxes "Cargo" <| Amount 1
                , CallOut "L"
                ]
          , wrap = NextLocation
          }
        , { systems =
                [ WithBoxes "Hull" <| Amount 2
                , WithBoxes "ECM" <| Values [ 1 ]
                , WithBoxes "Bridge" <| Values [ 1 ]
                ]
          , wrap = StructuralIntegrity
          }
        , { systems =
                [ WithBoxes "Cargo" <| Amount 1
                , WithBoxes "Roll" <| Values [ 6, 4, 2 ]
                , WithBoxes "Pivot" <| Values [ 6, 4, 2 ]
                ]
          , wrap = StructuralIntegrity
          }
        , { systems =
                [ WithBoxes "Hull" <| Amount 2
                , WithBoxes "ECCM" <| Values [ 1 ]
                ]
          , wrap = NextLocation
          }
        , { systems =
                [ WithBoxes "Cargo" <| Amount 1
                , WithBoxes "Aft Imp" <| Amount 5
                ]
          , wrap = NextLocation
          }
        , { systems =
                [ WithBoxes "Hull" <| Amount 2
                , CallOut "CM"
                ]
          , wrap = NextLocation
          }
        , { systems =
                [ WithBoxes "Cargo" <| Amount 1
                , WithBoxes "Dmg Ctrl" <| Values [ 2, 1 ]
                ]
          , wrap = StructuralIntegrity
          }
        ]
    , weaponMounts =
        { f =
            [ { weapon = W.mk34AntiShipMissile
              , boxes = Amount 2
              , ammunition = Just 12
              }
            , { weapon = W.mk32_70mmLaser
              , boxes = Amount 1
              , ammunition = Nothing
              }
            ]
        , a =
            [ { weapon = W.mk34AntiShipMissile
              , boxes = Amount 2
              , ammunition = Just 12
              }
            , { weapon = W.mk32_70mmLaser
              , boxes = Amount 1
              , ammunition = Nothing
              }
            ]
        , p =
            [ { weapon = W.mk34AntiShipMissile
              , boxes = Amount 5
              , ammunition = Just 18
              }
            , { weapon = W.mk31_60mmLaser
              , boxes = Amount 1
              , ammunition = Nothing
              }
            ]
        , s =
            [ { weapon = W.mk34AntiShipMissile
              , boxes = Amount 5
              , ammunition = Just 18
              }
            , { weapon = W.mk31_60mmLaser
              , boxes = Amount 1
              , ammunition = Nothing
              }
            ]
        }
    , defenses =
        { f =
            { shielding = None
            , counterMissiles = Just <| Values [ 2, 1 ]
            , pointDefenses = Just <| Values [ 1, 1 ]
            , armor = Just 1
            }
        , a =
            { shielding = Sidewall <| Values [ 1 ]
            , counterMissiles = Just <| Values [ 2, 1 ]
            , pointDefenses = Just <| Values [ 1, 1 ]
            , armor = Just 1
            }
        , p =
            { shielding = Sidewall <| Values [ 2, 1 ]
            , counterMissiles = Just <| Values [ 2, 2, 1 ]
            , pointDefenses = Just <| Values [ 2, 1, 1 ]
            , armor = Just 1
            }
        , s =
            { shielding = Sidewall <| Values [ 2, 1 ]
            , counterMissiles = Just <| Values [ 2, 2, 1 ]
            , pointDefenses = Just <| Values [ 2, 1, 1 ]
            , armor = Just 1
            }
        , t =
            { shielding = Wedge
            , counterMissiles = Nothing
            , pointDefenses = Nothing
            , armor = Just 1
            }
        , b =
            { shielding = Wedge
            , counterMissiles = Nothing
            , pointDefenses = Nothing
            , armor = Just 1
            }
        }
    }


pn_dd_bastogne : SSD
pn_dd_bastogne =
    { name = "Bastogne"
    , category = Destroyer
    , faction = "PN"
    , baseCost = 32
    , actionPoints = 1
    , structuralIntegrity = Amount 7
    , movement =
        Values [ 3, 3, 3, 2, 2, 2, 2, 1, 1, 1 ]
    , hitLocations =
        [ { systems =
                [ WithBoxes "Cargo" <| Amount 1
                , WithBoxes "Decoy" <| Amount 1
                , CallOut "M"
                ]
          , wrap = NextLocation
          }
        , { systems =
                [ WithBoxes "Hull" <| Amount 2
                , CallOut "PD"
                ]
          , wrap = NextLocation
          }
        , { systems =
                [ WithBoxes "Hull" <| Amount 2
                , WithBoxes "Fwd Imp" <| Amount 5
                ]
          , wrap = NextLocation
          }
        , { systems =
                [ WithBoxes "Cargo" <| Amount 1
                , CallOut "L"
                ]
          , wrap = NextLocation
          }
        , { systems =
                [ WithBoxes "Hull" <| Amount 2
                , WithBoxes "ECM" <| Values [ 1 ]
                , WithBoxes "Bridge" <| Values [ 1 ]
                ]
          , wrap = StructuralIntegrity
          }
        , { systems =
                [ WithBoxes "Cargo" <| Amount 1
                , WithBoxes "Roll" <| Values [ 5, 4, 2 ]
                , WithBoxes "Pivot" <| Values [ 5, 4, 2 ]
                ]
          , wrap = StructuralIntegrity
          }
        , { systems =
                [ WithBoxes "Hull" <| Amount 2
                , WithBoxes "ECCM" <| Values [ 1 ]
                ]
          , wrap = NextLocation
          }
        , { systems =
                [ WithBoxes "Cargo" <| Amount 1
                , WithBoxes "Aft Imp" <| Amount 5
                ]
          , wrap = NextLocation
          }
        , { systems =
                [ WithBoxes "Hull" <| Amount 2
                , CallOut "CM"
                ]
          , wrap = NextLocation
          }
        , { systems =
                [ WithBoxes "Cargo" <| Amount 1
                , WithBoxes "Dmg Ctrl" <| Values [ 3, 2, 1 ]
                ]
          , wrap = StructuralIntegrity
          }
        ]
    , weaponMounts =
        { f =
            [ { weapon = W.e14AntiShipMissile
              , boxes = Amount 1
              , ammunition = Just 9
              }
            , { weapon = W.l75Laser
              , boxes = Amount 1
              , ammunition = Nothing
              }
            ]
        , a =
            [ { weapon = W.e14AntiShipMissile
              , boxes = Amount 1
              , ammunition = Just 9
              }
            , { weapon = W.l75Laser
              , boxes = Amount 1
              , ammunition = Nothing
              }
            ]
        , p =
            [ { weapon = W.e14AntiShipMissile
              , boxes = Amount 8
              , ammunition = Just 9
              }
            , { weapon = W.l66Laser
              , boxes = Amount 1
              , ammunition = Nothing
              }
            ]
        , s =
            [ { weapon = W.e14AntiShipMissile
              , boxes = Amount 8
              , ammunition = Just 9
              }
            , { weapon = W.l66Laser
              , boxes = Amount 1
              , ammunition = Nothing
              }
            ]
        }
    , defenses =
        { f =
            { shielding = None
            , counterMissiles = Just <| Values [ 1, 1 ]
            , pointDefenses = Just <| Values [ 1, 1 ]
            , armor = Just 1
            }
        , a =
            { shielding = Sidewall <| Values [ 1 ]
            , counterMissiles = Just <| Values [ 1, 1 ]
            , pointDefenses = Just <| Values [ 1, 1 ]
            , armor = Just 1
            }
        , p =
            { shielding = Sidewall <| Values [ 2, 1 ]
            , counterMissiles = Just <| Values [ 1, 1 ]
            , pointDefenses = Just <| Values [ 1, 1 ]
            , armor = Just 1
            }
        , s =
            { shielding = Sidewall <| Values [ 2, 1 ]
            , counterMissiles = Just <| Values [ 1, 1 ]
            , pointDefenses = Just <| Values [ 1, 1 ]
            , armor = Just 1
            }
        , t =
            { shielding = Wedge
            , counterMissiles = Nothing
            , pointDefenses = Nothing
            , armor = Just 1
            }
        , b =
            { shielding = Wedge
            , counterMissiles = Nothing
            , pointDefenses = Nothing
            , armor = Just 1
            }
        }
    }
