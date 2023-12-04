(ns beetleman.aoc-2023.day-4
  (:require [clojure.set :as set]))

(defn parse-numbers-string [numbers-string]
  (into #{}
        (map parse-long)
        (re-seq #"\d+" numbers-string)))

(defn score [numbers wining-numbers]
  (if-let [intersection (seq (set/intersection numbers wining-numbers))]
    (->> intersection
         count
         dec
         (Math/pow 2)
         long)
    0))

(defn solve [cards-string]
  (transduce (map (fn [[_ wining-numbers-string numbers-string]]
                    (score (parse-numbers-string numbers-string)
                           (parse-numbers-string wining-numbers-string))))
             +
             (re-seq #"Card \d+: ([\d ]+)\|([\d ]+)" cards-string)))
