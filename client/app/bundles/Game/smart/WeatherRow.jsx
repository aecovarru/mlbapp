import React, { PropTypes } from 'react';

export default class WeatherRow extends React.Component {

  constructor(props, context) {
    super(props, context);
  }

  render() {
    var game = this.props.game;
    return (
      <tbody>
        {this.props.weathers.map(function(weather, index){
          return <tr>
                    <td>{weather.time}</td>
                    <td>{weather.temp}</td>
                    <td>{weather.dew}</td>
                    <td>{weather.wind_speed} mph {weather.wind_dir}</td>
                    <td>{weather.pressure}</td>
                    <td>{weather.humidity}</td>
                    <td>{weather.precip}</td>
                    <td>{weather.air_density}</td>
                  </tr>;
        })}
      </tbody>
    );
  }
}