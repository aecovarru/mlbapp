import React, { PropTypes } from 'react';

class SeasonHeader extends React.Component {

  constructor(props, context) {
    super(props, context);
  }

  render(){
    return (
      <thead>
        <tr>
          <th>Year</th>
          <th>Games</th>
        </tr>
      </thead>
    );
  }
}

export default class SeasonTable extends React.Component {
  
  static propTypes = {
    seasons: PropTypes.array.isRequired,
  };

  constructor(props, context) {
    super(props, context);
    this.state = { seasons: this.props.seasons };
  }

  render() {
    return (
      <div className="seasons">
        <table className="table table-bordered">
          <SeasonHeader />
          <tbody>
              {this.state.seasons.map(function(season, index){
                return <tr><td>{season.year}</td><td><a href={season.games_link}>Games</a></td></tr>;
              })}
          </tbody>
        </table>
      </div>
    );
  }
}