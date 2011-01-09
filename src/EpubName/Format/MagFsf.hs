-- Copyright: 2008-2011 Dino Morelli
-- License: BSD3 (see LICENSE)
-- Author: Dino Morelli <dino@ui3.info>

{-# LANGUAGE FlexibleContexts #-}

module EpubName.Format.MagFsf
   ( fmtMagFsf )
   where

import Codec.Epub.Opf.Package.Metadata
import Control.Monad.Error
import Text.Printf

import EpubName.Format.Util ( format, monthNum )


fmtMagFsf :: (MonadError String m) => Metadata -> m (String, String)
fmtMagFsf = format "MagFsf"
   "Spilogale.*" (const "")
   ".* ([^ ]+) ([0-9]{4})$" title


title :: String -> [String] -> String
title _ (month:year:_) =
   printf "FantasyScienceFiction%s-%s" year (monthNum month)
title _ _ = undefined