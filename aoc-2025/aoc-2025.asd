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
                :parachute
                :for
                :iterate)
  :serial t
  :components ((:file "src/package")
               (:file "src/day-1")
               (:file "src/day-2")
               (:file "src/day-3")
               (:file "src/day-4")
               (:file "src/day-5")
               (:file "src/day-6")
               (:file "src/day-7")
               (:file "src/day-8")
               (:file "src/main")))
