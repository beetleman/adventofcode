#!/usr/bin/env bash
sbcl --eval "(asdf:load-system :aoc-2025)" \
     --eval "(setf cl-user::*exit-on-test-failures* t)" \
     --eval "(aoc-2025:main)" \
     --quit
