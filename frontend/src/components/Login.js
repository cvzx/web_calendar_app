import React, { Component } from 'react';
import axios from 'axios';
import TextField from 'material-ui/TextField';
import FlatButton from 'material-ui/FlatButton';

const BACKEND_API_URL = "http://localhost:3000"

class Login extends Component {
  state = {
    username: '',
    password: ''
  };

  handleSubmit = async (event) => {
    event.preventDefault();

    const { username, password } = this.state;

    try {
      const response = await axios.post(`${BACKEND_API_URL}/auth/login`, {
        username,
        password
      });
      const token = response.data.token;
      const { onLogin } = this.props;

      onLogin({username, token})
    } catch (error) {
      console.log(error);
    }
  };

  render() {
    return (
      <form onSubmit={this.handleSubmit}>
        <TextField
          floatingLabelText="Username"
          onChange={(event) => this.setState({ username: event.target.value })}
        />
        <TextField
          floatingLabelText="Password"
          type="password"
          onChange={(event) => this.setState({ password: event.target.value })}
        />
        <FlatButton label="Sign In"
          primary={true}
          onClick={(event)=> { this.handleSubmit(event) }} />
      </form>
    );
  }
}

export default Login;
