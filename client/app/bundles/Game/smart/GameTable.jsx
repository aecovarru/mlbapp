import React, { PropTypes } from 'react';
import _ from 'lodash';
import moment from 'moment';
import GameHeader from './GameHeader'
import GameRow from './GameRow'

export default class GameTable extends React.Component {
  static propTypes = {
    games: PropTypes.array.isRequired,
  };

  constructor(props, context) {
    super(props, context);
    this.state = { games: this.props.games, teams: this.props.teams.map(function(team){ return team.name; }),
    awayTeam: this.props.awayTeam, homeTeam: this.props.homeTeam, selected: null, minTempVal: null, maxTempVal: null};
    _.bindAll(this, ['handleAwayInput', 'handleHomeInput', 'handleDateChange', 'handleTempMinInput', 'handleTempMaxInput', 'dateBool']);
    this.state.teams.push("All");
    this.state.teams.sort();

    var minTemp, maxTemp;
    this.state.games.forEach(function(game){
      var weather = game.weather;
      if (weather != null){
        var temp = weather.temp;
        if (minTemp == null || minTemp >= temp){
          minTemp = temp;
        }
        if (maxTemp == null || maxTemp <= temp){
          maxTemp = temp;
        }
      }
    });

    this.state.minTemp = minTemp;
    this.state.maxTemp = maxTemp;
    this.state.minTempVal = minTemp;
    this.state.maxTempVal = maxTemp;

  }

  handleDateChange(date){
    this.setState({selected: date})
  }

  handleAwayInput(away){
    this.setState({awayTeam: away});
  }

  handleHomeInput(home){
    this.setState({homeTeam: home});
  }

  handleTempMinInput(e){
    const minTempVal = e.target.value;
    this.setState({minTempVal: minTempVal});
  }

  handleTempMaxInput(e){
    const maxTempVal = e.target.value;
    this.setState({maxTempVal: maxTempVal});
  }

  teamBool(game){
    var awayBool = this.state.awayTeam == "All" || this.state.awayTeam == game.away_team;
    var homeBool = this.state.homeTeam == "All" || this.state.homeTeam == game.home_team;
    return awayBool && homeBool;
  }

  dateBool(game){
    var selected = this.state.selected;
    return (selected === null || (selected.date() === game.day && selected.month()+1 === game.month));
  }

  weatherBool(game){
    var weather = game.weather;
    return weather == null || (this.state.maxTempVal >= weather.temp && this.state.minTempVal <= weather.temp);
  }


  render() {
    var games = [];
    var awayTeams = new Set(["All"]);
    var homeTeams = new Set(["All"]);

    this.state.games.forEach(function(game){
      if (this.dateBool(game) && this.teamBool(game) && this.weatherBool(game)){
        games.push(game);
      }
      if (this.state.awayTeam === game.away_team){
        homeTeams.add(game.home_team);
      }
      if (this.state.homeTeam === game.home_team){
        awayTeams.add(game.away_team);
      }
    }.bind(this));

    awayTeams = this.state.awayTeam == "All" ? this.state.teams : Array.from(awayTeams).sort();
    homeTeams = this.state.homeTeam == "All" ? this.state.teams : Array.from(homeTeams).sort();

    var lastGame = this.state.games[0];
    var firstGame = this.state.games[this.state.games.length - 1];
    var startDate = moment().set({'year': firstGame.year, 'month': firstGame.month-1, 'date': firstGame.day});
    var endDate = moment().set({'year': lastGame.year, 'month': lastGame.month-1, 'date': lastGame.day});

    return (
      <div className="games">
        <p>{this.state.awayTeam}</p>
        <table className="table table-bordered">
          <GameHeader minTemp={this.state.minTemp} maxTemp={this.state.maxTemp} minTempVal={this.state.minTempVal} maxTempVal={this.state.maxTempVal}
                      selected={this.state.selected} startDate={startDate} endDate={endDate}
                      awayTeams={awayTeams} homeTeams={homeTeams}
                      awayTeam={this.state.awayTeam} homeTeam={this.state.homeTeam}
                      handleDateChange={this.handleDateChange} handleAwayInput={this.handleAwayInput} handleHomeInput={this.handleHomeInput} handleTempMinInput={this.handleTempMinInput} handleTempMaxInput={this.handleTempMaxInput}/>
          <GameRow games={games} />
        </table>
      </div>
    );

  }
}

        