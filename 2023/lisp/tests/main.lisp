(defpackage beetleman.aoc-2023/tests/main
  (:use :cl
        :beetleman.aoc-2023
        :rove))
(in-package :beetleman.aoc-2023/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :beetleman.aoc-2023)' in your Lisp.

(defvar calibration-document
  "1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet")

(deftest test-target-1
  (testing "calibration book should be solved"
    (ok (= 142 (solve calibration-document)))))
