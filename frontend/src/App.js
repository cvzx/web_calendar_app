import React, { Component } from "react";
import "./App.css";
import Calendar from "./components/Calendar";
import Login from "./components/Login";
import FlatButton from 'material-ui/FlatButton';

class App extends Component {
  state = {
    username: localStorage.getItem('username'),
    token: localStorage.getItem('token')
  }

  handleLogin = ({username, token}) => {
    localStorage.setItem('username', username);
    localStorage.setItem('token', token);

    this.setState({username: username, token: token })
  }

  handleLogout = () => {
    localStorage.removeItem('username');
    localStorage.removeItem('token');

    this.setState({username: null, token: null })
  }

  render() {
    const { username, token } = this.state;

    return (
      <div className="App">
        { token === null ? (
          <Login onLogin={this.handleLogin} />
        ) : (
          <div>
            <div>
              {username}
              <FlatButton label="Logout"
                primary={true}
                onClick={()=> { this.handleLogout() }} />
            </div>
            <Calendar />
          </div>
        )}
      </div>
    );
  }
}

export default App;
