(defpackage beetleman.aoc-2023/tests/io
  (:use :cl)
  (:export :read-file))
(in-package :beetleman.aoc-2023/tests/io)

(defun read-file (path-in-project)
  (uiop:read-file-string
   (asdf:system-relative-pathname "beetleman.aoc-2023/tests" path-in-project)))
