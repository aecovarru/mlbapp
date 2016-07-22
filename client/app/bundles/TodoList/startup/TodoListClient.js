import React from 'react'
import { Provider } from 'react-redux'
import { createStore } from 'redux'
import todoApp from '../reducers'
import App from '../components/App'

export default (props) => {
	
  let store = createStore(todoApp, { todos: [{
        id: 1,
        text: props.name,
        completed: false
      }], visibilityFilter: 'SHOW_ALL' })

  return (
  	<Provider store={store}>
  	  <App />
  	</Provider>
  )
};