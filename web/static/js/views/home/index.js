import React        from 'react';
import History      from '../../components/history'
import Header       from '../../components/header'

export default class HomeIndexView extends React.Component {
  render() {
    return (
      <div>
        <Header />
        <div className="vertical-center">
          <div className="container-fluid">
            <History />
          </div>
        </div>
      </div>
    );
  }
}
