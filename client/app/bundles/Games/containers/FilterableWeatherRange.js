import { connect } from 'react-redux'
import { changeWeather } from '../actions'
import WeatherRange from '../components/WeatherRange'

const getMaxMin = (state, id) => {
	var weather = state.weather;
	switch(id){
		case 'Temp':
			weather = weather.temp;
			break;
		case 'Dew':
			weather = weather.dew;
			break;
		case 'Pressure':
			weather = weather.pressure;
			break;
		case 'Humidity':
			weather = weather.humidity;
			break;
	}
	return weather
}

const mapStateToProps = (state, ownProps) => {
  var maxmin = getMaxMin(state, ownProps.id);
  return {
    maxmin
  }
}

const mapDispatchToProps = (dispatch, ownProps) => {
  return {
    changeWeather: (maxormin, val) => {
      dispatch(changeWeather(ownProps.id, maxormin, Number(val)));
    }
  }
}

const FilterableWeatherRange = connect(
  mapStateToProps,
  mapDispatchToProps
)(WeatherRange)

export default FilterableWeatherRange