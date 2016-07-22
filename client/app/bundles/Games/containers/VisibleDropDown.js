import { connect } from 'react-redux'
import { toggleTeam } from '../actions'
import DropDown from '../components/DropDown'

const mapStateToProps = (state, ownProps) => {
  var team = ownProps.id == 'Away Team' ? state.away_team : state.home_team
  return {
    team
  }
}

const mapDispatchToProps = (dispatch, ownProps) => {
  return {
    select: (name) => {
      dispatch(toggleTeam(ownProps.id, name))
    }
  }
}

const VisibleDropDown = connect(
  mapStateToProps,
  mapDispatchToProps
)(DropDown)

export default VisibleDropDown