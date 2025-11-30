#!/usr/bin/env bash
sbcl --eval "(asdf:load-system :aoc-2025)" \
     --eval "(aoc-2025:main)" \
     --quit
