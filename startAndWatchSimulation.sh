#!/bin/bash

SIMULATIONS_DIRECTORY="/simulations"

log () {
    TIMESTAMP=$(date)
    echo "[$TIMESTAMP]: $1"
}

startApiSimulation() {
    log "Starting API simulation"
    /apisimulator/apisimulator-http-1.12/bin/apisimulator start $SIMULATIONS_DIRECTORY &
}

stopApiSimulation() {
    log "Stopping API simulation"
    /apisimulator/apisimulator-http-1.12/bin/apisimulator stop $SIMULATIONS_DIRECTORY
}

startApiSimulation

inotifywait -m -r -e modify,delete --exclude ".*\.log" "$SIMULATIONS_DIRECTORY" | while read DIR EVENT FILE; do
    case $EVENT in
        MODIFY*)
            log "File modified $DIR$FILE"
            stopApiSimulation
            startApiSimulation
            ;;
        DELETE*)
            log "File deleted $DIR$FILE"
            stopApiSimulation
            startApiSimulation
            ;;
        *)
            log "Unknown event for $DIR$FILE"
            ;;
    esac
done
