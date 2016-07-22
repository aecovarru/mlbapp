import React, { PropTypes } from 'react';
import DropDown from './DropDown';
import MaxMinInput from './MaxMinInput';
import DatePicker from 'react-datepicker';

const GameHeader = props => {
  return (
    <thead>
      <tr>
        <th width="200">Date Range<DatePicker dateFormat="YYYY/MM/DD" placeholderText="Select a date" selected={props.selected} minDate={props.startDate} maxDate={props.endDate} onChange={props.handleDateChange} isClearable={true} /></th>
        <th><DropDown id="Away Team" selected={props.awayTeam} teams={props.awayTeams} onUserInput={props.handleAwayInput}/></th>
        <th><DropDown id="Home Team" selected={props.homeTeam} teams={props.homeTeams} onUserInput={props.handleHomeInput}/></th>
        <th>Temp<br/>
            Min<input type="number" name="minTemp" value={props.minTempVal} min={props.minTemp} max={props.maxTemp} onChange={props.handleTempMinInput} /><br />
            Max<input type="number" name="maxTemp" value={props.maxTempVal} min={props.minTemp} max={props.maxTemp} onChange={props.handleTempMaxInput} /></th>
      </tr>
    </thead>
  );
}

const GameRow = props => {
  return (
    <tbody>
      {props.games.map(function(game, index){
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

export { GameHeader, GameRow }