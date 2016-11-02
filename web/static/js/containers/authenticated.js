import React             from 'react';
import { connect }       from 'react-redux';
import { routerActions } from 'react-router-redux';
import Actions           from '../actions/sessions';

class AuthenticatedContainer extends React.Component {
  componentDidMount() {
    const { dispatch, currentUser } = this.props;
    const authToken = localStorage.getItem('authToken');

    if (authToken && !currentUser) {
      dispatch(Actions.currentUser());
    } else if (!authToken) {
      dispatch(routerActions.push('/sign_in'));
    }
  }

  render() {
    const { currentUser } = this.props;

    if(!currentUser) return false;

    return(
      <div>
        { this.props.children }
      </div>
    );
  }
}

const mapStateToProps = (state) => ({
  currentUser: state.session.currentUser
});

export default connect(mapStateToProps)(AuthenticatedContainer);
