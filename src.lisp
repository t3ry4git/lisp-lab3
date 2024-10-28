(defun insert-sort-recursive (lst)
  "Recursive insertion sort with left linear search."
  (if (null lst)
      nil
      (let ((sorted-tail (insert-sort-recursive (cdr lst)))
            (beg (car lst)))
        (labels ((insert (element sorted)
                   (if (null sorted)
                       (list element)
                       (let ((head (car sorted)))
                         (if (<= element head)
                             (cons element sorted)
                             (cons head (insert element (cdr sorted))))))))
          (insert beg sorted-tail)))))



(defun insert-sort-imperative (lst)
  "Imperative insertion sort with left linear search."
  (let ((result (copy-list lst)))
    (loop for i from 1 below (length result)
          do (let ((key (elt result i))  
                   (j 0))                
               (loop while (< (elt result j) key)
                     do (incf j))
               (loop for k from (1- i) downto j
                     do (setf (elt result (1+ k)) (elt result k)))
               (setf (elt result j) key)))
    result))



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
