(defpackage beetleman.aoc-2023/tests/day-1
  (:use :cl
        :beetleman.aoc-2023.day-1
        :beetleman.aoc-2023/tests/io
        :rove))
(in-package :beetleman.aoc-2023/tests/day-1)

;; NOTE: To run this test file, execute `(asdf:test-system :beetleman.aoc-2023)' in your Lisp.

(defvar calibration-document-1
  "1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet")

(defvar calibration-document-2
  "two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen")

(deftest solve-test
  (testing "Day 1: Trebuchet?!"
    (testing "part-1"
      (ok (= 142 (solve-1 calibration-document-1)))
      (ok (= 55002 (solve-1 (read-file "tests/day_1_input_part_1.txt")))))
    (testing "part-2"
      (ok (= 142 (solve-2 calibration-document-1)))
      (ok (= 281 (solve-2 calibration-document-2)))
      (ok (= 0 (solve-2 (read-file "tests/day_1_input_part_2.txt")))))))
