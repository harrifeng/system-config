#!/usr/bin/env bash
of "$(readlink -f "$(cygpath -au "$HOMEDRIVE$HOMEPATH\My Documents")")"
