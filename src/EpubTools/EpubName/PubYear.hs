-- Copyright: 2011, 2012 Dino Morelli
-- License: BSD3 (see LICENSE)
-- Author: Dino Morelli <dino@ui3.info>

module EpubTools.EpubName.PubYear
   ( extractYear
   , getPubYear
   )
   where

import Codec.Epub.Opf.Package
import Control.Monad
import Text.Regex

import EpubTools.EpubName.Opts
import EpubTools.EpubName.Util


{- Look for publication date, return "" if none found
-}
getPubYear :: EN String
getPubYear = do
   yearHandling <- asks $ optPubYear . gOpts
   md <- asks gMetadata

   case yearHandling of
      Publication -> getPubYear' md pubAttrs
      AnyDate -> getPubYear' md $ pubAttrs ++ [getFirstDate]
      NoDate -> return ""

   where
      getPubYear' md = return . maybe "" ('_' :) . foldr mplus Nothing .
         map (\f -> f (metaDates md))

      pubAttrs =
         [ getDateWithAttr "publication"
         , getDateWithAttr "original-publication"
         ]


getDateWithAttr :: String -> [MetaDate] -> Maybe String
getDateWithAttr attrVal mds = foldr mplus Nothing $ map getPublication' mds
   where
      getPublication' (MetaDate (Just av) d)
         | av == attrVal = extractYear d
      getPublication' _  = Nothing


getFirstDate :: [MetaDate] -> Maybe String
getFirstDate ((MetaDate _ d) : _) = extractYear d
getFirstDate _                    = Nothing


extractYear :: String -> Maybe String
extractYear s = case matchRegex (mkRegex "(^| )([0-9]{4})") s of
   Just (_ : y : []) -> Just y
   _                 -> Nothing
