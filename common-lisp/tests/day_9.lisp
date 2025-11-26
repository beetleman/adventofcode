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
    (testing "part-1"
      (ok (= 114
	     (solve-1 sensors-data)))
      (ok (= 2174807968
	     (solve-1 (read-file "tests/day_9_input_part_1.txt")))))
    (testing "part-2"
      (ok (= 2
	     (solve-2 sensors-data)))
      (ok (= 1208
	     (solve-2 (read-file "tests/day_9_input_part_2.txt")))))))
