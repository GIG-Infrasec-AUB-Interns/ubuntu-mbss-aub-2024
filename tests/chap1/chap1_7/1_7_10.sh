#!/usr/bin/bash

{
    echo "Ensuring XDCMP is not enabled (1.7.10)..."

    result=$(grep -Psil -- '^\h*\[xdmcp\]' /etc/{gdm3,gdm}/{custom,daemon}.conf | while IFS= read -r l_file; do
        awk '/\[xdmcp\]/{ f = 1; next } /\[/{ f = 0 } f {if (/^\s*Enable\s*=\s*true/) print "The file: \"" $l_file "\" includes: \"" $0 "\" in the \"[xdmcp]\" block"}' "$l_file"
    done)

    if [[ -z "$result" ]]; then
        echo "Audit Result: PASS"
    else
        echo "$result"
        echo "Audit Result: FAIL"
    fi

    echo "Audit completed."
}
