import React       from 'react';
import { connect } from 'react-redux';

class SessionsNew extends React.Component {
  render() {
    return (
      <div className="vertical-center">
        <div className="container-fluid">
          <h1>Сколько Вы тратите с Uber?</h1>
          <div className="sign-in">
            <a className="button" href="/auth">Узнать</a>
          </div>
        </div>
      </div>
    );
  }
}

const mapStateToProps = (state) => ({});

export default connect(mapStateToProps)(SessionsNew);
