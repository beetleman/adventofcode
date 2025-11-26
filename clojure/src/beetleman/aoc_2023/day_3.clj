(ns beetleman.aoc-2023.day-3
  (:require [clojure.string :as str]))

(defn engine-schematic-width [engine-schematic]
  (str/index-of engine-schematic \newline))

(defn re-find-indexies [re s]
  (let [m (re-matcher re s)]
    (loop [acc (transient [])]
      (if (.find m)
        (recur (conj! acc {:start (.start m)
                           :end   (.end m)
                           :group (.group m)}))
        (persistent! acc)))))

(defn engine-symbol? [engine-schematic idx]
  (if (or (neg-int? idx)
          (<= (count engine-schematic) idx))
    false
    (let [ch (nth engine-schematic idx)]
      (not (or (Character/isDigit ch)
               (= ch \.))))))

(defn symbol-attached? [width engine-schematic {:keys [start end]}]
  (let [the-engine-symbol? (partial engine-symbol? engine-schematic)]
    (or (the-engine-symbol? (dec start)) ;; symbol before number
        (the-engine-symbol? end) ;; symbol after number
        ;; line before number
        (some the-engine-symbol?
              (range (- start width 2) ;; \n counted
                     (- end width)))
        ;; line after number
        (some the-engine-symbol?
              (range (+ start width)
                     (+ end width 2))))));; \n counted

(defn solve [engine-schematic]
  (transduce (comp (filter (partial symbol-attached?
                                    (engine-schematic-width engine-schematic)
                                    engine-schematic))
                   (map :group)
                   (map parse-long))
             +
             (re-find-indexies #"\d+" engine-schematic)))
