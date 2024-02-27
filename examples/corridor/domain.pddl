;domain file describes the environment 
; includes: typed of object, predicates(true or false), actions(parameters, precondition and effect ), and functions(numeric values)



;Header and description
(define 
    (domain corridor)

    ;remove requirements that are not needed
    ; (:requirements :strips)
    ; (:requirements :strips :typing :equality)

    ; (:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
        ;agent 
        ;room
        ;secret
    ; )

    ; un-comment following line if constants are needed
    ;(:constants )

    ; (:predicates ;todo: define predicates here
        ;(agent_at-a ?x - agent)
        ;(secret_at ?x - room)
        ;(sensed ?x - secret)
        ;(shared ?x - secret)
    ; )


    ; (:functions ;todo: define numeric functions here
    ; )

    ;define actions here
    (:action move_a_right
        :parameters ()
        :precondition (and )
        :effect (and 
            (= (agent_at-a) (+1))
        )
    )
    
    (:action move_a_left
        :parameters ()
        :precondition (and )
        :effect (and 
            (= (agent_at-a) (-1))
        )
    )

    (:action sense
        :parameters (?s - object)
        :precondition (and 
            (= (:ontic (= (agent_at-a) (secret_at ?s))) 1)      ; a knows the secret 
        )
        :effect (and 
            (= (sensed ?s) 't') 
        )
    )

    (:action shout
        :parameters (?s - object)
        :precondition (and 
            (= (:ontic (= (sensed ?s) 't')) 1)      
        )
        :effect (and 
            (= (shared ?s) (agent_at-a))
            (= (secret ?s) 't')
        )
    )

    (:action shout_lie
        :parameters (?s - object)
        :precondition (and 
            (= (:ontic (= (sensed ?s) 't')) 1)
        )
        :effect (and 
            (= (shared ?s) (agent_at-a))
            (= (secret ?s) 'f')
        )
    )

)