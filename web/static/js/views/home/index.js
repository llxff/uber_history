import React        from 'react';
import { connect }  from 'react-redux';
import LogoutButton from '../../components/sessions/logout_button';
import History      from '../../components/history'

class HomeIndexView extends React.Component {
  render() {
    const { currentUser } = this.props;

    return (
      <div className="row">
        <div className="col-lg-3">
          <div className="text-center">
            <img className="img-circle" src={ currentUser.picture } />
            <h5>{ currentUser.first_name } { currentUser.last_name }</h5>
            <LogoutButton />
          </div>
        </div>
        <div className="col-lg-9">
          <History history={ this.props.history }
                   receipts={ this.props.receipts }
                   channel={ this.props.channel }
                   weeks_ago={ this.props.weeks_ago } />
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
  weeks_ago: state.history.weeks_ago
});

export default connect(mapStateToProps)(HomeIndexView);
