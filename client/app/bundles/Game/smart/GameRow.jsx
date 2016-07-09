import React, { PropTypes } from 'react';

export default class GameRow extends React.Component {

  constructor(props, context) {
    super(props, context);
  }

  render() {
    return (
      <tbody>
        {this.props.games.map(function(game, index){
          var temp, dew, pressure;
          if (game.weather != null){
            var weather = game.weather;
            temp = weather.temp;
            dew = weather.dew;
            pressure = weather.pressure;
          }
          return <tr>
                     <td><a href={game.show_link}>{game.date}</a></td>
                     <td>{game.away_team}-{game.away_score}</td>
                     <td>{game.home_team}-{game.home_score}</td>
                     <td>{temp}</td>
                 </tr>;
        })}
      </tbody>
    );
  }
}