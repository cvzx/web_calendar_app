import React, { Component } from 'react';
import axios from 'axios';

class Login extends Component {
  state = {
    username: '',
    password: '',
    errorMessage: '',
  };

  handleSubmit = async (event) => {
    event.preventDefault();

    const { username, password } = this.state;

    try {
      const response = await axios.post('/auth/login', { username, password });
      const token = response.data.token;
      const { onLogin } = this.props;

      onLogin({username, token})
    } catch (error) {
      this.setState({ errorMessage: error });
    }
  };

  handleUsernameChange = (event) => {
    this.setState({ username: event.target.value });
  };

  handlePasswordChange = (event) => {
    this.setState({ password: event.target.value });
  };

  render() {
    const { username, password, errorMessage } = this.state;

    return (
      <form onSubmit={this.handleSubmit}>
        <div>
          <label htmlFor="username">Username:</label>
          <input
            type="text"
            id="username"
            value={username}
            onChange={this.handleUsernameChange}
          />
        </div>
        <div>
          <label htmlFor="password">Password:</label>
          <input
            type="password"
            id="password"
            value={password}
            onChange={this.handlePasswordChange}
          />
        </div>
        {errorMessage && <p style={{ color: 'red' }}>{errorMessage}</p>}
        <button type="submit">Login</button>
      </form>
    );
  }
}

export default Login;
