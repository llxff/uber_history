import React                from 'react';
import { connect }          from 'react-redux';

class LogoutButton extends React.Component {
  render() {
    const { csrfToken } = this.props;

    return (
      <form action="/auth/logout" className="link" method="post">
         <input name="_method" type="hidden" value="delete" />
         <input name="_csrf_token" type="hidden" value={ csrfToken } />
         <button className="btn btn-danger btn-xs">Log out</button>
      </form>
    );
  }
}

const mapStateToProps = (state) => ({
  csrfToken: localStorage.getItem("csrfToken"),
});

export default connect(mapStateToProps)(LogoutButton);
