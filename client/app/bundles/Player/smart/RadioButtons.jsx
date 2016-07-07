import React, { PropTypes } from 'react';

class RadioButtons extends React.Component {

	constructor(props, context) {
		super(props, context);
	}

	render(){
		return (
			<p>Hello</p>
			// <div className="radio-buttons">
   //      <input type="radio" onChange={this.props.handleChange} name={this.props.name} value="all" checked={ this.props.check === "all" }/> All <br />
   //      <input type="radio" onChange={this.props.handleChange} name={this.props.name} value="starters" checked={ this.props.check === "starters" } /> Starters <br />
   //      <input type="radio" onChange={this.props.handleChange} name={this.props.name} value="bench" checked={ this.props.check === "bench" } /> Bench
   //    </div>
		);
	}

}