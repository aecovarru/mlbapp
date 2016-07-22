const updateWeather = (weather, id, maxormin, val) => {
	var valueObject = maxormin == "Max" ? { max: val } : { min: val };
	switch(id) {
		case 'Temp':
			return { temp: Object.assign({}, weather.temp, valueObject) };
		case 'Dew':
			return { dew: Object.assign({}, weather.dew, valueObject) };
		case 'Pressure':
			return { pressure: Object.assign({}, weather.pressure, valueObject) };
		case 'Humidity':
			return { humidity: Object.assign({}, weather.humidity, valueObject) };
	}
}

const weather = (state = {}, action) => {
  	switch (action.type) {
    	case 'CHANGE_WEATHER':
    		var weatherObject = updateWeather(state, action.id, action.maxormin, action.val);
    		return Object.assign({}, state, weatherObject);
    	default:
    		return state
  	}
}

export default weather