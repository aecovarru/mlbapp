import React from 'react'
import { Provider } from 'react-redux'
import { createStore } from 'redux'
import App from '../components/App'
import gameApp from '../reducers/index'

const weatherMaxMin = (games) => {

  // Get the global maxes for each type of weather
	var weathers = games.map(function(game){return game.weather}).filter(function(weather){return weather != null && weather.temp != 0 && weather.dew != 0})
  var temps = weathers.map(function(weather){return weather.temp})
  var maxTemp = Math.max.apply(Math, temps)
  var minTemp = Math.min.apply(Math, temps)
  var dews = weathers.map(function(weather){return weather.dew})
  var maxDew = Math.max.apply(Math, dews)
  var minDew = Math.min.apply(Math, dews)
  var pressures = weathers.map(function(weather){return weather.pressure})
  var maxPressure = Math.max.apply(Math, pressures)
  var minPressure = Math.min.apply(Math, pressures)
  var humidities = weathers.map(function(weather){return weather.humidity})
  var maxHumidity = Math.max.apply(Math, humidities)
  var minHumidity = Math.min.apply(Math, humidities)

	return {
		temp: { gmin: minTemp, min: minTemp, gmax: maxTemp, max: maxTemp },
		dew: { gmin: minDew, min: minDew, gmax: maxDew, max: maxDew },
    pressure: { gmin: minPressure, min: minPressure, gmax: maxPressure, max: maxPressure },
    humidity: { gmin: minHumidity, min: minHumidity, gmax: maxHumidity, max: maxHumidity }
	}
}

export default (props) => {

  var teams = props.teams.map((team) => team.name)
  teams.unshift("All")

  var weatherObject = weatherMaxMin(props.games)

  let store = createStore(gameApp, { 
    teams: teams, games: props.games, away_team: "All", home_team: "All",
  	date: null, weather: weatherObject 
  } )

  return (
    <Provider store={store}>
	  	<App />
		</Provider>
  )

};