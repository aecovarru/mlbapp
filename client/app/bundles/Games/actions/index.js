export const toggleTeam = (id, team) => {
	return {
		type: 'TOGGLE_TEAM',
		id,
		team
	}
}

export const pickDate = (date) => {
	return {
		type: 'PICK_DATE',
		date
	}
}

export const changeWeather = (id, maxormin, val) => {
	return {
		type: 'CHANGE_WEATHER',
		id,
		val,
		maxormin
	}
}