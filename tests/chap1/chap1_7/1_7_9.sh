#!/usr/bin/env bash
{
    echo "Ensuring GDM autorun-never is not overridden (1.7.9)..."

    # Check if GNOME Desktop Manager is installed. If package isn't installed, recommendation is Not Applicable\n
    # determine system's package manager
    l_pkgoutput=""
    if command -v dpkg-query &> /dev/null; then
        l_pq="dpkg-query -s"
    elif command -v rpm &> /dev/null; then
        l_pq="rpm -q"
    fi

    # Check if GDM is installed
    l_pcl="gdm gdm3" # Space separated list of packages to check
    for l_pn in $l_pcl; do
        $l_pq "$l_pn" &> /dev/null && l_pkgoutput="$l_pkgoutput\n - Package: \"$l_pn\" exists on the system\n - checking configuration"
    done

    # Search /etc/dconf/db/ for [org/gnome/desktop/media-handling] settings)
    l_desktop_media_handling=$(grep -Psir -- '^\h*\[org/gnome/desktop/media-handling\]' /etc/dconf/db/*)
    if [[ -n "$l_desktop_media_handling" ]]; then
        l_output="" l_output2=""
        l_autorun_setting=$(grep -Psir -- '^\h*autorun-never=true\b' /etc/dconf/db/local.d/*)
    
        # Check for auto-run setting
        if [[ -n "$l_autorun_setting" ]]; then
            l_output="$l_output\n - \"autorun-never\" setting found"
        else
            l_output2="$l_output2\n - \"autorun-never\" setting not found"
        fi 
    else
        l_output="$l_output\n - [org/gnome/desktop/media-handling] setting not found in /etc/dconf/db/*"
    fi 

    # Report results. If no failures output in l_output2, we pass
    
    [ -n "$l_pkgoutput" ] && echo -e "\n$l_pkgoutput"
    if [ -z "$l_output2" ]; then
        echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
    else
        echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
        [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"

        read -p "Run remediation script for Test 1.7.9? (Y/N): " ANSWER
        case $ANSWER in
            [Yy])
                echo "Commencing remediation for Test 1.7.9..."

                FIXES_SCRIPT="$(realpath fixes/chap1/chap1_7/1_7_9.sh)"
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
    fi
}
