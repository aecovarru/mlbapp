import React from 'react'
import DatePicker from '../containers/FilterableDatePicker'
import DropDown from '../containers/VisibleDropDown'
import WeatherRange from '../containers/FilterableWeatherRange'

const getWeathers = (game) => {
  var weather = game.weather;
  var temp, dew, pressure, humidity, dir, speed, density, precip;
  if (weather != null){
    temp = weather.temp;
    dew = weather.dew;
    pressure = weather.pressure;
    humidity = weather.humidity;
    dir = weather.wind_dir;
    speed = weather.wind_speed;
    density = weather.air_density;
    precip = weather.precip;
  }
  return { temp, dew, pressure, humidity, dir, speed, density, precip }
}

const GameHead = ({ away_teams, home_teams }) => (
  <thead>
    <tr>
      <th width="300">Date Range{' '}<DatePicker /></th>
      <th><DropDown id='Away Team' teams={away_teams} /></th>
      <th><DropDown id='Home Team' teams={home_teams} /></th>
      <th><WeatherRange id='Temp' /></th>
      <th><WeatherRange id='Dew' /></th>
      <th><WeatherRange id='Pressure' /></th>
      <th><WeatherRange id='Humidity' /></th>
      <th>Wind Dir</th>
      <th>Wind Speed</th>
      <th>Air Density</th>
      <th>Precip</th>
    </tr>
	</thead>
)

const GameBody = ({ games }) => {
  var rows = games.map(game => {
      var weather = getWeathers(game)
      return <tr>
      <td><a href={game.show_link}>{game.date}</a></td><td>{game.away_team}</td><td>{game.home_team}</td><td>{weather.temp}</td>
      <td>{weather.dew}</td><td>{weather.pressure}</td><td>{weather.humidity}</td><td>{weather.dir}</td>
      <td>{weather.speed}</td><td>{weather.density}</td><td>{weather.precip}</td>
      </tr>
    }
  )
  return (
    <tbody>
      {rows}
    </tbody>
  )
}

const GameTable = ({ games, away_teams, home_teams }) => (
  <table className="table table-bordered">
    <GameHead away_teams={away_teams} home_teams={home_teams} />
    <GameBody games={games} />
  </table>
)

export default GameTable