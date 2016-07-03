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
    awayTeam: this.props.awayTeam, homeTeam: this.props.homeTeam, startDate: moment(), endDate: moment()};
    _.bindAll(this, ['handleAwayInput', 'handleHomeInput']);
    this.state.teams.push("All");
    this.state.teams.sort();
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
    var awayAll = awayTeam === "All";
    var homeAll = homeTeam === "All";
    var games = [];
    var awayTeams = new Set(["All"]);
    var homeTeams = new Set(["All"]);
    this.state.games.forEach(function(game){
      if ((awayAll || awayTeam === game.away_team) && (homeAll || homeTeam === game.home_team)){
        games.push(game);
        awayTeams.add(game.away_team);
        homeTeams.add(game.home_team);
      }
    });
    var count = 0;
    if (awayAll) { count += 1; }
    if (homeAll) { count += 1; }
    awayTeams = count == 2 || count == 0 || (count == 1 && homeAll) ? this.state.teams : Array.from(awayTeams).sort();
    homeTeams = count == 2 || count == 0 || (count == 1 && awayAll) ? this.state.teams : Array.from(homeTeams).sort();
    return (
      <div className="games">
        <table className="table table-bordered">
          <GameHeader awayTeams={awayTeams} homeTeams={homeTeams} awayTeam={awayTeam} homeTeam={homeTeam} handleAwayInput={this.handleAwayInput} handleHomeInput={this.handleHomeInput}/>
          <GameRow games={games} />
        </table>
      </div>
        
        
          
        
    );
  }
}

        