import React, { PropTypes } from 'react';
import { SeasonHeader, SeasonRow } from '../components/SeasonWidget';

export default props => {
  return (
    <div className="seasons">
      <table className="table table-bordered">
        <SeasonHeader />
        <tbody>
          { props.seasons.map(function(season){
            return <SeasonRow season={season} />;
          }) }
        </tbody>
      </table>
    </div>
  );
}