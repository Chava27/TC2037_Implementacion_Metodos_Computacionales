#|
    Programming a DFA
    Using recursion and Finite State Automata

    Gilberto Echeverria
    2021-03-24
|#

; Import library for unit testing
(require rackunit)
; Import necesary to view the test results
(require rackunit/text-ui)

(define test-arithmetic-lexer
    (test-suite
        " Test function: arithmetic-lexer"
        (check-equal? (arithmetic-lexer "2") '(int) "Single digit")
        (check-equal? (arithmetic-lexer "261") '(int) "Multi digit int")
        (check-equal? (arithmetic-lexer "2+1") '(int op int) "Binary operation")
        (check-equal? (arithmetic-lexer "2 + 1") '(int op int) "Binary operation with spaces")
        (check-equal? (arithmetic-lexer "6 = 2 + 1") '(int op int op int) "Multiple operators")
        (check-equal? (arithmetic-lexer "97 /6 = 2 + 1") '(int op int op int op int) "Multiple operators")
        (check-equal? (arithmetic-lexer " 2 + 1 ") '(int op int) "Spaces before and after")
    ))

; Start the execution of the test suite
(displayln "Testing: arithmetic-lexer")
(run-tests test-arithmetic-lexer)
