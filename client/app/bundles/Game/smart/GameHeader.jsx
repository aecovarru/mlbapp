import React, { PropTypes } from 'react';
import DropDown from './DropDown';
import DatePicker from 'react-datepicker';

export default class GameHeader extends React.Component {

  constructor(props, context) {
    super(props, context);
  }

  render(){
    return (
      <thead>
        <tr>
          <th width="200">Date Range<DatePicker selected={this.props.startDate} startDate={this.props.startDate} endDate={this.props.endDate} onChange={this.props.handleChangeStart} /></th>
          <th><DropDown id="Away Team" selected={this.props.awayTeam} teams={this.props.teams} onUserInput={this.props.handleAwayInput}/></th>
          <th><DropDown id="Home Team" selected={this.props.homeTeam} teams={this.props.teams} onUserInput={this.props.handleHomeInput}/></th>
        </tr>
      </thead>
    );

  }
}