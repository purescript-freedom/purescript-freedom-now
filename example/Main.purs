module Main where

import Prelude

import Data.DateTime (DateTime)
import Data.JSDate (fromDateTime, toString)
import Data.Time.Duration (Milliseconds(..))
import Effect (Effect)
import Effect.Now (nowDateTime)
import Freedom as Freedom
import Freedom.Markup as H
import Freedom.Now (currentTime)
import Freedom.Subscription (Subscription)
import Freedom.TransformF.Simple (VQueryF, transformF, reduce)
import Freedom.VNode (VNode)

type State = DateTime

type Sub = Subscription VQueryF State

type Html = VNode VQueryF State

main :: Effect Unit
main = do
  dateTime <- nowDateTime
  Freedom.run
    { selector: "#app"
    , initialState: dateTime
    , subscriptions: [ currentTime' ]
    , transformF
    , view
    }

currentTime' :: Sub
currentTime' = currentTime (Milliseconds 3000.0) \dateTime -> do
  reduce $ const dateTime

view :: State -> Html
view dateTime =
  H.el $ H.div # H.kids
    [ H.el $ H.h1 # H.kids [ H.t "Now Demo" ]
    , H.el $ H.p # H.kids [ H.t $ toString $ fromDateTime dateTime ]
    ]
