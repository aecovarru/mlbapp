import { connect } from 'react-redux'
import { pickDate } from '../actions'
import DatePicker from '../components/DatePicker'
import moment from 'moment'

const mapStateToProps = (state, ownProps) => {
  var games = state.games
  var lastGame = games[0]
  var firstGame = games[games.length-1]
  var startDate = moment().set({'year': firstGame.year, 'month': firstGame.month-1, 'date': firstGame.day})
  var endDate = moment().set({'year': lastGame.year, 'month': lastGame.month-1, 'date': lastGame.day})
  return {
    startDate,
    endDate,
    date: state.date
  }
}

const mapDispatchToProps = (dispatch, ownProps) => {
  return {
    select: (id, val, maxmin) => {
      dispatch(pickDate(id, val, maxmin))
    }
  }
}

const FilterableDatePicker = connect(
  mapStateToProps,
  mapDispatchToProps
)(DatePicker)

export default FilterableDatePicker