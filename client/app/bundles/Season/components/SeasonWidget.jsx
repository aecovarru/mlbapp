import React, { PropTypes } from 'react';

const SeasonHeader = () => {
  return (
    <thead>
      <tr>
        <th>Year</th>
        <th>Games</th>
      </tr>
    </thead>
  );
}

const SeasonRow = props => {
	let season = props.season;
	return (<tr><td>{season.year}</td><td><a href={season.games_link}>Games</a></td></tr>);
}

export { SeasonHeader, SeasonRow }