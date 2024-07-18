#! /usr/bin/bash
source utils.sh
# 6.3.3.1 [REMEDIATION] Ensure changes to system administration scope (sudoers) is collected

{
    echo "[REMEDIATION] Ensuring changes to system administration scope (sudoers) is collected (6.3.3.1)..."

    rules=(
        "-w /etc/sudoers -p wa -k scope"
        "-w /etc/sudoers.d -p wa -k scope"
    )
    newRule /etc/audit/rules.d/50-scope.rules "${rules[@]}"

    echo "Changes to system administration scope (sudoers) is now collected."
}