function writeCenteredWord(obj, word, row)
    word = convertStringsToChars(word);
    printableLength = min(strlength(word), 9);
    for i=1:printableLength
        writeCharacter(obj, word(i), 10 - printableLength + i*2 - 1, row, "large", false);
    end
end