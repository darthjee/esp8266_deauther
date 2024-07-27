#!/bin/bash
COMMAND=$1

function help() {
  echo "Helper to generate font arrays"
  echo ""
  echo "Usage: $0 read [filename]"
}

if [ ! $COMMAND ]; then
  COMMAND="help"
fi

case $ACTION in
  "read")
  docker-compose run font_helper -c "echo aaa"
    ;;
  "help")
  *)
    help
    ;;
esac
