import { connect } from 'react-redux'
import { changeName } from '../actions'
import HelloWorld from '../components/HelloWorld'

const mapStateToProps = (state) => {
  return {
    name: state.name
  }
}

const mapDispatchToProps = (dispatch) => {
  return {
    onChange: (event) => {
      const name = event.target.value
      dispatch(changeName(name))
    }
  }
}

const HelloWorldContainer = connect(
  mapStateToProps,
  mapDispatchToProps
)(HelloWorld)

export default HelloWorldContainer
