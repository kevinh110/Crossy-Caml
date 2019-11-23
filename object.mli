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

val get_block : collidable -> Actor.block_type 

(** [check_collision c1 c2] is true if collidable [c2] has overlapped pixels 
    with collidable [c1], false otherwise.
    Requires: 
    - [c1] is a collidable of Player
    - [c2] is a collidable of Block
      Raises: failwith "Failed requirement"
*)
val check_collision : collidable -> collidable -> Actor.block_type option

(** [check_on_screen c xbound] is true if any part of collidable [c] is within the 
    window. The window is defined as a rectangle of (0,0) to (xbound,_).   *)
val check_on_screen : collidable -> int -> bool

(**[extract_obj c] extracts the Object from collidable [c] *)
val extract_obj : collidable -> obj
