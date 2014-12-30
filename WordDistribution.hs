import qualified Data.Map.Lazy as Dict
import Data.Char (isLetter, isSpace, toLower)
import Data.List (sortBy)

compareWordCounts (a, countA) (b, countB)
    | countA == countB = EQ
    | countB > countA = GT
    | countB < countA = LT

countDistributions s =
    let lowerCaseWords = words $ filter (\e -> isLetter e || isSpace e || e == '-') $ map toLower s
        lowerCaseWordsCountTuples = map (\v -> (v, 1)) lowerCaseWords
        wordCounts = Dict.toList $ Dict.fromListWith (+) lowerCaseWordsCountTuples
    in sortBy compareWordCounts wordCounts