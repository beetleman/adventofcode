(ns beetleman.aoc-2023.day-6-test
  (:require [beetleman.aoc-2023.day-6 :as sut]
            [clojure.test :as t]))

(def records
  "Time:      7  15   30
Distance:  9  40  200")

(t/deftest solve-test
  (t/testing "Day 6: Wait For It"
    (t/is (= 288
             (sut/solve records)))))
