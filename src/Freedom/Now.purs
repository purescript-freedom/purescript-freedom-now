module Freedom.Now where

import Prelude

import Control.Monad.Free.Trans (FreeT)
import Data.Int (ceil)
import Data.JSDate (JSDate, now)
import Data.Time.Duration (Milliseconds(..))
import Effect.Aff (Aff, launchAff_)
import Effect.Timer (setInterval)
import Freedom.Subscription (Subscription, subscription)

currentTime
  :: forall f state
   . Functor (f state)
  => Milliseconds
  -> (JSDate -> FreeT (f state) Aff Unit)
  -> Subscription f state
currentTime (Milliseconds n) onUpdate =
  subscription \transform -> do
    void
      $ setInterval (ceil n)
      $ now >>= onUpdate >>> transform >>> launchAff_
