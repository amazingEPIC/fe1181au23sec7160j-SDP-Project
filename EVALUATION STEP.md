# EVALUATION STEP

There were a couple difficulties that I ran into while working on this
assignment.

One challenge I ran into was the fact that the Simple Game Engine expects 
there to be a 1px margin between each tile in a spritesheet, (which was 
completely undocumented). Because I want to take advantage of spanning 
images across multiple sprites, and splitting each tile into 32x32px
segments with a 1px margin between them would be extremely tedious, I had
to modify the Simple Game Enigne to have no margin between each tile on the
spritesheet.

Additionally, because doing the math manually to find the ID of each
sprite is also extremely tedious, I wrote a function to find the sprite
ID from x and y values, which required the Simple Game Engine object to
have public sprite_row_max and sprite_col_max properties, which are
obtained from the spritesheet's height and width respectively.

I don't believe I have any questions for my professor/group at the moment,
since my group is pretty much on the same page for what we're doing.

Some of our plans might change when it comes to how the UI is laid out, and
we might add on some multiplayer functionality to our game if we have 
enough leftover time. 