import React, { Component } from 'react';

import PropTypes from 'prop-types';
import { withStyles } from '@material-ui/core/styles';
import styles from '../pages/chatStyle-jss';
import './Tweet.css';
import api from '../services/api';

class Tweet extends Component {

  handleLike = async e => {
      const { tweet } = this.props;

      api.post(`like/${tweet._id}`)
  }

  render() {
    const { tweet, classes } = this.props;
    return (
        <li className={ localStorage.getItem('user') !== tweet.author ? classes.from : classes.to}>
          { localStorage.getItem('user') !== tweet.author && <strong className={classes.strong}>{tweet.author}</strong>}
          <div className={classes.talk}>
            <p><span className={ localStorage.getItem('user') !== tweet.author ? classes.spanFrom : classes.spanTo}
              style={ localStorage.getItem('user') !== tweet.author && tweet.author.length > tweet.description.length ?  {paddingRight: `${tweet.author.length*7.5}px`} : {paddingRight: `${tweet.author.length}px`} }
            > {tweet.description} </span></p>
          </div>
        </li>
    );
  }
}

Tweet.propTypes = {
    classes: PropTypes.object.isRequired,
    tweet: PropTypes.object
  };

  
export default withStyles(styles)(Tweet);