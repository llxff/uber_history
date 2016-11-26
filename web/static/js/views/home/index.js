import React        from 'react';
import { connect }  from 'react-redux';
import LogoutButton from '../../components/sessions/logout_button';
import History      from '../../components/history'

class HomeIndexView extends React.Component {
  render() {
    const { currentUser } = this.props;

    return (
      <div>
        <div className="header">
          <img className="avatar img-circle" src={ currentUser.picture } />
          <span> </span>
          <span>{ currentUser.first_name } { currentUser.last_name }</span>
          <span> </span>
          <LogoutButton />
        </div>
        <div className="vertical-center">
          <div className="container-fluid">
            <History history={ this.props.history }
                     receipts={ this.props.receipts }
                     channel={ this.props.channel }
                     weeks_ago={ this.props.weeks_ago }
                     spent_amount={ this.props.spent_amount } />
          </div>
        </div>
      </div>
    );
  }
}

const mapStateToProps = (state) => ({
  currentUser: state.session.currentUser,
  history: state.history.history,
  receipts: state.history.receipts,
  channel: state.history.channel,
  weeks_ago: state.history.weeks_ago,
  spent_amount: state.history.spent_amount
});

export default connect(mapStateToProps)(HomeIndexView);
