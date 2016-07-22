const away_team = (state = "All", action) => {
  	switch (action.type) {
    	case 'TOGGLE_TEAM':
      		var team = action.id == "Away Team" ? action.team : state
     		return team
    	default:
    		return state
  	}
}

export default away_team