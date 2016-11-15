import React        from 'react';
import { connect }  from 'react-redux';
import LogoutButton from '../../components/sessions/logout_button';
import History      from '../../components/history'

class HomeIndexView extends React.Component {
  render() {
    const { currentUser } = this.props;

    return (
      <div className="container">
        <h1>{ currentUser.first_name } { currentUser.last_name }</h1>
        <img src={ currentUser.picture } />
        <LogoutButton />
        <History history={ this.props.history }
                 receipts={ this.props.receipts }
                 channel={ this.props.channel }
                 weeks_ago={ this.props.weeks_ago } />
      </div>
    );
  }
}

const mapStateToProps = (state) => ({
  currentUser: state.session.currentUser,
  history: state.history.history,
  receipts: state.history.receipts,
  channel: state.history.channel,
  weeks_ago: state.history.weeks_ago
});

export default connect(mapStateToProps)(HomeIndexView);
