#! /usr/bin/bash

# used by test 1.7.4 (made global for possible use of other scripts)
LOCK_DELAY_THRESH=5 # lock delay should be LEQ than this (in seconds). edit as necessary
IDLE_DELAY_THRESH=900 # idle delay should be LEQ than this (in seconds). edit as necessary

# used for Section 2.3
TIME_SYNCH=""

# used for section 5.3
SET_MINPW_LENGTH=14 # minimum password length

# used for section 5.4
SET_PASS_MAX_DAYS=365 # The maximum number of days a password may be used
SET_PASS_MIN_DAYS=1 # The minimum number of days a password expires
SET_WARN_AGE=7 # The number of days a warning is given before a password expires
SET_HASHING_ALGO="YESCRYPT" # Password hashing algorithm to be used
SET_INACTIVEPW_LOCK=45 # number of days after the password exceeded its maximum age where the user is expected to replace this password