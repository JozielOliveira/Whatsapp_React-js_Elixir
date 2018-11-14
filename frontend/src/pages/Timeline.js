import React, { Component } from 'react';
import { Socket } from '../helpers/Socket';

import PropTypes from 'prop-types';
import classNames from 'classnames';
import { withStyles } from '@material-ui/core/styles';
import Paper from '@material-ui/core/Paper';
import Tooltip from '@material-ui/core/Tooltip';
import Send from '@material-ui/icons/Send';
import IconButton from '@material-ui/core/IconButton';
import Toolbar from '@material-ui/core/Toolbar';
import Typography from '@material-ui/core/Typography';
import AppBar from '@material-ui/core/AppBar';
import styles from './chatStyle-jss';
import './emoji-picker-react.css';

import api from '../services/api';

import Tweet from '../components/Tweet';

import './Timeline.css';

class pages extends Component {
    constructor(props) {
        super(props);
        this.channel = null;
        this.socket = null;
    }
  state = {
      newTwitt : '',
      tweets: []
  }

  scrollComponent = () => {
    document.getElementById('roomContainer').scrollTo(0, document.getElementById('roomContainer').scrollHeight)
  }

  componentDidMount = async() =>{
    
    this.subscribeToEvents();

    const tweets =  await api.get('mensagem')
    this.setState({ tweets : tweets.data.data})
    
    this.scrollComponent()
  }

  handleInput = event => {
    this.setState({ newTwitt : event.target.value})
  }

  handleSubmit = async event => {
    event.preventDefault();
    const msg = {'author': localStorage.getItem('user'), 'description': this.state.newTwitt, 'id': this.state.tweets.length+1}
    await api.post('mensagem', {'msg': msg});
    this.channel.push("shout",msg)
    this.setState({ newTwitt : '' })
  }

  subscribeToEvents = () => {
      this.socket = new Socket('ws://192.168.0.5:4000/socket', {});
      this.socket.connect();

      this.channel = this.socket.channel("mensagen:lobby",{}, {});
      this.channel.join()

      this.channel.on('shout', data => {  
          this.setState({ tweets : [...this.state.tweets, data ] })
          this.scrollComponent()  
      } )
}

  render() {
    const {
        classes
      } = this.props;
    return (
        <div>
            <AppBar
                position="absolute"
                className={classNames(classes.appBar, classes.appBarShift)}
                style={{background: '#1F877E', position: 'fixed'}}
            >
                <Toolbar>
                <Typography variant="title" color="inherit" noWrap>
                    Whatsapp
                </Typography>
                
                </Toolbar>
            </AppBar>
            <div className={classNames(classes.root)}>
                <ul className={classes.chatList} id="roomContainer">
                    {this.state.tweets.map(tweet => <Tweet key={tweet.id} tweet={tweet} />)}
                    <li style={{paddingBottom: '55px'}}>
                    </li>
                </ul>
                <form onSubmit={this.handleSubmit}>
                <Paper className={classes.writeMessage}>
                    
                    <div className='emoji-text-field picker-hidden emoji-input'>
                        <input onChange={this.handleInput} type="text" placeholder="Digite a mensagem"  value={this.state.newTwitt} />
                    </div>
                    
                    <Tooltip id="tooltip-send" title="Send">
                    <div>
                        <IconButton mini="true" color="secondary" disabled={this.state.newTwitt === ''} onClick={this.handleSubmit} aria-label="send" className={classes.sendBtn}>
                        <Send />
                        </IconButton>
                    </div>
                    </Tooltip>
                </Paper>
                </form>
            </div>
        </div>
    );
  }
}

pages.propTypes = {
    classes: PropTypes.object.isRequired,
  };

  
export default withStyles(styles)(pages);