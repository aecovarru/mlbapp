import React, { PropTypes } from 'react';
import RadioButtons from './RadioButtons';
import _ from 'lodash';

class PitcherHeader extends React.Component {

  constructor(props, context) {
    super(props, context);
  }

  render(){
    return (
      <thead>
        <tr>
          <th>Pitching</th><th>IP</th><th>R</th><th>UBB</th><th>IBB</th><th>H</th><th>1B</th><th>2B</th><th>3B</th><th>HR</th><th>SB</th><th>SO</th><th>GB</th><th>FB</th><th>LD</th>
        </tr>
      </thead>
    );
  }

}

class PitcherRow extends React.Component{

  constructor(props, context) {
    super(props, context);
  }

  render(){
    var pitcher = this.props.pitcher;
    var stat = pitcher.stat;
    return (
      <tr>
        <td width="200">{pitcher.name}</td><td>{stat.ip}</td><td>{stat.r}</td><td>{stat.ubb}</td><td>{stat.ibb}</td>
        <td>{stat.h}</td><td>{stat.single}</td><td>{stat.double}</td><td>{stat.triple}</td><td>{stat.homerun}</td>
        <td>{stat.sb}</td><td>{stat.k}</td><td>{stat.gb}</td><td>{stat.fb}</td><td>{stat.ld}</td>
      </tr>
    );
  }

}

export default class PitcherTable extends React.Component {

  static propTypes = {
    team: PropTypes.object.isRequired,
    pitchers: PropTypes.array.isRequired,
  };

  constructor(props, context) {
    super(props, context);
    this.state = { pitchers: this.props.pitchers, team: this.props.team, checked: "all"  };
    _.bindAll(this, 'handleChange');
  }

  handleChange(event){
    this.setState({checked: event.target.value});
  }

  render() {

    var team = this.state.team;
    var checked = this.state.checked;
    var pitchers = [];
    this.state.pitchers.forEach(function(pitcher){
      if (pitcher.starter){
        if (checked === "all" || checked === "starters"){
          pitchers.push(pitcher);
        }
      } else {
        if (checked === "all" || checked === "bench"){
          pitchers.push(pitcher);
        }
      }
    });

    return (
      <div className="pitchers">
        <input type="radio" onChange={this.handleChange} name={team.name + " Pitchers"} value="all" checked={ checked === "all" }/> All <br />
        <input type="radio" onChange={this.handleChange} name={team.name + " Pitchers"} value="starters" checked={ checked === "starters" } /> Starters <br />
        <input type="radio" onChange={this.handleChange} name={team.name + " Pitchers"} value="bench" checked={ checked === "bench" } /> Bench
        <table className="table table-bordered">
          <caption>{team.name} Pitchers</caption>
          <PitcherHeader />
          <tbody>
              {pitchers.map(function(pitcher, index){
                return <PitcherRow pitcher={pitcher} />
              })}
          </tbody>
        </table>
      </div>
    );
  }

}