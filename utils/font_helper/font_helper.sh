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

shift 1

case $COMMAND in
  "dev")
    docker-compose run font_helper /bin/bash
    ;;
  "script")
    docker-compose run font_helper /bin/bash -c "ruby font_helper.rb script $*"
    ;;
  "help")
    help
    ;;
esac
