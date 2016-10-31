import React             from 'react';
import { connect }       from 'react-redux';

class AuthenticatedContainer extends React.Component {
  render() {
    return(
      <div className="main-container">
        <h3>Authenticated</h3>
        { this.props.children }
      </div>
    );
  }
}

const mapStateToProps = (state) => ({});

export default connect(mapStateToProps)(AuthenticatedContainer);
