#! /usr/bin/bash

function runTests() {
    local FILES=("$@") # store all file paths in array
    for FILE in "${FILES[@]}"
        do
            chmod +x "$FILE"  # ensure the file is executable
            if [ -x "$FILE" ]; then
                ./"$FILE"  # execute file
            else
                echo "Error: $FILE is not executable or does not exist."
            fi
    done
}

function check_gdm_installed() {
    if command -v dpkg-query &>/dev/null; then
        dpkg-query -l | grep -q gdm
    elif command -v rpm &>/dev/null; then
        rpm -qa | grep -q gdm
    else
        echo "Unsupported package manager."
        return 1
    fi
}

function runFix() {
    test_number=$1
    fix_filepath=$2

    read -p "Run remediation script for Test $test_number? (Y/N): " ANSWER
        case "$ANSWER" in
            [Yy]*)
                echo "Commencing remediation for Test $test_number..."
                
                FIXES_SCRIPT="$(realpath $fix_filepath)"
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

function check() { # For 6.3.3 tests, check if output matches expected output
    output=$1
    shift
    expected=("$@")
    matches="true"

    for line in "${expected[@]}"; do
      if ! echo "$output" | grep -qF "$line"; then
        matches="false"
        break
      fi
    done

    echo "$matches"
}

function newRule() { # For 6.3.3 remediation scripts, add new audit rules
    file=$1
    shift
    rules=("$@")

    if [ -f "$file" ]; then # Append rules to file if it exists
        printf '%s\n' "${rules[@]}" >> "$file"
    else # Create file and add rules if it does not exist
        printf '%s\n' "${rules[@]}" > "$file"
    fi

    augenrules --load
    
    if [[ $(auditctl -s | grep "enabled") =~ "2" ]]; then 
        printf "Reboot required to load rules\n"; 
    fi
}

file_umask_chk() { # for 5.4.3.3
        if grep -Psiq -- '^\h*umask\h+(0?[0-7][2-7]7|u(=[rwx]{0,3}),g=([rx]{0,2}),o=)(\h*#.*)?$' "$l_file"; then 
            l_out="$l_out\n - umask is set correctly in \"$l_file\"" 
        elif grep -Psiq -- '^\h*umask\h+(([0-7][0-7][01][0-7]\b|[0-7][0-7][0-7][0-6]\b)|([0-7][01][0-7]\b|[0-7][0-7][0-6]\b)|(u=[rwx]{1,3},)?(((g=[rx]?[rx]?w[rx]?[rx]?\b)(,o=[rwx]{1,3})?)|((g=[wrx]{1,3},)?o=[wrx]{1,3}\b)))' "$l_file"; then 
            l_output2="$l_output2\n   - \"$l_file\"" 
        fi 
    } 