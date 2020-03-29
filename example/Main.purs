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
import Freedom.UI (Subscription, VNode)

type State = DateTime

main :: Effect Unit
main = do
  dateTime <- nowDateTime
  Freedom.run
    { selector: "#app"
    , initialState: dateTime
    , subscriptions: [ currentTime' ]
    , view
    }

currentTime' :: Subscription State
currentTime' =
  currentTime (Milliseconds 3000.0) \dateTime query ->
    query.reduce $ const dateTime

view :: State -> VNode State
view dateTime =
  H.div # H.kids
    [ H.h1 # H.kids [ H.t "Now Demo" ]
    , H.p # H.kids [ H.t $ toString $ fromDateTime dateTime ]
    ]
