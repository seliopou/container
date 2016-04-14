type player_id = int [@@deriving show]

module Color = struct
  type t =
    | Black
    | White
    | Orange
    | Green
    | Purple
    [@@deriving show]

    type c = t

    module Map = Map.Make(struct
      type t = c
      let compare = Pervasives.compare
    end)

    module Set = Set.Make(struct
      type t = c
      let compare = Pervasives.compare
    end)

    (* XXX(seliopou): make [show] and [pp] functions for Map and set, so that
     * types with that include them can use [@@deriving show].
     * *)

end

module UInt = struct
  type t = int [@@deriving show]
end

module Block = struct
  type t =
    { color : Color.t
    ; production_cost : UInt.t option
    ; purchase_cost : UInt.t option
    ; auction_cost : UInt.t option
    } [@@deriving show]
end

module Ship = struct
  type cargo =
    { slot1 : Block.t option
    ; slot2 : Block.t option
    ; slot3 : Block.t option
    ; slot4 : Block.t option
    ; slot5 : Block.t option
    } [@@deriving show]

  type state =
    | Port of player_id
    | Ocean
    | Island
    [@@deriving show]

  type t = cargo * state
    [@@deriving show]
end

module Player = struct
  type t =
    { player_id   : player_id
    ; money       : UInt.t
    ; ship        : Ship.t
    ; factories   : Color.Set.t
    ; containers  : int Color.Map.t
    }
end

type color = Color.t [@@deriving show]
type player = Player.t

type t
