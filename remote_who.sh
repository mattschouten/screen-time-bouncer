#!/usr/bin/env bash

set -euo pipefail

ssh 172.16.1.110 <<EOF
    who
EOF

# Future:  Suppress my login and make a list of logged in users that can be fed elsewhere.
