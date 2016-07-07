import React, { PropTypes } from 'react';

export default class WeatherHeader extends React.Component {

  constructor(props, context) {
    super(props, context);
  }

  render(){
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
}