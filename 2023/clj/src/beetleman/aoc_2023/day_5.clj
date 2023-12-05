(ns beetleman.aoc-2023.day-5)

(defn seeds [almanac-string]
  (let [[_ seeds-line] (re-find #"(seeds: .+)\n" almanac-string)]
    (mapv parse-long
          (re-seq #"\d+" seeds-line))))

(defn ranges [ranges-string]
  (into []
        (comp (map parse-long)
              (partition-all 3)
              (map (fn [[destination source range]]
                     {:source      source
                      :destination destination
                      :range       range})))
        (re-seq #"\d+" ranges-string)))

(defn coordinate [number {:keys [ranges]}]
  (or (some (fn [{:keys [source destination range]}]
              (when (< (dec source) number (+ source range))
                (+ destination
                   (- number source))))
            ranges)
      number))

(defn process-steps [start stop steps value]
  (loop [source start
         value  value]
    (if-let [step (get steps source)]
      (if (= (:destination step) stop)
        (coordinate value step)
        (recur (:destination step)
               (coordinate value step)))
      (throw (ex-info "No more steps" {:source source
                                       :start  start
                                       :stop   stop})))))

(defn solve [almanac-string]
  (let [seeds  (seeds almanac-string)
        steps (into {}
                    (map (fn [[_ source destination ranges-string]]
                           [source {:source      source
                                    :destination destination
                                    :ranges      (ranges ranges-string)}]))
                    (re-seq #"([a-z]+)-to-([a-z]+) map:\n([\d \n]+)" almanac-string))]
    (->> seeds
         (map (partial process-steps "seed" "location" steps))
         sort
         first)))
