import React, { PropTypes } from 'react';

export default class WeatherRow extends React.Component {

  constructor(props, context) {
    super(props, context);
  }

  render() {
    var game = this.props.game;
    var degree = String.fromCharCode(176) + "F";
    return (
      <tbody>
        {this.props.weathers.map(function(weather, index){
          return <tr>
                    <td>{weather.time}</td>
                    <td>{weather.temp + degree}</td>
                    <td>{weather.dew + degree}</td>
                    <td>{weather.wind_speed} mph {weather.wind_dir}</td>
                    <td>{weather.pressure} in</td>
                    <td>{weather.humidity}%</td>
                    <td>{weather.precip} in</td>
                    <td>{weather.air_density + " kg/m"}<sup>3</sup></td>
                  </tr>;
        })}
      </tbody>
    );
  }
}