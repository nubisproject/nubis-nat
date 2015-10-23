# Variables
eval $(curl -s -fq http://169.254.169.254/latest/user-data)
REGION=$(curl -s -fq http://169.254.169.254/latest/dynamic/instance-identity/document | jq '.region' -r)
INSTANCE_ID=$(curl -s -fq http://169.254.169.254/latest/meta-data/instance-id)

# Simple logging function
function log() {

    local LOGGER_BIN='/usr/bin/logger'
    local LOGMSG=$1

    [ -z "$LOGMSG" ] && { echo "Usage: $FUNCNAME [log message]"; exit 1; }

    # Set up the logger command if the binary is installed
    if [ ! -x $LOGGER_BIN ]; then
        # If logger is not installed just stderr it out
        echo "$LOGMSG"
    else
        $LOGGER_BIN --stderr --priority local7.info --tag 'nubis-startup' "$LOGMSG"
    fi
}

function die {
    [ -n "$1" ] && log "$1"
    log "Configuration of HA NAT failed!"
    exit 1
}
