#!/bin/bash
MOUSE_ID="$(xinput list | grep Mouse | awk '{ print $6 }' | sed -n -e 's/id=//p')"
TOUCHPAD_ID="$(xinput list | grep TouchPad | awk '{ print $6 }' | sed -n -e 's/id=//p')"

echo "$MOUSE_ID"
echo "$TOUCHPAD_ID"

xinput disable $MOUSE_ID
xinput disable $TOUCHPAD_ID
