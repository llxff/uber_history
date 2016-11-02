import { combineReducers } from 'redux';
import { routerReducer }   from 'react-router-redux';
import session             from './session';
import history             from './history';

export default combineReducers({
  routing: routerReducer,
  session: session,
  history: history
});
