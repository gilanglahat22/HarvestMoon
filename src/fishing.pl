fish :-
    gameStarted,
    currentPosition(X, Y),
    isNearTileAir(X, Y),
    player(_,_,_,_,_,LevelFishing,_,_,_,_),
    MaxRandom is LevelFishing + 1,
    random(0, MaxRandom, Z),
    ikan(Z, A),
    isFisherman(A),
    ( Z =\= 0, isQuestActive(F), F == true,
    activeQuest(HARVEST, FISH, RANCH),
    SISA is FISH - 1,
    retract(activeQuest(HARVEST, FISH, RANCH)),
    assertz(activeQuest(HARVEST, SISA, RANCH)),
    cekApakahQuestSelesai(_);
    Z =:= 0;
    Z =\= 0, isQuestActive(F), F == false),
    fishingEnergy(Energy),
    reduceEnergy(Energy),
    exhaustedEnergyAction,
    printLowEnergyMsg, !.

ikan(0, 5) :-
    write('You didn\'t get anything!'), nl,
    (player(fisherman,_,_,_,_,_,_,_,_,_), write('You gained 10 fishing exp!\n');
    \+player(fisherman,_,_,_,_,_,_,_,_,_), write('You gained 5 fishing exp!\n')).

ikan(1, 10) :-
    addInven(1, 'cupang'),
    write('You got cupang!'), nl,
    (player(fisherman,_,_,_,_,_,_,_,_,_), write('You gained 20 fishing exp!\n');
    \+player(fisherman,_,_,_,_,_,_,_,_,_), write('You gained 10 fishing exp!\n')).

ikan(2, 15) :-
    addInven(1, 'lele'),
    write('You got lele!'), nl,
    (player(fisherman,_,_,_,_,_,_,_,_,_), write('You gained 30 fishing exp!\n');
    \+player(fisherman,_,_,_,_,_,_,_,_,_), write('You gained 15 fishing exp!\n')).

ikan(3, 20) :-
    addInven(1, 'tongkol'),
    write('You got tongkol!'), nl,
    (player(fisherman,_,_,_,_,_,_,_,_,_), write('You gained 40 fishing exp!\n');
    \+player(fisherman,_,_,_,_,_,_,_,_,_), write('You gained 20 fishing exp!\n')).

ikan(4, 25) :-
    addInven(1, 'bandeng'),
    write('You got bandeng!'), nl,
    (player(fisherman,_,_,_,_,_,_,_,_,_), write('You gained 50 fishing exp!\n');
    \+player(fisherman,_,_,_,_,_,_,_,_,_), write('You gained 25 fishing exp!\n')).

ikan(5, 30) :-
    addInven(1, 'cakalang'),
    write('You got cakalang!'), nl,
    (player(fisherman,_,_,_,_,_,_,_,_,_), write('You gained 60 fishing exp!\n');
    \+player(fisherman,_,_,_,_,_,_,_,_,_), write('You gained 30 fishing exp!\n')).

ikan(6, 35) :-
    addInven(1, 'gurame'),
    write('You got gurame!'), nl,
    (player(fisherman,_,_,_,_,_,_,_,_,_), write('You gained 70 fishing exp!\n');
    \+player(fisherman,_,_,_,_,_,_,_,_,_), write('You gained 35 fishing exp!\n')).

ikan(7, 40) :-
    addInven(1, 'kakap'),
    write('You got kakap!'), nl,
    (player(fisherman,_,_,_,_,_,_,_,_,_), write('You gained 80 fishing exp!\n');
    \+player(fisherman,_,_,_,_,_,_,_,_,_), write('You gained 40 fishing exp!\n')).

ikan(8, 45) :-
    addInven(1, 'tuna'),
    write('You got tuna!'), nl,
    (player(fisherman,_,_,_,_,_,_,_,_,_), write('You gained 90 fishing exp!\n');
    \+player(fisherman,_,_,_,_,_,_,_,_,_), write('You gained 45 fishing exp!\n')).

ikan(9, 50) :-
    addInven(1, 'salmon'),
    write('You got salmon!'), nl,
    (player(fisherman,_,_,_,_,_,_,_,_,_), write('You gained 100 fishing exp!\n');
    \+player(fisherman,_,_,_,_,_,_,_,_,_), write('You gained 50 fishing exp!\n')).

ikan(10, 55) :-
    addInven(1, 'megalodon'),
    write('You got megalodon!'), nl,
    (player(fisherman,_,_,_,_,_,_,_,_,_), write('You gained 110 fishing exp!\n');
    \+player(fisherman,_,_,_,_,_,_,_,_,_), write('You gained 55 fishing exp!\n')).