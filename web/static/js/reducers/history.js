import Constants from '../constants';

const initialState = {
  socket: null,
  channel: null,
  history: [],
  receipts: {},
  weeks_ago: 0
};

export default function reducer(state = initialState, action = {}) {
  switch (action.type) {
    case Constants.SOCKET_CONNECTED:
      return {
        ...state,
        socket: action.socket,
        channel: action.channel,
        history: action.history,
        weeks_ago: action.weeks_ago
      };

    case Constants.RECEIPT_LOADED:
      return {
        ...state,
        receipts: Object.assign(
          {},
          state.receipts,
          { [action.request_id]: action.receipt }
        )
      };

    case Constants.HISTORY_LOADED:
      return {
        ...state,
        history: action.history,
        weeks_ago: action.weeks_ago
      };

    default:
      return state;
  }
}
