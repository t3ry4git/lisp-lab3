(defun insert-left (element sorted-list)
  (cond
    ((null sorted-list) (list element))
    ((<= element (first sorted-list)) (cons element sorted-list))
    (t (cons (first sorted-list) (insert-left element (rest sorted-list))))))

(defun insertion-sort-functional (lst)
  (if (null lst)
      nil  
      (insert-left (first lst) (insertion-sort-functional (rest lst)))))

(defun insertion-sort-imperative (lst)
  (let ((copy-list (copy-list lst)))
    (loop for i from 1 below (length copy-list) do
      (let ((key (nth i copy-list))
            (j (- i 1)))
        (loop while (and (>= j 0) (> (nth j copy-list) key)) do
          (setf (nth (+ j 1) copy-list) (nth j copy-list))
          (decf j))
        (setf (nth (+ j 1) copy-list) key)))
    copy-list))

(defun run-insertion-sort-functional-test (input expected-result test-description)
  "Test func for insertion-sort-functional"
  (let ((result (insertion-sort-functional input)))
    (if (equal result expected-result)
        (format t "~A: successfully.~%" test-description)
        (format t "~A: failed! ~%Expected: ~A~%Got: ~A~%" 
                test-description expected-result result))))

(defun test-insertion-sort-functional ()
  "Testing insertion-sort-functional."
  (format t "Starting testing of insertion-sort-functional...~%")
  (run-insertion-sort-functional-test '(5 3 4 1 2) '(1 2 3 4 5) "Test 1: Normal list")
  (run-insertion-sort-functional-test '(1 2 3 4 5) '(1 2 3 4 5) "Test 2: Already sorted list")
  (run-insertion-sort-functional-test '(5 4 3 2 1) '(1 2 3 4 5) "Test 3: Reversed list")
  (run-insertion-sort-functional-test '() '() "Test 4: Empty list")
  (run-insertion-sort-functional-test '(1) '(1) "Test 5: Single element list")
  (run-insertion-sort-functional-test '(1 2 2 1) '(1 1 2 2) "Test 6: List with duplicates")
  (format t "Testing completed.~%"))


(defun run-insertion-sort-imperative-test (input expected-result test-description)
  "Test func for insertion-sort-imperative"
  (let ((result (insertion-sort-imperative input)))
    (if (equal result expected-result)
        (format t "~A: successfully.~%" test-description)
        (format t "~A: failed! ~%Expected: ~A~%Got: ~A~%" 
                test-description expected-result result))))

(defun test-insertion-sort-imperative ()
  "Testing insertion-sort-imperative."
  (format t "Starting testing of insertion-sort-imperative...~%")
  (run-insertion-sort-imperative-test '(5 3 4 1 2) '(1 2 3 4 5) "Test 1: Normal list")
  (run-insertion-sort-imperative-test '(1 2 3 4 5) '(1 2 3 4 5) "Test 2: Already sorted list")
  (run-insertion-sort-imperative-test '(5 4 3 2 1) '(1 2 3 4 5) "Test 3: Reversed list")
  (run-insertion-sort-imperative-test '() '() "Test 4: Empty list")
  (run-insertion-sort-imperative-test '(1) '(1) "Test 5: Single element list")
  (run-insertion-sort-imperative-test '(1 2 2 1) '(1 1 2 2) "Test 6: List with duplicates")
  (format t "Testing completed.~%"))
