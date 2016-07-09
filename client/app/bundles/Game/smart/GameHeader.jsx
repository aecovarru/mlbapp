import React, { PropTypes } from 'react';
import DropDown from './DropDown';
import MaxMinInput from './MaxMinInput';
import DatePicker from 'react-datepicker';

export default class GameHeader extends React.Component {

  constructor(props, context) {
    super(props, context);
  }

  render(){
    return (
      <thead>
        <tr>
          <th width="200">Date Range<DatePicker dateFormat="YYYY/MM/DD" placeholderText="Select a date" selected={this.props.selected} minDate={this.props.startDate} maxDate={this.props.endDate} onChange={this.props.handleDateChange} isClearable={true} /></th>
          <th><DropDown id="Away Team" selected={this.props.awayTeam} teams={this.props.awayTeams} onUserInput={this.props.handleAwayInput}/></th>
          <th><DropDown id="Home Team" selected={this.props.homeTeam} teams={this.props.homeTeams} onUserInput={this.props.handleHomeInput}/></th>
          <th>Temp<br/>
              Min<input type="number" name="minTemp" value={this.props.minTempVal} min={this.props.minTemp} max={this.props.maxTemp} onChange={this.props.handleTempMinInput} /><br />
              Max<input type="number" name="maxTemp" value={this.props.maxTempVal} min={this.props.minTemp} max={this.props.maxTemp} onChange={this.props.handleTempMaxInput} /></th>
        </tr>
      </thead>
    );

  }
}