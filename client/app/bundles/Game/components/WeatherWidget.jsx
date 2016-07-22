import React, { PropTypes } from 'react';

const WeatherHeader = () => {
  return (
    <thead>
      <tr>
        <th>Time</th>
        <th>Temp</th>
        <th>Dew</th>
        <th>Wind</th>
        <th>Pressure</th>
        <th>Humidity</th>
        <th>Precip</th>
        <th>Air Density</th>
      </tr>
    </thead>
  );
}

const WeatherRow = props => {
    let degree = String.fromCharCode(176) + "F";
    return (
      <tbody>
        {props.weathers.map(function(weather, index){
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

export { WeatherHeader, WeatherRow }