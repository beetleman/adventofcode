;;; package.lisp
;;;
;;; SPDX-License-Identifier: MIT
;;;
;;; Copyright (C) 2025 Mateusz Jeżowski

(defpackage #:aoc-2025
  (:use #:cl #:alexandria #:serapeum)
  (:import-from #:str)
  (:import-from #:ppcre)
  (:import-from #:trivia #:match)
  (:local-nicknames (#:test #:parachute))
  (:export #:main))

(in-package #:aoc-2025)
