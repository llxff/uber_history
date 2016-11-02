import { routerActions } from 'react-router-redux';
import Constants         from '../constants';
import { Socket }        from 'phoenix';
import { httpGet, httpPost, httpDelete } from '../utils';

const Actions = {
  currentUser: () => {
    return dispatch => {
      httpGet('/api/v1/current_user')
      .then(function(data) {
        dispatch({
          type: Constants.CURRENT_USER,
          currentUser: data.user
        });
      })
      .catch(function(error) {
        console.log(error);
        dispatch(routerActions.push('/sign_in'))
      });
    };
  }
}

export default Actions;
