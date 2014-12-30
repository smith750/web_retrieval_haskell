-- much stealing from http://adit.io/posts/2012-03-10-building_a_concurrent_web_scraper_with_haskell.html

import Network.HTTP
import Network.URI
import Control.Concurrent.ParallelIO
import Data.Char
import Control.Monad.Trans
import Control.Monad.Maybe

-- helper function for getting page content
openUrl :: String -> MaybeT IO String
openUrl url = case parseURI url of
    Nothing -> fail ""
    Just u  -> liftIO (getResponseBody =<< simpleHTTP (mkRequest GET u))
	
--urls = ["http://gutenberg.pglaf.org/4/7/6/5/47651/47651-0.txt","http://gutenberg.pglaf.org/1/4/0/1400/1400.txt"]

wordCount :: String -> Int
wordCount doc = length $ words $ map toLower doc
	
--main =  (runMaybeT $ openUrl "http://gutenberg.pglaf.org/1/4/0/1400/1400.txt") >>= \doc ->
--		(liftM wordCount) >>= \wc ->
--		putStrLn wordCount >>
--		return ()