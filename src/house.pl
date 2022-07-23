house :- 
    gameStarted,
    currentPosition(X,Y),
    isHouse(X,Y),
    write('What do you want to do?\n'),
    write('- sleep\n- writeDiary\n- readDiary\n- exitHouse\n'),
    write('| ?- '), read(INPUT),
    houseOption(INPUT), !.

houseOption(sleep) :-
    write('You went to sleep\n'),
    replenishEnergy,
    retract(day(X)),
    Y is X+1,
    assertz(day(Y)),
    write('\nDAY '),
    write(Y), nl,
    checkDay(_), !.

houseOption(writeDiary) :-
    day(DAY),
    write('Write your diary for Day '),
    write(DAY),
    nl,
    write('| ?- '), read(INPUT),
    assertz(isiDiary(DAY,INPUT)),
    write('Day '),
    write(DAY),
    write(' entry saved\n').

houseOption(readDiary) :-
    isiDiary(DAY,_),
    write('- Day '),
    write(DAY),
    nl,
    fail;
    true,
    nl,
    write('Which entry do you want to read?\n'),
    write('| ?- '), read(INPUT),
    isiDiary(INPUT,CONTENT),
    write('Here is your entry for day '),
    write(INPUT),
    write(':\n'),
    write(CONTENT),nl,fail
    ;true.

houseOption(exitHouse) :-
    write('\nHave A Nice Day!\n').
