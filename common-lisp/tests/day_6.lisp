(defpackage beetleman.aoc-2023/tests/day-6
  (:use :cl
        :beetleman.aoc-2023.day-6
        :rove)
  (:export :records))
(in-package :beetleman.aoc-2023/tests/day-6)

;; NOTE: To run this test file, execute `(asdf:test-system :beetleman.aoc-2023)' in your Lisp.

(defvar records
  "Time:      7  15   30
Distance:  9  40  200")

(deftest solve-test
  (testing "Day 6: Wait For It"
    (ok (= 288
	   (solve records)))))
