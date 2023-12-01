function censored = censorWord(originalWord, allowedLetters)
    generatedRegex = join(['[^', allowedLetters, ']' ], ''); % selects all characters that aren't in allowedLetters
    censored = regexprep(originalWord, generatedRegex, '_');
end