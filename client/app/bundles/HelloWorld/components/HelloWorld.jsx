import React, { PropTypes } from 'react'

const HelloWorld = ({ name, onChange }) => (

	return (
    <div className="container">
      <h3>
        Hello, {name}!
      </h3>
      <hr />
      <form className="form-horizontal">
        <label>
          Say hello to:
        </label>
        <input
          type="text"
          value={name}
          onChange={onChange}
        />
      </form>
    </div>
	)

)