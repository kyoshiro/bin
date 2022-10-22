#!/bin/sh
NEXTLINE=0
FIND=""
for I in `file /boot/vmlinuz*`; do
  if [ ${NEXTLINE} -eq 1 ]; then
    FIND="${I}"
    NEXTLINE=0
   else
    if [ "${I}" = "version" ]; then NEXTLINE=1; fi
  fi
done
if [ ! "${FIND}" = "" ]; then
  CURRENT_KERNEL=`uname -r`
  if [ ! "${CURRENT_KERNEL}" = "${FIND}" ]; then
    echo ""
    echo "Update Status: Recently updated the kernel. Boot required!"
  else
    echo ""
    echo "Update Status: Currently, no boot required."
  fi
fi
