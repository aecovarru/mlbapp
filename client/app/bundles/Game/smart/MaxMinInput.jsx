import React, { PropTypes } from 'react';

export default class MaxMinInput extends React.Component {

  constructor(props, context) {
    super(props, context);
    this.handleChange = this.handleChange.bind(this);
  }

  handleChange(e) {
    this.props.onUserInput(e.target.value);
  }

  render() {
    return (
      <input type="number" name={this.props.name} value={this.props.val} min={this.props.min} max={this.props.max} onChange={this.handleChange} />
    );
  }
}