import Constants from '../constants';

const initialState = {
  currentUser: null,
  socket: null,
  channel: null,
  history: { count: 0, history: [] }
};

export default function reducer(state = initialState, action = {}) {
  switch (action.type) {
    case Constants.CURRENT_USER:
      return { ...state, currentUser: action.currentUser, error: null };

    case Constants.SOCKET_CONNECTED:
      return { ...state, socket: action.socket, channel: action.channel, history: action.history };

    default:
      return state;
  }
}
