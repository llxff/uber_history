import React from "react";
import { unix } from "moment";

export default class History extends React.Component {
  render() {
    const { history } = this.props.history;

    if(!history.length) { return false }

    return (
      <table className="table table-striped">
        <thead>
          <tr>
            <th>Дистанция</th>
            <th>Время заказа</th>
            <th>Начало поездки</th>
            <th>Завершение поездки</th>
          </tr>
        </thead>
        <tbody>
          { ::this.renderRides(history) }
        </tbody>
      </table>
    )
  }

  renderRides(rides) {
    return rides.map((ride) => {
      return (
        <tr key={ ride.request_id }>
          <td>{ ride.distance }</td>
          <td>{ ::this.timestampDate(ride.request_time) }</td>
          <td>{ ::this.timestampDate(ride.start_time) }</td>
          <td>{ ::this.timestampDate(ride.end_time) }</td>
        </tr>
      )
    });
  }

  timestampDate(unix_timestamp) {
    return unix(unix_timestamp).format("DD.MM.YYYY HH:mm:ss");
  }
}
