import React, { PropTypes } from 'react';

export default class GameRow extends React.Component {

  constructor(props, context) {
    super(props, context);
  }

  render() {
    return (
      <tbody>
        {this.props.games.map(function(game, index){
          return <tr><td><a href={game.show_link}>{game.date}</a></td><td>{game.away_team}</td><td>{game.home_team}</td></tr>;
        })}
      </tbody>
    );
  }
}