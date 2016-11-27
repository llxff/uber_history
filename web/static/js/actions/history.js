import Constants from "../constants";

const Actions = {
  loadHistory(weeks_ago, channel) {
    return dispatch => {
      dispatch({ type: Constants.HISTORY_LOADING });
      channel.push("history:load", { weeks_ago: weeks_ago + 1 })
    }
  },

  loadRequests(history, channel) {
    return dispatch => {
      history.forEach(function(request) {
        channel.push("receipt:load", { request_id: request.request_id });
      });
    }
  }
};

export default Actions;
