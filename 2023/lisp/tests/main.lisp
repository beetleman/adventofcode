(defpackage beetleman.aoc-2023/tests/main
  (:use :cl
        :beetleman.aoc-2023
        :rove))
(in-package :beetleman.aoc-2023/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :beetleman.aoc-2023)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
