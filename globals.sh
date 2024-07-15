#! /usr/bin/bash

# used by test 1.7.4 (made global for possible use of other scripts)
LOCK_DELAY_THRESH=5 # lock delay should be LEQ than this (in seconds). edit as necessary
IDLE_DELAY_THRESH=900 # idle delay should be LEQ than this (in seconds). edit as necessary

# used for Section 2.3
TIME_SYNCH=""

# used for section 5.4
SET_PASS_MAX_DAYS=365 # The maximum number of days a password may be used
SET_PASS_MIN_DAYS=1
SET_WARN_AGE=7