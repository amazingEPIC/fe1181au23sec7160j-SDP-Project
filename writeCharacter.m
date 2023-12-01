function writeCharacter(obj, character, col, row, charSize, isAlternateColor)
    allowedChars = ['a':'z', '_', ' '];
    charSpritesheetRow = ones(1, 28);
    charSpritesheetCol = ones(1, 28);

    if (charSize == "large")
        for i=1:19
            charSpritesheetRow(i) = 1;
            charSpritesheetCol(i) = 1+i*2;
        end
        for i=20:27
            charSpritesheetRow(i) = 3;
            charSpritesheetCol(i) = (i - 19)*2 - 1;
        end
        if (isAlternateColor)
            charSpritesheetRow = charSpritesheetRow + 10;
        end
    else
        for i=1:27
            charSpritesheetRow(i) = 5;
            charSpritesheetCol(i) = 13+i;
        end
    end

    sa = 0;
    if (charSize == "large")
        sa = 1;
    end

    if (strlength(character) == 1 && ismember(character, allowedChars))
        charIdx = strfind(allowedChars, character);
        geh_setTiles(obj, "foreground", col:(col+sa), row:(row+sa), charSpritesheetCol(charIdx):(charSpritesheetCol(charIdx)+sa), charSpritesheetRow(charIdx):(charSpritesheetRow(charIdx)+sa));
    else 
        error("Must be a single lowercase letter or underscore.")
    end
end