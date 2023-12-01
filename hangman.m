function hangman 
    clear
    clc
    
    % Converts character array to cell array, and from cell array to
    % string array
    ALPHABET_KEYS = convertCharsToStrings(num2cell('a':'z'));

    % Set up game

    % Create instance of GameEngineHelper
    game = GameEngineHelper("spritesheet.png", 16, 20, 16);
    
    % Set up background
    geh_setTiles(game, 'background', 1:20, 1:16, 3:22, 15:30);

    % Draw initial title screen
    geh_setTiles(game, 'foreground', 1:20, 13:14, 3:22, 37:38);
    
    geh_draw(game);

    geh_waitUntilKeyPressed(game, "return");

    while (true)
        unknownWord = generateWord();
        usedLetters = string.empty;
        foundLetters = string.empty; 
        incorrectLetters = string.empty;
        numberOfIncorrectGuesses = 0;
        allowedIncorrectGuesses = 7;
        playerWon = false;

        geh_setTiles(game, 'foreground', 1:20, 1:16, 1, 1); % Clear foreground

        while (numberOfIncorrectGuesses < allowedIncorrectGuesses && ~playerWon)
            charactersAllowedToGuess = setdiff(ALPHABET_KEYS, usedLetters);

            % Show guess to player, ask for input
            geh_setTiles(game, 'foreground', 1:20, 12:15, 1, 1); % clear bottom box
            geh_setTiles(game, 'foreground', 1:20, 12, 3:22, 33); % Current guess:
            writeCenteredWord(game, censorWord(unknownWord, foundLetters), 13);
            geh_setTiles(game, 'foreground', 1:20, 15, 3:22, 34); % Please type a letter on your keyboard.
            geh_draw(game);
        
            guessedLetter = geh_waitUntilKeyPressed(game, charactersAllowedToGuess);

            % Confirm that player entered the one that they meant to enter
            geh_setTiles(game, 'foreground', 1:20, 12:15, 1, 1); % clear bottom box
            geh_setTiles(game, 'foreground', 1:20, 12, 3:22, 35); % You entered this letter:
            writeCharacter(game, convertStringsToChars(guessedLetter), 10, 13, "large", false); % Print letter player guessed
            geh_setTiles(game, 'foreground', 1:20, 15, 3:22, 36); % Press ENTER to confirm or BACKSPACE to cancel.
            geh_draw(game);
            playerGuessConfirmationInput = geh_waitUntilKeyPressed(game, ["return", "backspace"]);

            if (playerGuessConfirmationInput == "return")
                % Check if letter is CORRECT!
                if (strfind(unknownWord, guessedLetter))
                    usedLetters(1, end + 1) = guessedLetter;
                    foundLetters(1, end + 1) = guessedLetter;
                else
                    numberOfIncorrectGuesses = numberOfIncorrectGuesses + 1;
                    usedLetters(1, end + 1) = guessedLetter;
                    incorrectLetters(1, end + 1) = guessedLetter;
                    % Update hung man
                    geh_setTiles(game, "foreground", 3:4, 5:8, (3 + numberOfIncorrectGuesses * 2):(4 + numberOfIncorrectGuesses * 2), 7:10)
                    % Add guessed letter to "used" area
                    if (numberOfIncorrectGuesses <= 4)
                        writeCharacter(game, convertStringsToChars(guessedLetter), numberOfIncorrectGuesses*2 + 9, 5, "large", true);
                    else
                        writeCharacter(game, convertStringsToChars(guessedLetter), (numberOfIncorrectGuesses - 4)*2 + 10, 7, "large", true);
                    end
                end
            end

            if (censorWord(unknownWord, foundLetters) == unknownWord)
                playerWon = true;
            end

            % If not, continue anyways
        end

        % Game over or you won
        geh_setTiles(game, 'foreground', 1:20, 12:15, 1, 1); % clear bottom box

        if (playerWon) % if won
            geh_setTiles(game, 'foreground', 1:20, 12, 3:22, 39); 
        else
            geh_setTiles(game, 'foreground', 1:20, 12, 3:22, 31); 
        end
        writeCenteredWord(game, unknownWord, 13);

        geh_setTiles(game, 'foreground', 1:20, 15, 3:22, 32); 

        geh_draw(game);
    
        if (geh_waitUntilKeyPressed(game, ["return", "escape"]) == "escape" )
            close(game.scene.my_figure)
        end

    end

end

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

function writeCenteredWord(obj, word, row)
    word = convertStringsToChars(word);
    printableLength = min(strlength(word), 9);
    for i=1:printableLength
        writeCharacter(obj, word(i), 10 - printableLength + i*2 - 1, row, "large", false);
    end
end

function censored = censorWord(originalWord, allowedLetters)
    generatedRegex = join(['[^', allowedLetters, ']' ], ''); % selects all characters that aren't in allowedLetters
    censored = regexprep(originalWord, generatedRegex, '_');
end