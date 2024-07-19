#!/bin/bash

{
    # Run the command and capture its output
    output=$(sshd -T | grep -Pi -- '^\h*(allow|deny)(users|groups)\h+\H+')

    # Define the patterns to match
    pattern_allowusers="^allowusers\s+\H+"
    pattern_allowgroups="^allowgroups\s+\H+"
    pattern_denyusers="^denyusers\s+\H+"
    pattern_denygroups="^denygroups\s+\H+"

    # Check if the output matches any of the patterns
    if echo "$output" | grep -Pq "$pattern_allowusers" || \
    echo "$output" | grep -Pq "$pattern_allowgroups" || \
    echo "$output" | grep -Pq "$pattern_denyusers" || \
    echo "$output" | grep -Pq "$pattern_denygroups"; then
        echo "Audit Result: Pass"
    else
        echo "Audit Result: Fail"
        echo "5.1.4 Configure specific users/groups for sshd access"
    fi

}