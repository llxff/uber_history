import React        from 'react';
import { connect }  from 'react-redux';
import LogoutButton from '../sessions/logout_button';
import Spinner      from '../spinner';

class Header extends React.Component {
  render() {
    const { currentUser } = this.props;

    return (
      <div className="header">
        <div className="row">
          <div className="col-lg-2">
            <Spinner />
          </div>
          <div className="user-info col-lg-10">
            <img className="avatar img-circle" src={ currentUser.picture } />
            <span> </span>
            <span>{ currentUser.first_name } { currentUser.last_name }</span>
            <span> </span>
            <LogoutButton />
          </div>
        </div>
      </div>
    );
  }
}

const mapStateToProps = (state) => ({
  currentUser: state.session.currentUser
});

export default connect(mapStateToProps)(Header);
