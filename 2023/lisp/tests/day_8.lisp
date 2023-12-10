(defpackage beetleman.aoc-2023/tests/day-8
  (:use :cl
        :beetleman.aoc-2023.day-8
        :rove)
  (:export :camel-cards))
(in-package :beetleman.aoc-2023/tests/day-8)

;; NOTE: To run this test file, execute `(asdf:test-system :beetleman.aoc-2023)' in your Lisp.

(defvar network
  "LLR

AAA = (BBB, BBB)
BBB = (AAA, ZZZ)
ZZZ = (ZZZ, ZZZ)")

(deftest solve-test
  (testing "Day 8: Haunted Wasteland"
    (ok (= 6
	   (solve network)))
    (ok (= 13939
     	   (solve (alexandria:read-file-into-string #P"tests/day_8_input.txt"))))))
