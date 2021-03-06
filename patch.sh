#!/bin/bash

# Source env
if [ -f `dirname $0`/env ]; then
 . `dirname $0`/env
else
 echo "env file not found in `dirname $0`, run setup to create env file"
 echo "cd `dirname $0`;bash `dirname $0`/setup env"
 exit 1
fi

if [ "$O_VER" = "18c" ]; then
  echo "coming soon"
elif [ "$O_VER" = "12c" ]; then
  echo "coming soon"
elif [ "$O_VER" = "11.2" ]; then
  echo "coming soon"
elif [ "$O_VER" = "10.2" ]; then
  echo "coming soon"
elif [ "$O_VER" = "9.2" ]; then
  bash `dirname $0`/9.2/9208_patch_linux.sh
elif [ "$O_VER" = "8.1.7" ]; then
  echo "coming soon"
else
  echo "unknown version"
  exit 2;
fi
