import React, { PropTypes } from 'react';
import { WeatherHeader, WeatherRow } from '../components/WeatherWidget';

export default class WeatherTable extends React.Component {
  static propTypes = {
    weathers: PropTypes.array.isRequired,
  };

  constructor(props, context){
  	super(props, context);
  }

  render() {

  	return (
      <div className="weathers">
        <table className="table table-bordered">
          <caption>Weather</caption>
          <WeatherHeader />
          <WeatherRow weathers={this.props.weathers} />
        </table>
      </div>
  	)
  }

}