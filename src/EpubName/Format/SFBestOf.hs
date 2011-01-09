-- Copyright: 2008-2011 Dino Morelli
-- License: BSD3 (see LICENSE)
-- Author: Dino Morelli <dino@ui3.info>

{-# LANGUAGE FlexibleContexts #-}

module EpubName.Format.SFBestOf
   ( fmtSFBestOf )
   where

import Codec.Epub.Opf.Package.Metadata
import Control.Monad.Error

import EpubName.Format.Util ( filterCommon, format )


fmtSFBestOf :: (MonadError String m) => Metadata -> m (String, String)
fmtSFBestOf = format "SFBestOf"
   "Rich Horton.*" (const "")
   "(.*)" title


title :: String -> [String] -> String
title _ (name:_) = filterCommon name
title _ _ = undefined