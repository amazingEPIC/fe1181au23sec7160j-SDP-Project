function hangman 
    clear
    clc

    test_scene = simpleGameEngineModified('spritesheet.png', 16, 16, 2, [230,230,230], true);
    background = [getSpriteFromXY(test_scene, 3:22, 15:30)];
    size(background)
    foreground = ones(16,20);

    % Draw initial title screen
    foreground = ones(16,20);

    foreground(13:14, :) = [getSpriteFromXY(test_scene, 3:22, 37:38)];
    drawScene(test_scene, background, foreground);
    getKeyboardInput(test_scene);
    pause(0.2);

    foreground(12:15, :) = ones(4,20); % clears bottom bar
    foreground(12, :) = [getSpriteFromXY(test_s cene, 3:22, 33)];
    foreground(15, :) = [getSpriteFromXY(test_scene, 3:22, 34)];
    drawScene(test_scene, background, foreground);

    getKeyboardInput(test_scene);
    pause(0.2);

    % USEFUL FUNCTIONS I COULD MAKE:
    % - getLetterFromUser
    % - generateNewWord
    % - drawSmallCharacter
    % - drawLargeCharacter
    % - drawUnknownWord
    % - clearBottomBar
    
    % USEFUL VARIABLES
    % - unknownWord
    % - guessedLetters (character array?)
    % - guessesUsed
    % - totalNumberOfGuesses

    % Confirmation screen

    foreground(12:15, :) = ones(4,20); % clears bottom bar
    foreground(12, :) = [getSpriteFromXY(test_scene, 3:22, 35)];
    foreground(15, :) = [getSpriteFromXY(test_scene, 3:22, 36)];
    drawScene(test_scene, background, foreground);

    confirmationInput = '';

    while (~isequal(confirmationInput, 'return') && ~isequal(confirmationInput, 'escape'))
        confirmationInput = getKeyboardInput(test_scene)
        pause(0.2);
    
        if (isequal(confirmationInput, 'return'))
    
        elseif (isequal(confirmationInput, 'escape'))
    
        end

        fprintf("AAA");

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