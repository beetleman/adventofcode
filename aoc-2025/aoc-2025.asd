;;; aoc-2025.asd
;;;
;;; SPDX-License-Identifier: MIT
;;;
;;; Copyright (C) 2025 Mateusz Jeżowski

(asdf:defsystem #:aoc-2025
  :description "A basic application."
  :author      "Mateusz Jeżowski"
  :license     "MIT"
  :version     "0.1.0"
  :depends-on  (:str
                :cl-ppcre
                :fset
                :trivia
                :transducers
                :transducers/fset
                :alexandria
                :serapeum
                :uiop
                :trivia
                :parachute)
  :serial t
  :components ((:file "src/package")
               (:file "src/day-1")
               (:file "src/day-2")
               (:file "src/main")))
