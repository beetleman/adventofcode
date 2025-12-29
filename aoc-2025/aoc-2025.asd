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
                :fset/iterate
                :trivia
                :transducers
                :transducers/fset
                :alexandria
                :serapeum
                :uiop
                :trivia
                :trivia.fset
                :parachute
                :iterate)
  :serial t
  :components ((:file "src/package")
               (:file "src/day-01")
               (:file "src/day-02")
               (:file "src/day-03")
               (:file "src/day-04")
               (:file "src/day-05")
               (:file "src/day-06")
               (:file "src/day-07")
               (:file "src/day-08")
               (:file "src/day-09")
               (:file "src/day-10")
               (:file "src/day-11")
               (:file "src/main")))
