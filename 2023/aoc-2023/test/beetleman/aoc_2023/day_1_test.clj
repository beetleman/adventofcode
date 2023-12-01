(ns beetleman.aoc-2023.day-1-test
  (:require [beetleman.aoc-2023.day-1 :as sut]
            [clojure.test :as t]))

(def calibration-document
  "1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet")

(t/deftest solve-test
  (t/is (= 142
           (sut/solve calibration-document))))
