;Header and description

(define 
    (domain sn)

    ;define action
    (:action a_post
        :parameters (?p - object, ?a - agent)
        :precondition (and 
            (= (:ontic (= (friended a ?a) 1)) 1)
            (= (:ontic (= (post ?p ?a) 0)) 1)
        )
        :effect (and 
            (= (post ?p ?a) 1) 
        )
    )

    (:action b_post
        :parameters (?p - object, ?a - agent)
        :precondition (and 
            (= (:ontic (= (friended b ?a) 1)) 1)
            (= (:ontic (= (post ?p ?a) 0)) 1)
        )
        :effect (and 
            (= (post ?p ?a) 1)
            ; (= (secret ?p) 'f')
        )
    )

    (:action c_post
        :parameters (?p - object, ?a - agent)
        :precondition (and 
            (= (:ontic (= (friended c ?a) 1)) 1)
            (= (:ontic (= (post ?p ?a) 0)) 1)
        )
        :effect (and 
            (= (post ?p ?a) 1)
        )
    )

    (:action d_post
        :parameters (?p - object, ?a - agent)
        :precondition (and 
            (= (:ontic (= (friended d ?a) 1)) 1)
            (= (:ontic (= (post ?p ?a) 0)) 1)
        )
        :effect (and 
            (= (post ?p ?a) 1)
        )
    )

    (:action e_post
        :parameters (?p - object, ?a - agent)
        :precondition (and 
            (= (:ontic (= (friended e ?a) 1)) 1)
            (= (:ontic (= (post ?p ?a) 0)) 1)
        )
        :effect (and 
            (= (post ?p ?a) 1)
        )
    )

    (:action a_friends
        :parameters (?a - agent)
        :precondition (and 
        ; to do
            (= (:ontic (= (friended a ?a) 0)) 1)
        )
        :effect (and 
            (= (friended a ?a) 1)
            (= (friended ?a a) 1)
        )
    )

    (:action a_unfriends
        :parameters (?a - agent)
        :precondition (and 
        ; to do
            (= (:ontic (= (friended a ?a) 1)) 1)
        )
        :effect (and 
            (= (friended a ?a) 0)
            (= (friended ?a a) 0)
        )
    )

)