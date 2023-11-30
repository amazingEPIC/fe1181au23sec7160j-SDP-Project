function [selectedWord] = generateWord(wordFile)

rndIndex = randi(length(wordFile));

selectedWord = wordFile(rndIndex);

% For the input parameter, ex: wordFile = readmatrix("wordList.txt", "OutputType", "char");
% then pass in wordFile 
end