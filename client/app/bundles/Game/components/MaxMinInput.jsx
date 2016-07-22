import React, { PropTypes } from 'react';

const MaxMinInput = props => {

  const handleChange = (e) => {
    props.onUserInput(e.target.value)
  }

  return (
    <input type="number" name={props.name} value={props.val} min={props.min} max={props.max} onChange={handleChange} />
  );

}

export default MaxMinInput;