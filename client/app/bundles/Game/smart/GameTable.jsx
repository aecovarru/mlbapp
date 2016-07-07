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
    awayTeam: this.props.awayTeam, homeTeam: this.props.homeTeam, selected: null};
    _.bindAll(this, ['handleAwayInput', 'handleHomeInput', 'handleDateChange']);
    this.state.teams.push("All");
    this.state.teams.sort();
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


  render() {

    var awayTeam = this.state.awayTeam;
    var homeTeam = this.state.homeTeam;
    var selected = this.state.selected;
    var awayAll = awayTeam === "All";
    var homeAll = homeTeam === "All";
    var games = [];
    var awayTeams = new Set(["All"]);
    var homeTeams = new Set(["All"]);

    this.state.games.forEach(function(game){
      if ((selected === null || (selected.date() === game.day && selected.month()+1 === game.month)) &&
          (awayAll || awayTeam === game.away_team) && (homeAll || homeTeam === game.home_team)){
        games.push(game);
      }
      if (awayTeam === game.away_team){
        homeTeams.add(game.home_team);
      }
      if (homeTeam === game.home_team){
        awayTeams.add(game.away_team);
      }
    });

    awayTeams = homeAll ? this.state.teams : Array.from(awayTeams).sort();
    homeTeams = awayAll ? this.state.teams : Array.from(homeTeams).sort();

    var lastGame = this.state.games[0];
    var firstGame = this.state.games[this.state.games.length - 1];
    var startDate = moment().set({'year': firstGame.year, 'month': firstGame.month-1, 'date': firstGame.day});
    var endDate = moment().set({'year': lastGame.year, 'month': lastGame.month-1, 'date': lastGame.day});
    

    return (
      <div className="games">
        <table className="table table-bordered">
          <GameHeader selected={selected} startDate={startDate} endDate={endDate} awayTeams={awayTeams} homeTeams={homeTeams} awayTeam={awayTeam} homeTeam={homeTeam} handleDateChange={this.handleDateChange} handleAwayInput={this.handleAwayInput} handleHomeInput={this.handleHomeInput}/>
          <GameRow games={games} />
        </table>
      </div>
    );

  }
}

        