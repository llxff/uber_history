import React from "react";

export default class LogoutButton extends React.Component {
  render() {
    const csrfToken = localStorage.getItem("csrfToken");

    return (
      <form action="/auth/logout" className="link" method="post">
        <input name="_method" type="hidden" value="delete" />
        <input name="_csrf_token" type="hidden" value={ csrfToken } />
        <button className="btn btn-danger btn-xs">Log out</button>
      </form>
    );
  }
}
