#|
Simple implementation of a Deterministic Finite Automaton
Identify all the token types found in the input string
Return a list of tokens found
Used to validate input strings
Salvador Salgado Normandia A01422874
Luis Javier Karam Galland A01751941
2022-03-18
|#

#lang racket

(require racket/trace)

(provide arithmetic-lexer)

; Structure that describes a Deterministic Finite Automaton
(struct dfa-str (initial-state accept-states transitions))

(define (arithmetic-lexer input-string)
  " Entry point for the lexer "
  (automaton-2 (dfa-str 'start '(int var sp_num float e_float par_close sp cmmt) delta-arithmetic-1) input-string))

(define (automaton-2 dfa input-string)
  " Evaluate a string to validate or not according to a DFA.
  Return a list of the tokens found"
  (trace-let loop
    ([state (dfa-str-initial-state dfa)]    ; Current state
     [chars (string->list input-string)]    ; List of characters
     [result null])                         ; List of tokens found
    (if (empty? chars)
      ; Check that the final state is in the accept states list
      ;(member state (dfa-str-accept-states dfa))
      (if (member state (dfa-str-accept-states dfa))
        (reverse (cons state result)) #f)
      ; Recursive loop with the new state and the rest of the list
      (let-values
        ; Get the new token found and state by applying the transition function
        ([(token state) ((dfa-str-transitions dfa) state (car chars))])
        (loop
          state
          (cdr chars)
          ; Update the list of tokens found
          (if token (cons token result) result))))))

(define (operator? char)
  (member char '(#\+ #\- #\* #\/ #\^ #\=)))

(define (sign? char)
  (member char '(#\+ #\-)))

(define (dot? char)
  (member char '(#\.)))

(define (space? char)
  (member char '(#\ )))

(define (comment? char)
  (member char '(#\/)))

(define (exp? char)
  (member char '(#\e #\E)))

(define (par_op? char)
  (member char '(#\( )))

(define (par_close? char)
  (member char '(#\) )))


#|
start
var
n_sign
sp_num
float
dot
exp
e_sign
e_float
sp
sp_par
par_close
par_op
cmmt_start
cmmt
int

|#

(define (delta-arithmetic-1 state character)
  " Transition to identify basic arithmetic operations "
  (case state
    ['start (cond
              [(char-numeric? character) (values #f 'int)]
              [(sign? character) (values #f 'n_sign)]
              [(or (char-alphabetic? character) (eq? character #\_))
               (values #f 'var)]
              [(comment? character) (values #f 'cmmt_start)]
              [else (values #f 'fail)])]
    ['n_sign (cond
               [(char-numeric? character) (values #f 'int)]
               [else (values #f 'fail)])]
    ['int (cond
            [(char-numeric? character) (values #f 'int)]
            [(char-whitespace? character) (values #f 'sp_num)]
            #|Como saber cuando no va #f en values|#
            [(operator? character) (values 'int 'op)]
            [(dot? character) (values #f 'dot)]
            [else (values #f 'fail)])]
    ['var (cond
            [(or (char-alphabetic? character) (eq? character #\_))
             (values #f 'var)]
            [(char-numeric? character) (values #f 'var)]
            [(operator? character) (values 'var 'op)]
            [(char-whitespace? character) (values #f 'sp_nvf)]
            [else (values #f 'fail)])]
    ['op (cond
           [(char-numeric? character) (values 'op 'int)]
           [(sign? character) (values 'op 'n_sign)]
           [(or (char-alphabetic? character) (eq? character #\_))
            (values 'op 'var)]
           [(char-whitespace? character) (values #f 'o_sp)]
           [else (values #f 'fail)])]
    ['fail (values #f 'fail)]))

    #|55552 *                 var/ float/ int /n_sign / par
    989809*()
    
    |#