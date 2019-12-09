type obj = {
  mutable x_pos: int;
  mutable y_pos: int;
  velocity: Actor.dir * int;
  id: int;
  to_kill: bool;
  mutable score: int;
  height: int;
  width: int;
  mutable effects: Actor.effect list ; 
}

type collidable = 
  | Player of obj 
  | Block of Actor.block_type * obj

(** [score_incr p s] increments obj [p]'s score field by [s] *)
val score_incr : obj -> int -> unit

(** [get_block c] is the block_type of collidable [c] *)
val get_block : collidable -> Actor.block_type 

(** [check_collision c1 c2] is true if collidable [c2] has overlapped pixels 
    with collidable [c1], false otherwise.
    Requires: 
    - [c1] is a collidable of Player
    - [c2] is a collidable of Block
      Raises: failwith "Failed requirement" *)
val check_collision : collidable -> collidable -> Actor.block_type option

(** [check_on_screen c xbound] is true if any part of collidable [c] is within 
    the window. The window is defined as a rectangle of (0,0) to (xbound,_). *)
val check_on_screen : collidable -> int -> bool

(** [extract_obj c] extracts the Object from collidable [c] *)
val extract_obj : collidable -> obj

(** [update_effects effs] Decrements counters in [effs] and removes effects with 
    timer zero *)
val update_effects : Actor.effect list -> Actor.effect list 

(** [has_phaser player] is true iff the collidable's effect list contains a 
    phaser *)
val has_phaser : obj -> bool  

(** [has_slower player] is true iff the collidable's effect list contains a 
    slower *)
val has_slower : obj -> bool 

(** [has_mult player] is true iff the collidable's effect list contains a 
    multiplier *)
val has_mult : obj -> bool 

(** [has_adder player] is true iff the collidable's effect list contains an 
    adder *)
val has_adder : obj -> bool

(** [has_clear player] is true iff the collidable's effect list contains a 
    clear *)
val has_clear : obj -> bool

(** [has_speeder player] is true iff the collidable's effect list contains a 
    speeder *)
val has_speeder : obj -> bool

(** [has_subtracter player] is true iff the collidable's effect list contains 
    a subtracter *)
val has_subtracter : obj -> bool

(** [has_life player] is true iff the collidable's effect list contains a life*)
val has_life : obj -> bool

(** [effect_time_left effs e] is the maximum time of all effects of type 
    specified *)
val effect_time_left : Actor.effect list -> Actor.effect -> int 

(** [generate_seed ()] is a unit. It initializes the random module with a seed
    that's dependent on the current time.  *)
val generate_seed : unit -> unit 