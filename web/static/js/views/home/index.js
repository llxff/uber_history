import React                from 'react';
import { connect }          from 'react-redux';

class HomeIndexView extends React.Component {
  render() {
    return (
      <h1>Home</h1>
    );
  }
}

const mapStateToProps = (state) => ({});

export default connect(mapStateToProps)(HomeIndexView);
