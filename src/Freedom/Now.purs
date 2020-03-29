module Freedom.Now where

import Prelude

import Data.DateTime (DateTime)
import Data.Int (ceil)
import Data.Time.Duration (Milliseconds(..))
import Effect (Effect)
import Effect.Now (nowDateTime)
import Effect.Timer (setInterval)
import Freedom.Store (Query)
import Freedom.UI (Subscription)

currentTime
  :: forall state
   . Milliseconds
  -> (DateTime -> Query state -> Effect Unit)
  -> Subscription state
currentTime (Milliseconds n) onUpdate query =
  void $ setInterval (ceil n) $ nowDateTime >>= flip onUpdate query
