import { combineReducers } from 'redux'
import away_team from './away_team'
import home_team from './home_team'
import date from './date'
import weather from './weather'

const gameApp = combineReducers({
	teams: (state = []) => state,
	games: (state = []) => state,
	weather,
	away_team,
	home_team,
	date
})

export default gameApp
