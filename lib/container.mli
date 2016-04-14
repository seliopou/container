open Result

type player_id [@@deriving show]

module Color : sig
  type t =
    | Black
    | White
    | Orange
    | Green
    | Purple
    [@@deriving show]

  module Map : Map.S
    with type key = t

  module Set : Set.S
    with type elt = t
end

module UInt : sig
  type t
    [@@deriving show]

  val of_int : int -> t option

  val add : t -> t -> t
  val sub : t -> t -> t option
  val sub_exn : t -> t -> t
end

module Block : sig
  type t =
    { color : Color.t
    ; production_cost : UInt.t option
    ; purchase_cost : UInt.t option
    ; auction_cost : UInt.t option
    } [@@deriving show]
end

module Ship : sig
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

module Player : sig
  type t =
    { player_id   : player_id
    ; money       : UInt.t
    ; ship        : Ship.t
    ; factories   : Color.Set.t
    ; containers  : int Color.Map.t
    } [@@deriving show]

  val produce :
    ?one:int Color.Map.t ->
    ?two:int Color.Map.t ->
    ?three:int Color.Map.t ->
    ?four:int Color.Map.t ->
    t -> t

  val redistribute_production :
    ?one:int Color.Map.t ->
    ?two:int Color.Map.t ->
    ?three:int Color.Map.t ->
    ?four:int Color.Map.t ->
    t -> t

  val redistribute_storage :
    ?one:int Color.Map.t ->
    ?two:int Color.Map.t ->
    ?three:int Color.Map.t ->
    ?four:int Color.Map.t ->
    ?five:int Color.Map.t ->
    t -> t

  val add_factory : Color.t -> t -> (t, string) result
  val add_warehouse : t -> (t, string) result
  val move_ship : Ship.state -> t -> (t, string) result
end

type color = Color.t [@@deriving show]
type player = Player.t [@@deriving show]

type t
  [@@deriving show]

val create :
  ?player1:color ->
  ?player2:color ->
  ?player3:color ->
  ?player4:color ->
  ?player5:color ->
  unit -> t
