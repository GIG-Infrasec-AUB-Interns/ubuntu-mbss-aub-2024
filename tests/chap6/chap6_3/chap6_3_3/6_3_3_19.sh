#! /usr/bin/bash
source utils.sh
# 6.3.3.19 Ensure kernel module loading unloading and modification is collected

{
  echo "Ensuring kernel module loading unloading and modification is collected (6.3.3.19)..."
  ondisk_expected_1=(
    "-a always,exit -F arch=b64 -S init_module,finit_module,delete_module -F auid>=1000 -F auid!=unset -k kernel_modules"
  )
  ondisk_expected_2=(
    "-a always,exit -F path=/usr/bin/kmod -F perm=x -F auid>=1000 -F auid!=unset -k kernel_modules"
  )
  running_expected_1=(
    "-a always,exit -F arch=b64 -S init_module,delete_module,finit_module -F auid>=1000 -F auid!=-1 -F key=kernel_modules"
  )
  running_expected_2=(
    "-a always,exit -S all -F path=/usr/bin/kmod -F perm=x -F auid>=1000 -F auid!=-1 -F key=kernel_modules"
  )

  echo "You can choose to run the audit for either the on disk OR the running configuration."
  read -p "Run the audit for the on disk configuration? (Y/N): " ANSWER
  case "$ANSWER" in
    [Yy]*)
      echo "Running the audit for the on disk configuration..."
      ondisk_output_1=$(awk '/^ *-a *always,exit/ &&/ -F *arch=b(32|64)/ &&(/ -F auid!=unset/||/ -F auid!=-1/||/ -F auid!=4294967295/) &&/ -S/ &&(/init_module/ ||/finit_module/ ||/delete_module/) &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules)
      UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
      ondisk_output_2=$([ -n "${UID_MIN}" ] && awk "/^ *-a *always,exit/ &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) &&/ -F *auid>=${UID_MIN}/ &&/ -F *perm=x/ &&/ -F *path=\/usr\/bin\/kmod/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules || printf "ERROR: Variable 'UID_MIN' is unset.\n")
      matches_1=$(check "$ondisk_output_1" "${ondisk_expected_1[@]}")
      matches_2=$(check "$ondisk_output_2" "${ondisk_expected_2[@]}")
      S_LINKS=$(ls -l /usr/sbin/lsmod /usr/sbin/rmmod /usr/sbin/insmod /usr/sbin/modinfo /usr/sbin/modprobe /usr/sbin/depmod | grep -vE " -> (\.\./)?bin/kmod" || true)
      s_links_output=$(if [[ "${S_LINKS}" != "" ]]; then echo "Issue with symlinks: ${S_LINKS}"; else echo "OK"; fi)

      if ([ "$matches_1" == "true" ] && [ "$matches_2" == "true" ] && [ "$s_links_output" == "OK" ]); then
        echo "On disk rules:"
        echo "$ondisk_output_1"
        echo "$ondisk_output_2"
        echo "Audit Result: PASS"
      else
        echo "On disk rules:"
        echo "$ondisk_output_1"
        echo "$ondisk_output_2"
        echo "Audit Result: FAIL"
        runFix "6.3.3.19" fixes/chap6/chap6_3/chap6_3_3/6_3_3_19.sh # Remediation
      fi
      ;;
    *)
      echo "Running the audit for the running configuration..."
      running_output_1=$(auditctl -l | awk '/^ *-a *always,exit/ &&/ -F *arch=b(32|64)/ &&(/ -F auid!=unset/||/ -F auid!=-1/||/ -F auid!=4294967295/) &&/ -S/ &&(/init_module/ ||/finit_module/ ||/delete_module/) &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)')
      UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
      running_output_2=$([ -n "${UID_MIN}" ] && auditctl -l | awk "/^ *-a *always,exit/ &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) &&/ -F *auid>=${UID_MIN}/ &&/ -F *perm=x/ &&/ -F *path=\/usr\/bin\/kmod/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" || printf "ERROR: Variable 'UID_MIN' is unset.\n")
      matches_1=$(check "$running_output_1" "${running_expected_1[@]}")
      matches_2=$(check "$running_output_2" "${running_expected_2[@]}")
      S_LINKS=$(ls -l /usr/sbin/lsmod /usr/sbin/rmmod /usr/sbin/insmod /usr/sbin/modinfo /usr/sbin/modprobe /usr/sbin/depmod | grep -vE " -> (\.\./)?bin/kmod" || true)
      s_links_output=$(if [[ "${S_LINKS}" != "" ]]; then echo "Issue with symlinks: ${S_LINKS}"; else echo "OK"; fi)

      if ([ "$matches_1" == "true" ] && [ "$matches_2" == "true" ] && [ "$s_links_output" == "OK" ]); then
        echo "Loaded rules:"
        echo "$running_output_1"
        echo "$running_output_2"
        echo "Audit Result: PASS"
      else
        echo "Loaded rules:"
        echo "$running_output_1"
        echo "$running_output_2"
        echo "Audit Result: FAIL"
        runFix "6.3.3.19" fixes/chap6/chap6_3/chap6_3_3/6_3_3_19.sh # Remediation
      fi
      ;;
  esac
}