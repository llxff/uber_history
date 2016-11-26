import React     from "react";
import pluralize from "pluralize-ru";

export default class History extends React.Component {
  render() {
    const history = this.props.history;
    this.loadReceipts();

    if(history.length) {
      return (
        <h1>{ this.ridesCountCaption() } { this.previousWeekLink() } за { this.spentAmount() }</h1>
      );
    }
    else {
      return (
        <h1>{ this.previousWeekLink() } поездок не было</h1>
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
    const { channel, weeks_ago } = this.props;
    channel.push("history:load", { weeks_ago: weeks_ago + 1 })
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
    const { history, receipts, channel } = this.props;

    if (this.receiptsNotLoaded()) {
      history.forEach(function(request) {
        channel.push("receipt:load", { request_id: request.request_id });
      });
    }
  }

  receiptsNotLoaded() {
    const { history, receipts } = this.props;

    return history.length && !Object.keys(receipts).length
  }
}
