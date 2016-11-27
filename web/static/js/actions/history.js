const Actions = {
  loadRequests(history, channel) {
    return dispatch => {
      history.forEach(function(request) {
        channel.push("receipt:load", { request_id: request.request_id });
      });
    }
  }
};

export default Actions;
