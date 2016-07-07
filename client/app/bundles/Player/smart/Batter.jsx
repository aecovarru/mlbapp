import React, { PropTypes } from 'react';
import _ from 'lodash';

class BatterHeader extends React.Component {

  constructor(props, context) {
    super(props, context);
  }

  render(){
    return (
      <thead>
        <tr>
          <th>Batting</th><th>AB</th><th>PA</th><th>UBB</th><th>IBB</th><th>H</th><th>1B</th><th>2B</th><th>3B</th><th>HR</th><th>SO</th><th>GB</th><th>FB</th><th>LD</th>
        </tr>
      </thead>
    );
  }

}

class BatterRow extends React.Component{

  constructor(props, context) {
    super(props, context);
  }

  render(){
    var batter = this.props.batter;
    var stat = batter.stat;
    return (
      <tr>
        <td width="200">{batter.lineup}. {batter.name}</td><td>{stat.ab}</td><td>{stat.pa}</td><td>{stat.ubb}</td><td>{stat.ibb}</td><td>{stat.h}</td>
        <td>{stat.single}</td><td>{stat.double}</td><td>{stat.triple}</td><td>{stat.homerun}</td><td>{stat.k}</td>
        <td>{stat.gb}</td><td>{stat.fb}</td><td>{stat.ld}</td>
      </tr>
    );
  }

}

export default class BatterTable extends React.Component {

  static propTypes = {
    team: PropTypes.object.isRequired,
    batters: PropTypes.array.isRequired,
  };

  constructor(props, context) {
    super(props, context);
    this.state = { batters: this.props.batters.filter(function(batter){return batter.stat != null;}), team: this.props.team, checked: "all" };
    _.bindAll(this, 'handleChange');
  }

  handleChange(event){
    this.setState({checked: event.target.value});
  }

  render() {
    var team = this.state.team;
    var checked = this.state.checked;
    var batters = [];
    this.state.batters.forEach(function(batter){
      if (batter.starter){
        if (checked === "all" || checked === "starters"){
          batters.push(batter);
        }
      } else {
        if (checked === "all" || checked === "bench"){
          batters.push(batter);
        }
      }
    });
    return (
      <div className="batters">
        <input type="radio" onChange={this.handleChange} name={team.name + " Batters"} value="all" checked={ checked === "all" }/> All <br />
        <input type="radio" onChange={this.handleChange} name={team.name + " Batters"} value="starters" checked={ checked === "starters" } /> Starters <br />
        <input type="radio" onChange={this.handleChange} name={team.name + " Batters"} value="bench" checked={ checked === "bench" } /> Bench
        <table className="table table-bordered">
          <caption>{team.name} Batters</caption>
          <BatterHeader />
          <tbody>
              {batters.map(function(batter, index){
                return <BatterRow batter={batter} />
              })}
          </tbody>
        </table>
      </div>
    );
  }
}