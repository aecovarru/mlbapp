import React, { PropTypes } from 'react';

class SeasonHeader extends React.Component {
  constructor(props, context) {
    super(props, context);
    this.state = { seasons: this.props.seasons };
  }
  render(){
    return (
      <tr>
        <th>Year</th>
        <th>Games</th>
      </tr>
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
          <thead>
            <SeasonHeader />
          </thead>
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