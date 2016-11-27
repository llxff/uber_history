import React        from 'react';
import { connect }  from 'react-redux';

class Spinner extends React.Component {
  render() {
    if(this.props.receipts_loading) {
      return (
        <div className="loader"></div>
      )
    }
    else {
      return null;
    }
  }
}

const mapStateToProps = (state) => ({
  receipts_loading: state.history.receipts_loading
});

export default connect(mapStateToProps)(Spinner);
