(define 
    (domain sc)

    (:action move
        :parameters (?i - agent, ?r1 - object, ?r2 - object)
        :precondition (and 
            (= (:ontic (= (room ?i) (room_num ?r1))) 1)
            (= (:ontic (= (connected ?r1 ?r2) 1)) 1)
            ;(:ontic (= (searched ?r2) 1) 0)

        )
        :effect (and 
            (= (searched ?r2) 1)
            (= (room ?i) (room_num ?r2))
            (= (searched ?r1) 2)
        )
    )

    