/* Move ke atas */
w :-
    gameStarted,
    currentPosition(XC,YC),
    YT is YC + 1,
    isValidMoveTarget(XC,YT),
    retract(currentPosition(_,_)),
    assertz(currentPosition(XC,YT)),
    write('You moved north.'),
    nl,
    printSpecialMoveMessage(XC,YT),
    printNearAirMessage(XC,YT),
    reduceEnergy(2),
    exhaustedEnergyAction,
    printLowEnergyMsg,
    !.

/* Move ke kiri */
a :-
    gameStarted,
    currentPosition(XC,YC),
    XT is XC - 1,
    isValidMoveTarget(XT,YC),
    retract(currentPosition(_,_)),
    assertz(currentPosition(XT,YC)),
    write('You moved east.'),
    nl,
    printSpecialMoveMessage(XT,YC),
    printNearAirMessage(XT,YC),
    reduceEnergy(2),
    exhaustedEnergyAction,
    printLowEnergyMsg,
    !.

/* Move ke bawah */
s :-
    gameStarted,
    currentPosition(XC,YC),
    YT is YC - 1,
    isValidMoveTarget(XC,YT),
    retract(currentPosition(_,_)),
    assertz(currentPosition(XC,YT)),
    write('You moved south.'),
    nl,
    printSpecialMoveMessage(XC,YT),
    printNearAirMessage(XC,YT),
    reduceEnergy(2),
    exhaustedEnergyAction,
    printLowEnergyMsg,
    !.

/* Move ke kanan */
d :-
    gameStarted,
    currentPosition(XC,YC),
    XT is XC + 1,
    isValidMoveTarget(XT,YC),
    retract(currentPosition(_,_)),
    assertz(currentPosition(XT,YC)),
    write('You moved west.'),
    nl,
    printSpecialMoveMessage(XT,YC),
    printNearAirMessage(XT,YC),
    reduceEnergy(2),
    exhaustedEnergyAction,
    printLowEnergyMsg,
    !.

/* Mengecek apakah koordinat merupakan target gerakan yang valid, memberi pesan kegagalan jika tidak valid */
isValidMoveTarget(X,Y) :-
    isInBounds(X,Y),
    \+ (isTileAir(X,Y)).
isValidMoveTarget(X,Y) :-
    \+ (isInBounds(X,Y)),
    write('You cannot move out of the map!\n'),
    fail.
isValidMoveTarget(X,Y) :-
    isTileAir(X,Y),
    write('You cannot move to a water tile!\n'),
    fail.

/* Mengecek apakah koordinat (X,Y) ada di rentang dimensi peta */
isInBounds(X,Y) :- 
    mapDimension(XMax,YMax),
    X > 0,
    Y > 0,
    X =< XMax,
    Y =< YMax.

/* Menampilkan pesan jika target gerakan merupakan suatu posisi khusus */
printSpecialMoveMessage(X,Y) :-
    isHouse(X,Y),
    write('You have arrived at your house! Type "house." to access the house menu.'),
    nl,
    !.
printSpecialMoveMessage(X,Y) :-
    isTempatQuest(X,Y),
    write('You have arrived at the quest centre! Type "quest." to get a quest.'),
    nl,
    !.
printSpecialMoveMessage(X,Y) :-
    isRanch(X,Y),
    write('You have arrived at the ranch! Type "ranch." to access the ranch menu.'),
    nl,
    !.
printSpecialMoveMessage(X,Y) :-
    isMarketplace(X,Y),
    write('You have arrived at the marketplace! Type "market." to access the marketplace menu.'),
    nl,
    !.
printSpecialMoveMessage(X,Y) :-
    isCarrotTile(X,Y),
    write('You have arrived at your carrot plant!'),
    nl,
    printHarvestReadyMessage(X,Y),
    !.
printSpecialMoveMessage(X,Y) :-
    isCornTile(X,Y),
    write('You have arrived at your corn plant!'),
    nl,
    printHarvestReadyMessage(X,Y),
    !.
printSpecialMoveMessage(X,Y) :-
    isTomatoTile(X,Y),
    write('You have arrived at your tomato plant!'),
    nl,
    printHarvestReadyMessage(X,Y),
    !.
printSpecialMoveMessage(X,Y) :-
    isPotatoTile(X,Y),
    write('You have arrived at your potato plant!'),
    nl,
    printHarvestReadyMessage(X,Y),
    !.
printSpecialMoveMessage(_,_).

/* Menampilkan pesan sudah siap atau tidaknya tanaman di tile tersebut untuk dipanen */
printHarvestReadyMessage(X,Y) :-
    waktuPanen(X,Y,WAKTUPANEN),
    day(HARIINI),
    WAKTUPANEN=<HARIINI,
    write('Your plant is ready for harvest! Type "harvest." to harvest the plant.\n').
printHarvestReadyMessage(X,Y) :-
    waktuPanen(X,Y,WAKTUPANEN),
    day(HARIINI),
    WAKTUPANEN>HARIINI,
    SELISIH is WAKTUPANEN - HARIINI,
    SELISIH == 1,
    write('Looks like your plant is not ready for harvest. Wait for 1 more day.\n').
printHarvestReadyMessage(X,Y) :-
    waktuPanen(X,Y,WAKTUPANEN),
    day(HARIINI),
    WAKTUPANEN>HARIINI,
    SELISIH is WAKTUPANEN - HARIINI,
    SELISIH \= 1,
    write('Looks like your plant is not ready for harvest. Wait for '),
    write(SELISIH),
    write(' more days.\n').

/* Menampilkan pesan jika tile target dekat tile air */
printNearAirMessage(X,Y) :-
    isNearTileAir(X,Y),
    write('You are close to the waters! Type "fish." to start fishing.'),
    nl,
    !.
printNearAirMessage(_,_).