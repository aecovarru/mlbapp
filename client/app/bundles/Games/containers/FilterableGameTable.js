import { connect } from 'react-redux'
import { toggleTeam } from '../actions'
import GameTable from '../components/GameTable'

const getGames = (state) => {
  var games = state.games
  if (state.away_team != "All"){
    games = games.filter(game => game.away_team == state.away_team)
  }
  if (state.home_team != "All"){
    games = games.filter(game => game.home_team == state.home_team)
  }
  if (state.date != null){
    var date = state.date
    games = games.filter(game => game.year == date.year() && date.month()+1 == game.month && date.date() == game.day)
  }
  if (state.weather != null){
    var weather = state.weather
    games = games.filter(game => game.weather != null && game.weather.temp <= weather.temp.max && game.weather.temp >= weather.temp.min)
    games = games.filter(game => game.weather != null && game.weather.dew <= weather.dew.max && game.weather.dew >= weather.dew.min)
    games = games.filter(game => game.weather != null && game.weather.pressure <= weather.pressure.max && game.weather.pressure >= weather.pressure.min)
    games = games.filter(game => game.weather != null && game.weather.humidity <= weather.humidity.max && game.weather.humidity >= weather.humidity.min)
  }
  return games
}

const getTeams = (state, games) => {

  var away_teams = new Set(["All"])
  var home_teams = new Set(["All"])

  games.forEach(game => {
    away_teams.add(game.away_team)
    home_teams.add(game.home_team)
  })

  away_teams = state.home_team == "All" ? state.teams : Array.from(away_teams).sort()
  home_teams = state.away_team == "All" ? state.teams : Array.from(home_teams).sort()

  return [away_teams, home_teams]
}



const mapStateToProps = (state, ownProps) => {
  console.log(state);
  var games = getGames(state);
  var [away_teams, home_teams] = getTeams(state, games);
  return {
    games,
    away_teams,
    home_teams
  }
}

const mapDispatchToProps = (dispatch, ownProps) => {
  return {}
}

const FilterableGameTable = connect(
  mapStateToProps,
  mapDispatchToProps
)(GameTable)

export default FilterableGameTable