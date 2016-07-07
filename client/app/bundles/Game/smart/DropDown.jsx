import React, { PropTypes } from 'react';

export default class DropDown extends React.Component {

  constructor(props, context) {
    super(props, context);
    this.handleChange = this.handleChange.bind(this);
  }

  handleChange(e) {
    this.props.onUserInput(e.target.value);
  }

  render() {
    var options = this.props.teams.map(function(team){
      return <option value={team}>{team}</option>;
    });
    return (
      <div>
        <label htmlFor={this.props.id}>{this.props.id}</label>
        <select onChange={this.handleChange} value={this.props.selected} id={this.props.id}>
        {options}
        </select>
      </div>
    );
  }
}