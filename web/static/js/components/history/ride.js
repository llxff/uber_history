import React    from "react";
import { unix } from "moment";

export default class Ride extends React.Component {
  shouldComponentUpdate(nextProps) {
    return this.props.receipt != nextProps.receipt;
  }

  render() {
    const { request, receipt, channel } = this.props;

    let price = "...";

    if(!receipt) {
      channel.push("receipt:load", { request_id: request.request_id });
    }
    else {
      price = receipt.total_charged;
    }

    return (
      <tr>
        <td>{ request.distance }</td>
        <td>{ ::this.timestampDate(request.request_time) }</td>
        <td>{ ::this.timestampDate(request.start_time) }</td>
        <td>{ ::this.timestampDate(request.end_time) }</td>
        <td>{ price }</td>
      </tr>
    )
  }

  timestampDate(unix_timestamp) {
    return unix(unix_timestamp).format("DD.MM.YYYY HH:mm:ss");
  }
}
