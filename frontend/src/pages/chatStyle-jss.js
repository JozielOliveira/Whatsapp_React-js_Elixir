const styles = theme => ({
  root: {
    flexGrow: 1,
    display: 'flex',
    flexDirection: 'column',
    position: 'relative',
  },
  strong: {
    position: 'absolute',
    zIndex: 1,
    marginTop: '15px',
    marginLeft: '15px',
  },
  chatList: {
    padding: 24,
    paddingTop: 110,
    overflow: 'auto',
    height: 580,
    '& li': {
      display: 'flex',
      position: 'relative',
      '& time': {
        position: 'absolute',
        top: -20,
        color: theme.palette.grey[500],
        fontSize: 11
      }
    },
  },
  detailPopup: {
    [theme.breakpoints.down('xs')]: {
      position: 'absolute',
      top: 0,
      left: 0,
      zIndex: 1200,
      width: '100%',
      overflow: 'auto',
      height: 575
    }
  },
  talk: {
    flex: 1,
    '& p': {
      marginBottom: 10,
      position: 'relative',
      '& span': {
        padding: 10,
        borderRadius: 10,
        display: 'inline-block'
      }
    }
  },
  avatar: {},
  from: {
    '& time': {
      left: 60,
    },
    '& $avatar': {
      marginRight: 20
    },
    '& $talk': {
      '& > p': {
        '& span': {
          background: '#fffcfc',
          border: `1px solid #fffcfc`,
        },
        '&:first-child': {
          '& span': {
            borderTopLeftRadius: 0,
          },
          '&:before': {
            content: '""',
            borderRight: `11px solid #fffcfc`,
            borderBottom: '17px solid transparent',
            position: 'absolute',
            left: -11,
            top: 0
          },
          '&:after': {
            content: '""',
            borderRight: `10px solid #fffcfc`,
            borderBottom: '15px solid transparent',
            position: 'absolute',
            left: -9,
            top: 1
          },
        }
      }
    }
  },
  to: {
    flexDirection: 'row-reverse',
    '& time': {
      right: 60,
    },
    '& $avatar': {
      marginLeft: 20
    },
    '& $talk': {
      textAlign: 'right',
      '& > p': {
        '& span': {
          textAlign: 'left',
          background: '#fffcfc',
          border: `1px solid #fffcfc`,
        },
        '&:first-child': {
          '& span': {
            borderTopRightRadius: 0,
          },
          '&:before': {
            content: '""',
            borderLeft: `11px solid #fffcfc`,
            borderBottom: '17px solid transparent',
            position: 'absolute',
            right: -11,
            top: 0
          },
          '&:after': {
            content: '""',
            borderLeft: `10px solid #fffcfc`,
            borderBottom: '15px solid transparent',
            position: 'absolute',
            right: -9,
            top: 1
          },
        }
      }
    }
  },
  messageBox: {
    border: 'none',
    padding: 0,
    outline: 'none',
    width: '100%',
    '&:after, &:before': {
      display: 'none'
    }
  },
  spanTo: {
    paddingLeft: '15px !important' ,  
    paddingTop: '15px !important'
  },
  spanFrom: {
    paddingLeft: '15px !important',  
    paddingTop: '45px !important'
  },
  writeMessage: {
    position: 'fixed',
    zIndex: 4,
    width: '95%',
    bottom: 16,
    display: 'flex',
    minHeight: 55,
    margin: '0 10px',
    alignItems: 'center',
    padding: '0 10px',
  }
  
});

export default styles;
