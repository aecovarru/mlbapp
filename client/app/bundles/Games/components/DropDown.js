import React from 'react'

const DropDown = ({ id, teams, team, select }) => {
  const options = teams.map((team) => <option value={team}>{team}</option>)
  return (
    <div>
        <label htmlFor={id}>{id}</label><br />
        <select id={id} value={team} onChange={(e) => select(e.target.value)} >
        	{options}
        </select>
    </div>
  );
};

export default DropDown