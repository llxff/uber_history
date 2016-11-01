import React       from 'react';
import { connect } from 'react-redux';

class SessionsNew extends React.Component {
  render() {
    return (
      <div>
        <a className="btn btn-primary btn-lg" href="/auth">
          <i className="fa fa-google"></i>
          Sign in with Uber
        </a>
      </div>
    );
  }
}

const mapStateToProps = (state) => ({});

export default connect(mapStateToProps)(SessionsNew);
