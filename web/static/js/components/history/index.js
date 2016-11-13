import React    from "react";
import Ride     from "./ride";

export default class History extends React.Component {
  render() {
    const history = this.props.history;
    const { channel, receipts } = this.props;

    if(!history.length) { return false }

    return (
      <table className="table table-striped">
        <caption>{ history.length } поездок за эту неделю</caption>
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

  renderRides(history, receipts, channel) {
    return history.map((request) => {
      return <Ride key={ request.request_id }
                   channel={ channel }
                   request={ request }
                   receipt={ receipts[request.request_id] }/>
    });
  }
}
