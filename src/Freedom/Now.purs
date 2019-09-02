module Freedom.Now where

import Prelude

import Control.Monad.Free.Trans (FreeT)
import Data.DateTime (DateTime)
import Data.Int (ceil)
import Data.Time.Duration (Milliseconds(..))
import Effect.Aff (Aff, launchAff_)
import Effect.Now (nowDateTime)
import Effect.Timer (setInterval)
import Freedom.Subscription (Subscription, subscription)

currentTime
  :: forall f state
   . Functor (f state)
  => Milliseconds
  -> (DateTime -> FreeT (f state) Aff Unit)
  -> Subscription f state
currentTime (Milliseconds n) onUpdate =
  subscription \transform -> do
    void
      $ setInterval (ceil n)
      $ nowDateTime >>= onUpdate >>> transform >>> launchAff_
