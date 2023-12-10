(defpackage beetleman.aoc-2023/tests/day-9
  (:use :cl
        :beetleman.aoc-2023.day-9
	:beetleman.aoc-2023/tests/io
        :rove))
(in-package :beetleman.aoc-2023/tests/day-9)

;; NOTE: To run this test file, execute `(asdf:test-system :beetleman.aoc-2023)' in your Lisp.

(defvar sensors-data
  "0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45")

(deftest solve-test
  (testing "Day 9: Mirage Maintenance"
    (ok (= 114
	   (solve sensors-data)))
    (ok (= 2174807968
     	   (solve (read-file "tests/day_9_input.txt"))))))
