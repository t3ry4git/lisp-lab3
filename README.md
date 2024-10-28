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
```
## Лістинг функції insert-sort-imperative
```lisp
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

### Тестові питання
<table><thead><tr><th>№</th><th>Запитання</th><th>Відповідь</th></tr></thead><tbody><tr><td>1</td><td>Що таке псевдофункція? Наведіть приклади псевдофункцій.</td><td>Псевдофункція — це операція, яка змінює вхідні дані (список, масив тощо) напряму, без створення копій. Це руйнівний підхід, коли дані змінюються прямо на місці. Приклади псевдофункцій: <code>nconc</code>, <code>nreverse</code>, <code>delete</code>, <code>remf</code>.</td></tr><tr><td>2</td><td>В чому різниця між конструктивним та руйнівним підходами до роботи зі списками?</td><td>Конструктивний підхід створює нові списки при кожній зміні, залишаючи оригінальний список незмінним. Руйнівний підхід модифікує список напряму, змінюючи його вміст на місці, без створення копій. Конструктивний підхід безпечний, але більш ресурсоємний, тоді як руйнівний ефективніший, але потенційно небезпечний, оскільки змінює вихідні дані.</td></tr><tr><td>3</td><td>Наведіть приклади функцій для конструювання списків.</td><td>Приклади конструктивних функцій: <code>cons</code>, <code>append</code>, <code>list</code>, <code>copy-list</code>, <code>mapcar</code> (коли створює новий список на основі перетворених елементів). Ці функції створюють нові списки, залишаючи вихідний список незмінним.</td></tr><tr><td>4</td><td>Наведіть приклади функцій, якими можна змінити списки деструктивно.</td><td>Приклади деструктивних функцій: <code>setf</code>, <code>nconc</code>, <code>nreverse</code>, <code>rplaca</code>, <code>rplacd</code>, <code>delete</code>, <code>remf</code>. Ці функції змінюють список напряму, впливаючи на початкові дані.</td></tr><tr><td>5</td><td>Опишіть особливості роботи макроса <code>SETF</code>.</td><td><code>SETF</code> — це універсальний макрос для присвоєння значень «місцям» (places), таким як змінні, елементи масиву чи поля об'єктів. Він автоматично визначає тип місця і використовує відповідну операцію, щоб змінити значення, не створюючи нові змінні. Наприклад, <code>setf (car list) 'new-value'</code> змінює перший елемент <code>list</code> на <code>'new-value'</code>.</td></tr><tr><td>6</td><td>Що таке "місця" (places), якщо говорити про деструктивні функції? Які є форми для роботи з "місцями"?</td><td>"Місця" (places) — це частини структури даних, де можна зберігати або змінювати значення (наприклад, елемент списку, змінна, поле структури). Для роботи з "місцями" використовуються такі форми, як <code>setf</code>, <code>incf</code>, <code>decf</code>, <code>push</code>, <code>pop</code>, що дозволяють зручно змінювати їх значення.</td></tr><tr><td>7</td><td>Як можна повернути з функції багато значень і обробити їх?</td><td>У Common Lisp функція може повернути кілька значень за допомогою <code>values</code>. Для отримання значень використовується <code>multiple-value-bind</code> або <code>multiple-value-list</code>. Наприклад, <code>(multiple-value-bind (x y) (func) ...)</code> присвоює змінним <code>x</code> та <code>y</code> перші два значення, які повертає <code>func</code>.</td></tr><tr><td>8</td><td>Як реалізувати цикли за допомогою рекурсії?</td><td>Рекурсія — це виклик функцією самої себе. Для реалізації циклу через рекурсію визначається базовий випадок, який завершує рекурсію, і рекурсивний випадок, що зменшує задачу (наприклад, зменшує список або лічильник). Кожен виклик обробляє частину задачі, поки не досягнеться базовий випадок, що завершує виконання.</td></tr></tbody></table>