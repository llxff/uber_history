import React    from "react";
import Ride     from "./ride";

export default class History extends React.Component {
  render() {
    const history = this.props.history;
    const { channel, receipts } = this.props;

    return (
      <table className="table table-striped">
        <caption>
          { history.length } поездок за неделю,&nbsp;
          <a className="fake-link" onClick={ ::this.previousWeek }>{ ::this.previousWeekCaption() }</a>
        </caption>
        <thead>
          <tr>
            <th>Дистанция</th>
            <th>Время заказа</th>
            <th>Начало поездки</th>
            <th>Завершение поездки</th>
            <th>Стоимость поездки</th>
          </tr>
        </thead>
        <tbody>
          { ::this.renderRides(history, receipts, channel) }
        </tbody>
      </table>
    )
  }

  previousWeekCaption() {
    const { weeks_ago } = this.props;

    if(weeks_ago) {
      return `загрузить за ${ weeks_ago + 1 } неделю назад`;
    }
    else {
      return "загрузить за 1 неделю назад";
    }
  }

  previousWeek() {
    const { channel, weeks_ago } = this.props;
    channel.push("history:load", { weeks_ago: weeks_ago + 1 })
  }

  renderRides(history, receipts, channel) {
    return history.map((request) => {
      return <Ride key={ request.request_id }
                   channel={ channel }
                   request={ request }
                   receipt={ receipts[request.request_id] }/>
    });
  }
}
