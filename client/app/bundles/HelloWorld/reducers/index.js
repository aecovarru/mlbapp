const helloWorld = (state = 'Stranger', action) => {
  switch(action.type) {
    case 'CHANGE':
      return action.name
    default:
      return state
  }
}

export default helloWorld
