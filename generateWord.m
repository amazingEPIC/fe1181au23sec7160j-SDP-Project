function selectedWord = generateWord()
    importedWords = readmatrix("wordList.txt", "OutputType", "char");

    rndIndex = randi(length(importedWords));

    selectedWord = importedWords{rndIndex};
end