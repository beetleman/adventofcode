(defpackage beetleman.aoc-2023/tests/day-8
  (:use :cl
        :beetleman.aoc-2023.day-8
        :beetleman.aoc-2023/tests/io
        :rove)
  (:export :camel-cards))
(in-package :beetleman.aoc-2023/tests/day-8)

;; NOTE: To run this test file, execute `(asdf:test-system :beetleman.aoc-2023)' in your Lisp.

(defvar network-1
  "LLR

AAA = (BBB, BBB)
BBB = (AAA, ZZZ)
ZZZ = (ZZZ, ZZZ)")

(defvar network-2
  "LR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11B, XXX)
22A = (22B, XXX)
22B = (22C, 22C)
22C = (22Z, 22Z)
22Z = (22B, 22B)
XXX = (XXX, XXX)")

(deftest solve-test
  (testing "Day 8: Haunted Wasteland"
    (testing "part-1"
      (ok (= 6
	     (solve-1 network-1)))
      (ok (= 13939
	     (solve-1 (read-file "tests/day_8_input_part_1.txt")))))
    (testing "part-2"
      (ok (= 6
	     (solve-2 network-2)))
      (ok (= 8906539031197
	     (solve-2 (read-file "tests/day_8_input_part_2.txt")))))))
