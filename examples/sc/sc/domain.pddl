;Header and description

(define 
    (domain sc)

    (:action move_up
        :parameters (?i - agent)
        :precondition (and)
        :effect (and 
            (= (y ?i) ( + 1))
        )
    )

    (:action move_down
        :parameters (?i - agent)
        :precondition (and)
        :effect (and 
            (= (y ?i) ( - 1))
        )
    )

    (:action move_left
        :parameters (?i - agent)
        :precondition (and)
        :effect (and 
            (= (x ?i) ( - 1))
        )
    )

    (:action move_right
        :parameters (?i - agent)
        :precondition (and)
        :effect (and 
            (= (x ?i) ( + 1))
        )
    )


    (:action communicate
    :parameters (?i - agent, ?s - object)
        :precondition (and 
            (= (:ontic (= (x ?s) (x ?i))) 1)
            (= (:ontic (= (y ?s) (y ?i))) 1)
        )
        :effect (and 
            (= (shared ?s) 't')
            ; every agent knows the location of the survivor
        )
    )

)