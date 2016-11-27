import Constants from '../constants';

const initialState = {
  socket: null,
  channel: null,
  history: [],
  receipts: {},
  spent_amount: {},
  weeks_ago: 0,
  receipts_loading: true,
  history_loading: true
};

export default function reducer(state = initialState, action = {}) {
  switch (action.type) {
    case Constants.SOCKET_CONNECTED:
      return {
        ...state,
        socket: action.socket,
        channel: action.channel,
        history: action.history,
        weeks_ago: action.weeks_ago,
        history_loading: false
      };

    case Constants.HISTORY_LOADING:
      return {
        ...state,
        history_loading: true,
        receipts_loading: true
      };

    case Constants.RECEIPT_LOADED:
      const receipt =  action.receipt;
      const spent_amount = state.spent_amount[receipt.currency_code] || 0;

      state.spent_amount[receipt.currency_code] = spent_amount + receipt.total_charged_amount;
      state.receipts[action.request_id] = receipt;
      state.receipts_loading = state.history.length != Object.keys(state.receipts).length;

      return {
        ...state,
        spent_amount: Object.assign({}, state.spent_amount),
        receipts: Object.assign({}, state.receipts)
      };

    case Constants.HISTORY_LOADED:
      return {
        ...state,
        history: action.history,
        weeks_ago: action.weeks_ago,
        receipts: {},
        spent_amount: {},
        history_loading: false,
        receipts_loading: true
      };

    default:
      return state;
  }
}
