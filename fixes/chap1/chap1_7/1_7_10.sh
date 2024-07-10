#!/usr/bin/bash

{
    echo "[REMEDIATION] Ensuring XDMCP is not enabled..."

    while IFS= read -r l_file; do
        if grep -Pq '^\h*\[xdmcp\]' "$l_file"; then
            echo "Processing file: $l_file"
            # Comment out or remove the Enable=true line in the [xdmcp] block
            sed -i '/\[xdmcp\]/,/\[/{/Enable=true/s/^/#/}' "$l_file"
        fi
    done < <(grep -Psil -- '^\h*\[xdmcp\]' /etc/{gdm3,gdm}/{custom,daemon}.conf)

    echo "Remediation completed. XDMCP is now disabled."
}
