import React       from "react";
import pluralize   from "pluralize-ru";
import Actions     from "../../actions/history";
import { connect } from 'react-redux';

class History extends React.Component {
  render() {
    const { history_loading, history } = this.props;
    const captionClass = history_loading ? "blur" : null;

    this.loadReceipts();

    if(history.length) {
      return (
        <h1 className={ captionClass }>{ this.ridesCountCaption() } { this.previousWeekLink() } за { this.spentAmount() }</h1>
      );
    }
    else {
      return (
        <h1 className={ captionClass }>{ this.previousWeekLink() } поездок не было</h1>
      );
    }
  }

  ridesCountCaption() {
    const { history } = this.props;

    return pluralize(
      history.length,
      "поездок не было",
      `%d поездка`,
      "%d поездки",
      "%d поездок"
    );
  }


  previousWeekLink() {
    return (
      <a className="fake-link" onClick={ ::this.previousWeek }>
        { ::this.previousWeekCaption() }
      </a>
    )
  }

  previousWeek() {
    const { dispatch, weeks_ago, channel, history_loading } = this.props;

    if (!history_loading) {
      dispatch(Actions.loadHistory(weeks_ago, channel));
    }
  }

  previousWeekCaption() {
    const { weeks_ago } = this.props;

    return pluralize(
      weeks_ago,
      "на этой неделе",
      `%d неделю назад`,
      "%d недели назад",
      "%d недель назад"
    );
  }

  spentAmount() {
    const { spent_amount } = this.props;
    const spent_amount_arr = [];
    const currencies = Object.keys(spent_amount);

    if (currencies.length) {
      currencies.forEach(function(currency) {
        spent_amount_arr.push(`${ spent_amount[currency] } ${ currency }`)
      });

      return spent_amount_arr.join(', ');
    }
    else {
      return "0";
    }
  }

  loadReceipts() {
    const { history, dispatch, channel } = this.props;

    if (this.receiptsNotLoaded()) {
      dispatch(Actions.loadRequests(history, channel));
    }
  }

  receiptsNotLoaded() {
    const { history, receipts } = this.props;

    return history.length && !Object.keys(receipts).length
  }
}

const mapStateToProps = (state) => ({
  history: state.history.history,
  receipts: state.history.receipts,
  channel: state.history.channel,
  weeks_ago: state.history.weeks_ago,
  spent_amount: state.history.spent_amount,
  history_loading: state.history.history_loading
});

export default connect(mapStateToProps)(History);
