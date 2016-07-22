const date = (state = null, action) => {
	switch (action.type) {
		case 'PICK_DATE':
			return action.date
		default:
			return state
	}
}

export default date