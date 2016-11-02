import React        from 'react';
import { connect }  from 'react-redux';
import LogoutButton from './_logout_button';

class HomeIndexView extends React.Component {
  render() {
    const { currentUser } = this.props;

    return (
      <div>
        <h1>{ currentUser.first_name } { currentUser.last_name }</h1>
        <img src={ currentUser.picture } />
        <LogoutButton />
      </div>
    );
  }
}

const mapStateToProps = (state) => ({
  currentUser: state.session.currentUser,
});

export default connect(mapStateToProps)(HomeIndexView);
