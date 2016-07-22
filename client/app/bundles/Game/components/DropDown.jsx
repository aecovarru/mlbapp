import React, { PropTypes } from 'react';

const DropDown = props => {
  const teams = props.teams.map(team => <option value={team}>{team}</option>)
  const handleChange = (e) => {
    props.onUserInput(e.target.value)
  }
  return (
    <div>
        <label htmlFor={props.id}>{props.id}</label><br />
        <select onChange={handleChange} value={props.selected} id={props.id}>
        {teams}
        </select>
    </div>
  );
};

export default DropDown;