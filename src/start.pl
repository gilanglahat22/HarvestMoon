start :-
    gameStarteda,
    \+ gameStarted,
    write('Welcome to Harvest Star. Choose your job'), nl,
    write('1. Fisherman'), nl,
    write('2. Farmer'), nl,
    write('3. Rancher'), nl,
    write('> '), read(Input),
    writeNumJob(Input).

writeNumJob(1) :-
    write('You choose Fisherman, let\'s start farming\n'),
    write('You have to get 20000 golds in 50 days\n'),
    write('Good Luck!\n'),
    assertz(player(fisherman,1,0,1,0,1,0,1,0,500)),
    assertz(gameStarted), !.
writeNumJob(2) :-
    write('You choose Farmer, let\'s start farming\n'),
    write('You have to get 20000 golds in 50 days\n'),
    write('Good Luck!\n'),
    assertz(player(farmer,1,0,1,0,1,0,1,0,500)),
    assertz(gameStarted), !.
writeNumJob(3) :-
    write('You choose Rancher, let\'s start farming\n'),
    write('You have to get 20000 golds in 50 days\n'),
    write('Good Luck!\n'),
    assertz(player(rancher,1,0,1,0,1,0,1,0,500)),
    assertz(gameStarted), !.
writeNumJob(_) :-
    write('Invalid input\n').