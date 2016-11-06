import Constants from '../constants';

const initialState = {
  socket: null,
  channel: null,
  history: [],
  receipts: {}
};

export default function reducer(state = initialState, action = {}) {
  switch (action.type) {
    case Constants.SOCKET_CONNECTED:
      return { ...state, socket: action.socket, channel: action.channel, history: action.history };

    case Constants.RECEIPT_LOADED:
      return {
        ...state,
        receipts: Object.assign(
          {},
          state.receipts,
          { [action.request_id]: action.receipt }
        )
      };

    default:
      return state;
  }
}
