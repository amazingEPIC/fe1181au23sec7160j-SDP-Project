function hangman 
    clear
    clc

    test_scene = simpleGameEngineModified('spritesheet.png', 32, 32, 2, [230,230,230], true);
    background = [getSpriteFromXY(test_scene, 2:11, 8:15)];
    foreground = ones(8,10);

    % Draw title screen

    % Draw 

    while(true)
    
        % draw no stick figure
        foreground = ones(8,10);
        foreground(3:4,2) = getSpriteFromXY(test_scene, 1, 1);
        drawScene(test_scene, background, foreground);
        title("No stick figure (press space to go to next screen)");

        pause(0.2);
        getKeyboardInput(test_scene);
    
        % draw partial stick figure
        foreground = ones(8,10);
        foreground(3:4,2) = getSpriteFromXY(test_scene, 5, 4:5);
        foreground(3,6:8) = getSpriteFromXY(test_scene, 2:4, 1);
        drawScene(test_scene, background, foreground);
        title("Partial stick figure");

        pause(0.2);
        getKeyboardInput(test_scene);

        % draw full stick figure
        foreground = ones(8,10);
        foreground(3:4,2) = getSpriteFromXY(test_scene, 9, 4:5);
        foreground(3,6:9) = getSpriteFromXY(test_scene, 2:5, 1);
        foreground(4,7:8) = getSpriteFromXY(test_scene, 6:7, 1);
        drawScene(test_scene, background, foreground);
        title("Full stick figure");

        pause(0.2);
        getKeyboardInput(test_scene);
    
    end
end


function spriteNumber = getSpriteFromXY(obj, x, y)
% spriteNumber helper function by Eli Lambrych
% Gets the id of sprite from x & y values from spritesheet
% obj: The simpleGameEngineModified object
% x: the x value(s) of the sprite on the spritesheet
% y: the y value(s) of the sprite on the spritesheet
    spriteNumber = zeros(numel(y), numel(x));
    for i=1:numel(y)
        spriteNumber(i, :) = obj.sprite_col_max * (y(i) - 1) + x;
    end
end