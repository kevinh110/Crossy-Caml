(** The type for the movement direction of a block *)
type dir =  
  | Down 
  | Left 
  | Right 
  | No

(** A tuple representing the x, y coordinates of an actor *)
type pos = int * int

(** The effect of an item block.*)
type effect = 
  | Life of int
  | Adder of int
  | Multiplier of int
  | Phaser of int
  | Slower of int 
  | Clear of int 
  | Speeder of int 
  | Subtractor of int
  | Mystery of int
  | Nothing

(** The type of obstacle block. *)
type block_type = 
  | SmallB
  | MediumB
  | LargeB
  | GoodB of effect

(** [get_effect b] is the effect associated with block [b] *)
val get_effect : block_type -> effect

(** [get_time b] is the time associated with block [b] *)
val get_time : block_type -> int

(** [is_good b] is whether or not block [b] is a GoodB *)
val is_good : block_type -> bool

val string_of_eff : effect -> string