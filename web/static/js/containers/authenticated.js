import React             from 'react';
import { connect }       from 'react-redux';
import { routerActions } from 'react-router-redux';

class AuthenticatedContainer extends React.Component {
  componentDidMount() {
    const { dispatch, currentUser } = this.props;
    const authToken = localStorage.getItem('authToken');

    if (authToken && !currentUser) {
      dispatch(routerActions.push('/sign_in'));
    } else if (!authToken) {
      dispatch(routerActions.push('/sign_in'));
    }
  }

  render() {
    const { currentUser } = this.props;

    if(!currentUser) return false;

    return(
      <div className="main-container">
        <h3>Authenticated</h3>
        { this.props.children }
      </div>
    );
  }
}

const mapStateToProps = (state) => ({
  currentUser: state.session.currentUser
});

export default connect(mapStateToProps)(AuthenticatedContainer);
