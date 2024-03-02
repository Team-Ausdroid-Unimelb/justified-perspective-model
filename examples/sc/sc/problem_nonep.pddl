( define
    (problem sc_110)
    (:domain sc)

    (:agents
        a b c
    )
    (:objects
        s1 s2 s3 r1 r2 r3 r4 r5 r6 r7 r8 r9
    )

    (:variables
        (room [a,b,c,s1,s2,s3])
        (observed [s1,s2,s3])
        (shared [s1,s2,s3])
        (searched [r1,r2,r3,r4,r5,r6,r7,r8,r9])
        (room_num [r1,r2,r3,r4,r5,r6,r7,r8,r9])
    )

    (:init
        ; (= (connected l1 l2) 1)
        ; (= (:ontic (= (agent_at a) 2)) 1)
        (= (room a) 'r1')
        (= (room b) 'r7')
        (= (room c) 'r6')
        (= (room s1) 'r9')
        (= (room s2) 'r4')
        (= (room s3) 'r3')
        ; room number assignment
        (= (room_num r1) 'r1')
        (= (room_num r2) 'r2')
        (= (room_num r3) 'r3')
        (= (room_num r4) 'r4')
        (= (room_num r5) 'r5')
        (= (room_num r6) 'r6')
        (= (room_num r7) 'r7')
        (= (room_num r8) 'r8')
        (= (room_num r9) 'r9')
        ;connected rooms
        (= (connected r1 r2) 1)
        (= (connected r1 r4) 1)
        (= (connected r2 r3) 1)
        (= (connected r2 r5) 1)
        (= (connected r3 r6) 1)
        (= (connected r4 r5) 1)
        (= (connected r5 r6) 1)
        (= (connected r5 r7) 1)
        (= (connected r6 r8) 1)
        (= (connected r7 r8) 1)
        (= (connected r8 r9) 1)
        (= (connected r2 r1) 1)
        (= (connected r4 r1) 1)
        (= (connected r3 r2) 1)
        (= (connected r5 r2) 1)
        (= (connected r6 r3) 1)
        (= (connected r5 r4) 1)
        (= (connected r6 r5) 1)
        (= (connected r7 r5) 1)
        (= (connected r8 r6) 1)
        (= (connected r8 r7) 1)
        (= (connected r9 r8) 1)
        ; shared stand for sharing location 
        ; of the survivors
        (= (shared s1) 'f')
        (= (shared s2) 'f')
        (= (shared s3) 'f')
        ; dummy values 
        (= (observed s1) 't')
        (= (observed s2) 't')
        (= (observed s3) 't')
        ; has the room been searched
        (= (searched r1) 1)
        (= (searched r2) 0)
        (= (searched r3) 0)
        (= (searched r4) 0)
        (= (searched r5) 0)
        (= (searched r6) 1)
        (= (searched r7) 1)
        (= (searched r8) 0)
        (= (searched r9) 0)
    )

    (:goal (and 
        ; all the rooms have been searched
        (= (:ontic (> (searched r1) 0)) 1)
        ; (= (:ontic (> (searched r2) 0)) 1)
        ; (= (:ontic (> (searched r3) 0)) 1)
        ; (= (:ontic (> (searched r4) 0)) 1)
        ; (= (:ontic (> (searched r5) 0)) 1)
        ; (= (:ontic (> (searched r6) 0)) 1)
        ; (= (:ontic (> (searched r7) 0)) 1)
        ; (= (:ontic (> (searched r8) 0)) 1)
        ; (= (:ontic (> (searched r9) 0)) 1)  
    ))

    (:domains
        (room emunerate ['r1', 'r2', 'r3', 'r4', 'r5', 'r6', 'r7', 'r8', 'r9'])
        ; (room_num integer [1,9])
        (observed enumerate ['t','f'])
        (shared enumerate ['t','f'])
        ; 0 indicates that room has not been searched neither occupied
        ; 1 indicates that room is occupied
        ; 2 indicates that room has been searched and it is not occupied 
        (searched integer [0,2])
    )
)