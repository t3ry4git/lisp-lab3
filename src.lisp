(defun insert-sort-recursive (lst)
  "Recursive insertion sort in non-decreasing order without auxiliary functions."
  ;; If the list is empty, return an empty list as base case
  (if (null lst)
      nil
      ;; Sort the tail of the list recursively
      (let ((sorted-tail (insert-sort-recursive (cdr lst)))
            (first (car lst)))
        ;; Insert `first` into the sorted tail in the correct position
        (if (or (null sorted-tail) (<= first (car sorted-tail)))
            (cons first sorted-tail)
            (cons (car sorted-tail)
                  (insert-sort-recursive (cons first (cdr sorted-tail))))))))

(defun insert-sort-imperative (lst)
  "Imperative insertion sort in non-decreasing order."
  ;; Create a copy of the original list to preserve it
  (let ((result (copy-list lst)))
    ;; Traverse each element in the list, starting from the second one
    (loop for i from 1 below (length result)
          do (let ((key (elt result i))  ; Save the current element as 'key'
                   (j (1- i)))           ; Initialize the previous element index
               ;; Shift elements while they are greater than 'key'
               (loop while (and (>= j 0) (> (elt result j) key))
                     do (setf (elt result (1+ j)) (elt result j)) ; Shift right
                     do (decf j)) ; Move to the previous element
               ;; Place 'key' at the correct position
               (setf (elt result (1+ j)) key)))
    result)) ; Return the sorted copy

(defun run-recursive-sort-test (input expected-result test-description)
  "Test function specifically for recursive insertion sort."
  (let ((result (insert-sort-recursive input)))
    (if (equal result expected-result)
        (format t "~A: successfully.~%" test-description)
        (format t "~A: failed! ~%Expected: ~A~%Got: ~A~%" 
                test-description expected-result result))))

(defun run-imperative-sort-test (input expected-result test-description)
  "Test function specifically for imperative insertion sort."
  (let ((result (insert-sort-imperative input)))
    (if (equal result expected-result)
        (format t "~A: successfully.~%" test-description)
        (format t "~A: failed! ~%Expected: ~A~%Got: ~A~%" 
                test-description expected-result result))))

(defun test-sorting-recursive ()
  "Testing insert-sort-recursive."
  (format t "Testing recursive insertion sort...~%")
  (run-recursive-sort-test '(3 1 4 1 5 9 2 6 5 3 5) '(1 1 2 3 3 4 5 5 5 6 9) "Recursive: Standard list")
  (run-recursive-sort-test '(1 2 3 4 5) '(1 2 3 4 5) "Recursive: Already sorted list")
  (run-recursive-sort-test '(5 4 3 2 1) '(1 2 3 4 5) "Recursive: Reverse order list")
  (run-recursive-sort-test '() '() "Recursive: Empty list")
  (run-recursive-sort-test '(1) '(1) "Recursive: Single element list")
  (run-recursive-sort-test '(1 2 2 1) '(1 1 2 2) "Recursive: List with duplicates")
  (format t "Testing completed.~%"))

(defun test-sorting-imperative ()
  "Testing insert-sort-imperative."
  (format t "~%Testing imperative insertion sort...~%")
  (run-imperative-sort-test '(3 1 4 1 5 9 2 6 5 3 5) '(1 1 2 3 3 4 5 5 5 6 9) "Imperative: Standard list")
  (run-imperative-sort-test '(1 2 3 4 5) '(1 2 3 4 5) "Imperative: Already sorted list")
  (run-imperative-sort-test '(5 4 3 2 1) '(1 2 3 4 5) "Imperative: Reverse order list")
  (run-imperative-sort-test '() '() "Imperative: Empty list")
  (run-imperative-sort-test '(1) '(1) "Imperative: Single element list")
  (run-imperative-sort-test '(1 2 2 1) '(1 1 2 2) "Imperative: List with duplicates")
  (format t "Testing completed.~%"))
