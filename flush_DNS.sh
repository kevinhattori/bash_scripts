#!/bin/bash

sudo killall -HUP mDNSResponder

if [ $? -eq 0 ]
then
  echo "DNS Flushed Successfully"
else
  echo "Something went wrong" >&2
fi

