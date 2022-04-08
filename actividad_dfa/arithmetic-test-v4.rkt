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
        ; Numerical types
        (check-equal? (arithmetic-lexer "2") '(("2" int)) "Single digit")
        (check-equal? (arithmetic-lexer "261") '(("261" int)) "Multi digit int")
        (check-equal? (arithmetic-lexer "-63") '(("-63" int)) "Negative int")
        (check-equal? (arithmetic-lexer "5.23") '(("5.23" float)) "Single float")
        (check-equal? (arithmetic-lexer "-5.23") '(("-5.23" float)) "Negative float")
        (check-equal? (arithmetic-lexer ".23") #f "Incorrect float")
        (check-equal? (arithmetic-lexer "2.2.3") #f "Incorrect float")
        (check-equal? (arithmetic-lexer "4e8") '(("4e8" exp)) "Exponent int")
        (check-equal? (arithmetic-lexer "4.51e8") '(("4.51e8" exp)) "Exponent float")
        (check-equal? (arithmetic-lexer "-4.51e8") '(("-4.51e8" exp)) "Negative exponent float")

        ; Variables
        (check-equal? (arithmetic-lexer "data") '(("data" var)) "Single variable")
        (check-equal? (arithmetic-lexer "data34") '(("data34" var)) "Single variable")
        (check-equal? (arithmetic-lexer "34data") #f "Incorrect variable")

        (check-equal? (arithmetic-lexer "2+1") '(("2" int) ("+" op) ("1" int)) "Binary operation ints")
        (check-equal? (arithmetic-lexer "/1") #f "Invalid expression")
        (check-equal? (arithmetic-lexer "6 + 4 *+ 1") #f "Invalid expression")
        (check-equal? (arithmetic-lexer "5.2+3") '(("5.2" float) ("+" op) ("3" int)) "Float and int")
        (check-equal? (arithmetic-lexer "5.2+3.7") '(("5.2" float) ("+" op) ("3.7" float)) "Binary operation floats")

        ; Operations with variables
        (check-equal? (arithmetic-lexer "one+two") '(("one" var) ("+" op) ("two" var)) "Binary operation variables")
        (check-equal? (arithmetic-lexer "one+two/45.2") '(("one" var) ("+" op) ("two" var) ("/" op) ("45.2" float)) "Mixed variables numbers")

        ; Spaces between operators
        (check-equal? (arithmetic-lexer "2 + 1") '(("2" int) ("+" op) ("1" int)) "Binary operation with spaces")
        (check-equal? (arithmetic-lexer "6 = 2 + 1") '(("6" int) ("=" op) ("2" int) ("+" op) ("1" int)) "Multiple operators with spaces")
        (check-equal? (arithmetic-lexer "one + two / 45.2") '(("one" var) ("+" op) ("two" var) ("/" op) ("45.2" float)) "Mixed variables numbers spaces")
        (check-equal? (arithmetic-lexer "97 /6 = 2 + 1") '(("97" int) ("/" op) ("6" int) ("=" op) ("2" int) ("+" op) ("1" int)) "Multiple operators")
        (check-equal? (arithmetic-lexer "7.4 ^3 = 2.0 * 1") '(("7.4" float) ("^" op) ("3" int) ("=" op) ("2.0" float) ("*" op) ("1" int)) "Multiple float operators with spaces")

        ; Parentheses
        ;(check-equal? (arithmetic-lexer "()") '(("(" par_open) (")" par_close)) "Open and close")
        ;(check-equal? (arithmetic-lexer "( )") '(("(" par_open) (")" par_close)) "Open space close")
        (check-equal? (arithmetic-lexer "(45)") '(("(" par_open) ("45" int) (")" par_close)) "Open int close")
        (check-equal? (arithmetic-lexer "( 45 )") '(("(" par_open) ("45" int) (")" par_close)) "Open space int space close")
        (check-equal? (arithmetic-lexer "(4 + 5)") '(("(" par_open) ("4" int) ("+" op) ("5" int) (")" par_close)) "Open expression close")
        (check-equal? (arithmetic-lexer "(4 + 5) * (6 - 3)") '(("(" par_open) ("4" int) ("+" op) ("5" int) (")" par_close) ("*" op) ("(" par_open) ("6" int) ("-" op) ("3" int) (")" par_close)) "Open expression close")

        ; Comments
        (check-equal? (arithmetic-lexer "3// this is all") '(("3" int) ("// this is all" comment)) "Variable and comment")
        (check-equal? (arithmetic-lexer "3+5 // this is all") '(("3" int) ("+" op) ("5" int) ("// this is all" comment)) "Expression and comment")
        (check-equal? (arithmetic-lexer "area = 3.1415 * raduis ^2 // area of a circle") '(("area" var) ("=" op) ("3.1415" float) ("*" op) ("raduis" var) ("^" op) ("2" int) ("// area of a circle" comment)) "Complete expression 1")
        (check-equal? (arithmetic-lexer "result = -34.6e10 * previous / 2.0 // made up formula") '(("result" var) ("=" op) ("-34.6e10" exp) ("*" op) ("previous" var) ("/" op) ("2.0" float) ("// made up formula" comment)) "Complete expression 2")
        (check-equal? (arithmetic-lexer "cel = (far - 32) * 5 / 9.0 // temperature conversion") '(("cel" var) ("=" op) ("(" par_open) ("far" var) ("-" op) ("32" int) (")" par_close) ("*" op) ("5" int) ("/" op) ("9.0" float) ("// temperature conversion" comment)) "Complete expression 3")

        ; Extreme cases of spaces before or after the expression
        (check-equal? (arithmetic-lexer "  2 + 1") '(("2" int) ("+" op) ("1" int)) "Spaces before")
        (check-equal? (arithmetic-lexer "  2 + 1 ") '(("2" int) ("+" op) ("1" int)) "Spaces before and after")
    ))

; Start the execution of the test suite
(displayln "Testing: arithmetic-lexer")
(run-tests test-arithmetic-lexer)
