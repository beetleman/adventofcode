(defpackage beetleman.aoc-2023/tests/day-1
  (:use :cl
        :beetleman.aoc-2023.day-1
        :beetleman.aoc-2023/tests/io
        :rove))
(in-package :beetleman.aoc-2023/tests/day-1)

;; NOTE: To run this test file, execute `(asdf:test-system :beetleman.aoc-2023)' in your Lisp.

(defvar calibration-document
  "1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet")

(deftest solve-test
  (testing "Day 1: Trebuchet?!"
    (testing "part-1"
      (ok (= 142 (solve calibration-document)))
      (ok (= 55002 (solve (read-file "tests/day_1_input_part_1.txt")))))))
