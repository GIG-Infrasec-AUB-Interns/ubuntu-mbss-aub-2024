#!/usr/bin/bash

function runFix() {
    read -p "Run remediation script for Test 1.7.4? (Y/N): " ANSWER
        case "$ANSWER" in
            [Yy]*)
                echo "Commencing remediation for Test 1.7.4..."
                
                FIXES_SCRIPT="$(realpath fixes/chap1/chap1_7/1_7_4.sh)"
                if [ -f "$FIXES_SCRIPT" ]; then
                    chmod +x "$FIXES_SCRIPT"
                    "$FIXES_SCRIPT"
                else
                    echo "Error: $FIXES_SCRIPT is not found."
                fi
                echo "For more information, please visit https://downloads.cisecurity.org/#/"
                ;;
            *)
                echo "Remediation not commenced"
                echo "For more information, please visit https://downloads.cisecurity.org/#/"
                ;;
        esac
}

{
    echo "Ensuring GDM screen locks when the user is idle (1.7.4)..."

    lock_delay_output=$(gsettings get org.gnome.desktop.screensaver lock-delay)
    idle_delay_output=$(gsettings get org.gnome.desktop.session idle-delay)

    LOCK_DELAY_THRESH=5 # lock delay should be LEQ than this (in seconds). edit as necessary
    IDLE_DELAY_THRESH=900 # idle delay should be LEQ than this (in seconds). edit as necessary

    if [[ -z $lock_delay_output ]] || [[ -z $idle_delay_output ]]; then
        echo "Audit Result: FAIL"
        runFix
    else
        # extract the delays from the output of lock_delay_output and idle_delay_output
        lock_delay=$(echo $lock_delay_output | sed 's/[^0-9]*//g')
        idle_delay=$(echo $idle_delay_output | sed 's/[^0-9]*//g')

        if [[$lock_delay > $LOCK_DELAY_THRESH]] || [[$idle_delay > $IDLE_DELAY_THRESH]]; then
            echo "Audit Result: FAIL"
            runFix
        else
            echo "Audit Result: PASS"
        fi

    fi
}