#!/usr/bin/bash
source utils.sh

{
    echo "Ensure pam_unix module is enabled (5.3.2.1)..."

    audit_result=true

    common_files=(
        "/etc/pam.d/common-account"
        "/etc/pam.d/common-session"
        "/etc/pam.d/common-auth"
        "/etc/pam.d/common-password"
    )

    for file in "${common_files[@]}"; do
        if ! grep -P -- '\bpam_unix\.so\b' "$file" &> /dev/null; then
            echo "FAIL: pam_unix.so is not enabled in $file"
            audit_result=false
        fi
    done

    if $audit_result; then
        echo "Audit Result: PASS"
    else
        echo "Audit Result: FAIL"
        runFix "5.3.2.1" fixes/chap5/chap5_3/chap5_3_2/5_3_2_1.sh
    fi
}
