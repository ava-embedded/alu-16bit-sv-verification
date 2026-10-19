#!/usr/bin/env bash

export GIT_ROOT=$(git rev-parse --show-toplevel)
export UVM_ROOT="$GIT_ROOT/verification/uvm"
export UVM_WORK="$GIT_ROOT/work/uvm"
