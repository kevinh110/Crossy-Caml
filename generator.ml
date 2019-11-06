open Actor
open Object

(** [generate_block coord grid_size typ] is a collidable object with position 
    [coord], type [typ], height and width = 2 * [grid_size]. *)
    (* doesn't have unique id, no score, height and width are all the same *)
let generate_block coord grid_size typ : collidable = 
  match coord with
  | (x, y) -> Block (typ, {
      position = (x, y);
      velocity = (No, 0);
      id = 0;
      to_kill = false;
      score = 0;
      height = 2 * grid_size;
      width = 2 * grid_size; 
    })

(** [gen_helper coord x_bound y_bound cur_pass num_pass grid_size list] is a 
    collidable list that has generated collidable objects filling up all the 
    grid spaces from x = 0 to x = [x_bound].*)
    (* Doesn't ensure that list has num_pass amount of pass_blocks, doesn't 
    update curr_y *)
let rec gen_helper coord x_bound cur_pass num_pass grid_size list 
  : collidable list =
  match coord with
  | (x, y) -> 
    let blocks_left = (x_bound - x) / (2 * grid_size) in 
    let pass_left = num_pass - cur_pass in
    if (blocks_left <= 0) then list 
    else let rand = Random.int (x_bound / (2 * grid_size)) in 
      if (pass_left = blocks_left || (rand < num_pass && pass_left > 0)) 
      then let pass_block = generate_block coord grid_size GoodB in
        gen_helper (x + grid_size*2, y) x_bound (cur_pass + 1) num_pass 
                   grid_size (pass_block :: list)
      else let new_block = generate_block coord grid_size LargeB in
      gen_helper (x + grid_size*2, y) x_bound cur_pass num_pass grid_size 
                 (new_block :: list) 

let generate (x_bound:int) (y_bound:int) (num_pass:int) (grid_size:int) 
  : collidable list = 
  let start_coord = (0, y_bound) in
  let first_row = gen_helper start_coord x_bound 0 num_pass grid_size [] in
  let second_coord = (0, y_bound + 2 * grid_size) in
  let num_blocks = x_bound / (2 * grid_size) in
  gen_helper second_coord x_bound 0 num_blocks grid_size first_row