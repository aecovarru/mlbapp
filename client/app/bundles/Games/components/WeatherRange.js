import React from 'react'

const WeatherRange = ({ id, maxmin, changeWeather }) => {
  return (
  	<div>
  		<label htmlFor={id}>{id}</label><br />
    	<input type="number" name="max" value={maxmin.max} min={maxmin.min} max={maxmin.gmax} onChange={(e) => changeWeather("Max", e.target.value)} /><br />
    	<input type="number" name="min" value={maxmin.min} min={maxmin.gmin} max={maxmin.max} onChange={(e) => changeWeather("Min", e.target.value)} />
    </div>
  );
};

export default WeatherRange