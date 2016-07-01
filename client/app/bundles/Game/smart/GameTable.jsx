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
    this.state = { games: this.props.games, teams: this.props.teams,
    awayTeam: this.props.awayTeam, homeTeam: this.props.homeTeam, startDate: moment(), endDate: moment()};
    _.bindAll(this, ['handleAwayInput', 'handleHomeInput']);
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
    var rows = [];
    this.state.games.forEach(function(game){
      if ((awayAll || awayTeam === game.away_team) && (homeAll || homeTeam === game.home_team)){
        rows.push(game);
      }
    });
    return (
      <div className="games">
        <table className="table table-bordered">
          <GameHeader startDate={this.state.startDate} endDate={this.state.endDate} handleChangeStart={this.handleChangeStart} handleChangeEnd={this.handleChangeEnd} teams={this.state.teams} awayTeam={this.state.awayTeam} homeTeam={this.state.homeTeam} handleAwayInput={this.handleAwayInput} handleHomeInput={this.handleHomeInput}/>
          <GameRow games={rows} />
        </table>
      </div>
        
        
          
        
    );
  }
}

        