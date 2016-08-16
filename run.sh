#!/bin/bash
set -euo pipefail

mkdir -p /locust
cd /locust

if [ -z "${LOAD_TEST_URL-}" ]; then
    echo "LOAD_TEST_URL env var not set"
    exit 1
fi

if [ -n "${LOCUST_FILE-}" ]; then
    if [[ "$LOCUST_FILE" == http* ]]; then
        echo "Downloading $LOCUST_FILE"
        if [[ "$LOCUST_FILE" == *tar.gz ]]; then
            curl -s -o /tmp/locustfile.tar.gz "$LOCUST_FILE"
            tar xzvf /tmp/locustfile.tar.gz -C /locust/
        else
            curl -s -o /locust/locustfile.py "$LOCUST_FILE"
        fi
    fi
fi

ARGS=( --locustfile=/locust/locustfile.py "--host=${LOAD_TEST_URL-}" )

if [ -n "${LOCUST_MODE-}" ]; then
    case "$LOCUST_MODE" in
        master)
            ARGS+=( --master )
        ;;
        slave)
            ARGS+=( --slave --master-host=${LOCUST_MASTER:-127.0.0.1} --master-port=${LOCUST_MASTER_PORT:-5557} )
        ;;
        *)
            echo "Unknown mode $LOCUST_MODE"
            exit 1
    esac
fi

exec /usr/bin/locust "${ARGS[@]}" "$@"
