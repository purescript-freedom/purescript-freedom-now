module Main where

import Prelude

import Data.JSDate (JSDate, now, toString)
import Data.Time.Duration (Milliseconds(..))
import Effect (Effect)
import Freedom as Freedom
import Freedom.Markup as H
import Freedom.Now (currentTime)
import Freedom.Subscription (Subscription)
import Freedom.TransformF.Simple (VQueryF, transformF, reduce)
import Freedom.VNode (VNode)

type State = JSDate

type Sub = Subscription VQueryF State

type Html = VNode VQueryF State

main :: Effect Unit
main = do
  jsdate <- now
  Freedom.run
    { selector: "#app"
    , initialState: jsdate
    , subscriptions: [ currentTime' ]
    , transformF
    , view
    }

currentTime' :: Sub
currentTime' = currentTime (Milliseconds 3000.0) \jsdate -> do
  reduce $ const jsdate

view :: State -> Html
view jsdate =
  H.el $ H.div # H.kids
    [ H.el $ H.h1 # H.kids [ H.t "Now Demo" ]
    , H.el $ H.p # H.kids [ H.t $ toString jsdate ]
    ]
