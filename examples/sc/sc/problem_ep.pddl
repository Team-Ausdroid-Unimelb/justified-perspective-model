( define
    (problem sc_110)
    (:domain sc)

    (:agents
        a b c
    )
    (:objects
        s1 s2 s3
    )

    (:variables
        (x [a,b,c,s1,s2,s3])
        (y [a,b,c,s1,s2,s3])
        (observed [s1,s2,s3])
        (shared [s1,s2,s3])
    )

    (:init
        ; (= (connected l1 l2) 1)
        (= (x a) 1)
        (= (x b) 1)
        (= (x c) 3)
        (= (x s1) 3)
        (= (x s2) 1)
        (= (x s3) 3)
        (= (y a) 3)
        (= (y b) 1)
        (= (y c) 2)
        (= (y s1) 1)
        (= (y s2) 2)
        (= (y s3) 3)
        ; shared stand for sharing location 
        ; of the survivors
        (= (shared s1) 'f')
        (= (shared s2) 'f')
        (= (shared s3) 'f')
        ; dummy values 
        (= (observed s1) 't')
        (= (observed s2) 't')
        (= (observed s3) 't')
        
    )

    (:goal (and 
        (= (:epistemic b [b] (= (observed s1) 't')) 1)
        (= (:epistemic b [b] (= (observed s2) 't')) 1)
        (= (:epistemic b [b] (= (observed s3) 't')) 1)
        (= (:epistemic b [] (= (observed s3) 't')) 1)
    ))

    (:domains
        (x integer [0,4])
        (y integer [0,4])
        (observed enumerate ['t','f'])
        (shared enumerate ['t','f'])
    )
)