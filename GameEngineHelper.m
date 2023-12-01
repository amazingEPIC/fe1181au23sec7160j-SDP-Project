% GameEngineHelper
% A single class that contains the background, foreground, 

classdef GameEngineHelper < handle
    properties
        scene;
        screenRows;
        screenColumns;
        background;
        foreground;
    end
    methods
        function obj = GameEngineHelper(spritesheetFile, tileSize, screenColumns, screenRows)
            obj.scene = SimpleGameEngineModified(spritesheetFile, tileSize, tileSize, 2, [230,230,230], true);
            obj.screenRows = screenRows;
            obj.screenColumns = screenColumns;
            obj.background = ones(screenRows, screenColumns);
            obj.foreground = ones(screenRows, screenColumns);
        end
        function geh_draw(obj)
            drawScene(obj.scene, obj.background, obj.foreground);
        end
        function geh_setTiles(obj, type, screenCol, screenRow, spritesheetX, spritesheetY)
            % type: background or foreground
            if (type == "background") 
                obj.background(screenRow, screenCol) = getSpriteFromXY(obj.scene, spritesheetX, spritesheetY);
            else
                obj.foreground(screenRow, screenCol) = getSpriteFromXY(obj.scene, spritesheetX, spritesheetY);
            end
        end
        function key = geh_getKeyboardInput(obj)
            key = convertCharsToStrings(getKeyboardInput(obj.scene));
        end
        function [row, col, button] = geh_getMouseInput(obj)
            [row, col, button] = getMouseInput(obj.scene);
        end
        function returnKey = geh_waitUntilKeyPressed(obj, key)
            pressedKey = "";
            while ~(ismember(pressedKey, key))
                pressedKey = geh_getKeyboardInput(obj);
            end
            returnKey = pressedKey;
        end
    end
end

% PRIVATE METHODS

function spriteNumber = getSpriteFromXY(scene, x, y)
% spriteNumber helper function by Eli Lambrych
% Gets the id of sprite from x & y values from spritesheet
% obj: The simpleGameEngineModified object
% x: the x value(s) of the sprite on the spritesheet
% y: the y value(s) of the sprite on the spritesheet
    spriteNumber = zeros(numel(y), numel(x));
    for i=1:numel(y)
        spriteNumber(i, :) = scene.sprite_col_max * (y(i) - 1) + x;
    end
end