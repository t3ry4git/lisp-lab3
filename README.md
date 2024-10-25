<p align="center"><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПМ СПіСКС</b></p>
<p align="center">
<b>Звіт з лабораторної роботи 3</b><br/>
"Функціональний і імперативний підходи до роботи зі списками"<br/>
дисципліни "Вступ до функціонального програмування"
</p>
<p align="right"><b>Студент</b>: Терентьєв Іван Дмитрович КВ-11</p>
<p align="right"><b>Рік</b>: 2024</p>

## Загальне завдання
Реалізуйте алгоритм сортування чисел у списку двома способами: функціонально і імперативно.
1. Функціональний варіант реалізації має базуватись на використанні рекурсії і конструюванні нових списків щоразу, коли необхідно виконати зміну вхідного списку. Не допускається використання: деструктивних операцій, циклів, функцій вищого порядку або функцій для роботи зі списками/послідовностями, що використовуються як функції вищого порядку. Також реалізована функція не має бути функціоналом (тобто приймати на вхід функції в якості аргументів).
2. Імперативний варіант реалізації має базуватись на використанні циклів і деструктивних функцій (псевдофункцій). Не допускається використання функцій вищого порядку або функцій для роботи зі списками/послідовностями, що використовуються як функції вищого порядку. Тим не менш, оригінальний список цей варіант реалізації також не має змінювати, тому перед виконанням деструктивних змін варто застосувати функцію copy-list (в разі необхідності). Також реалізована функція не має бути функціоналом (тобто приймати на вхід функції в якості аргументів). 

Алгоритм, який необхідно реалізувати, задається варіантом (п. 3.1.1). Зміст і шаблон звіту наведені в п. 3.2. 
Кожна реалізована функція має бути протестована для різних тестових наборів. 
Тести мають бути оформленні у вигляді модульних тестів (наприклад, як наведено у п. 2.3).
## Варіант 6(22)
Алгоритм сортування вставкою №1 (з лінійним пошуком зліва) за незменшенням.
## Лістинг функції insert-sort-recursive
```lisp
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
```
## Лістинг функції insert-sort-imperative
```lisp
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
```
### Тестові набори для insert-sort-recursive
```lisp
(defun run-recursive-sort-test (input expected-result test-description)
  "Test function specifically for recursive insertion sort."
  (let ((result (insert-sort-recursive input)))
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
```

### Тестові набори для insert-sort-imperative
```lisp
(defun run-imperative-sort-test (input expected-result test-description)
  "Test function specifically for imperative insertion sort."
  (let ((result (insert-sort-imperative input)))
    (if (equal result expected-result)
        (format t "~A: successfully.~%" test-description)
        (format t "~A: failed! ~%Expected: ~A~%Got: ~A~%" 
                test-description expected-result result))))

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
```

### Тестування
```lisp
cl-user > (test-sorting-recursive)
Testing recursive insertion sort...
Recursive: Standard list: successfully.
Recursive: Already sorted list: successfully.
Recursive: Reverse order list: successfully.
Recursive: Empty list: successfully.
Recursive: Single element list: successfully.
Recursive: List with duplicates: successfully.
Testing completed.
NIL

cl-user > (test-sorting-imperative)
Testing imperative insertion sort...
Imperative: Standard list: successfully.
Imperative: Already sorted list: successfully.
Imperative: Reverse order list: successfully.
Imperative: Empty list: successfully.
Imperative: Single element list: successfully.
Imperative: List with duplicates: successfully.
Testing completed.
NIL
```