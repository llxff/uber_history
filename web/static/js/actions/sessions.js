import { routerActions } from "react-router-redux";
import Constants         from "../constants";
import { httpGet }       from "../utils";
import { Socket }        from "phoenix";

const Actions = {
  currentUser: () => {
    return dispatch => {
      httpGet("/api/v1/current_user")
      .then(function(data) {
        setCurrentUser(dispatch, data.user)
      })
      .catch(function(error) {
        console.log(error);
        dispatch(routerActions.push("/sign_in"))
      });
    };
  }
}

function setCurrentUser(dispatch, user) {
  dispatch({
    type: Constants.CURRENT_USER,
    currentUser: user
  });

  initializeSocket(dispatch);
}

function initializeSocket(dispatch) {
  const socket = new Socket("/socket", {
    params: {
      token: localStorage.getItem("authToken")
    }
  });

  socket.connect();

  const channel = socket.channel("history");

  channel.join().receive("ok", (response) => {
    dispatch({
      type: Constants.SOCKET_CONNECTED,
      socket: socket,
      channel: channel,
      history: response.history
    })
  });

  channel.on("receipt:loaded", (msg) => {
    dispatch({
      type: Constants.RECEIPT_LOADED,
      receipt: msg.receipt,
      request_id: msg.request_id
    });
  });
}

export default Actions;
