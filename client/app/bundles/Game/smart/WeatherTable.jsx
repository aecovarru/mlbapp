import React, { PropTypes } from 'react';
import WeatherHeader from './WeatherHeader';
import WeatherRow from './WeatherRow';

export default class WeatherTable extends React.Component {
  static propTypes = {
    weathers: PropTypes.array.isRequired,
  };

  constructor(props, context){
  	super(props, context);
  	this.state = { weathers: this.props.weathers }
  }

  render() {

  	return (
      <div className="weathers">
        <table className="table table-bordered">
          <caption>Weather</caption>
          <WeatherHeader />
          <WeatherRow weathers={this.state.weathers} />
        </table>
      </div>
  	)
  }

}