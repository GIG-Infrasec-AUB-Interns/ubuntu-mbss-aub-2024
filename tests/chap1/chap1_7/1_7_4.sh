#!/usr/bin/bash
source utils.sh
source globals.sh

{
    echo "Ensuring GDM screen locks when the user is idle (1.7.4)..."

    lock_delay_output=$(gsettings get org.gnome.desktop.screensaver lock-delay)
    idle_delay_output=$(gsettings get org.gnome.desktop.session idle-delay)

    if [[ -z $lock_delay_output ]] || [[ -z $idle_delay_output ]]; then
        echo "Audit Result: FAIL"
        runFix "1.7.4" fixes/chap1/chap1_7/1_7_4.sh

    else
        # extract the delays from the output of lock_delay_output and idle_delay_output
        lock_delay=$(echo $lock_delay_output | sed 's/[^0-9]*//g')
        idle_delay=$(echo $idle_delay_output | sed 's/[^0-9]*//g')

        if [[$lock_delay > $LOCK_DELAY_THRESH]] || [[$idle_delay > $IDLE_DELAY_THRESH]]; then
            echo "Audit Result: FAIL"
            runFix "1.7.4" fixes/chap1/chap1_7/1_7_4.sh
        else
            echo "Audit Result: PASS"
        fi

    fi
}