(defsystem "beetleman.aoc-2023"
  :version "0.0.1"
  :author ""
  :license ""
  :depends-on ("cl-ppcre")
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description ""
  :in-order-to ((test-op (test-op "beetleman.aoc-2023/tests"))))

(defsystem "beetleman.aoc-2023/tests"
  :author ""
  :license ""
  :depends-on ("beetleman.aoc-2023"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for beetleman.aoc-2023"
  :perform (test-op (op c) (symbol-call :rove :run c)))
