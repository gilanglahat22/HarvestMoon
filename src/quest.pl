quest :-
    gameStarted,
    ((currentPosition(X,Y),
    isTempatQuest(X,Y),
    isQuestActive(false),
    retract(isQuestActive(false)),
    assertz(isQuestActive(true)),
    random(0,6,A),
    random(0,6,B),
    random(0,6,C),
    write('You got a new quest!\n\nYou need to collect:\n'),
    write('- '),write(A),write(' harvest item\n'),
    write('- '),write(B),write(' fish\n'),
    write('- '),write(C),write(' ranch item\n'),
    assertz(activeQuest(A,B,C)),
    I is 10 * A,
    J is 10 * B,
    K is 10 * C,
    assertz(reward(I,J,K)), !),!;
    (currentPosition(X,Y),
    isTempatQuest(X,Y),
    isQuestActive(true),
    write('You have an on-going quest!\n')),!;
    write('There is no quest here!\n')).

cekApakahQuestSelesai(1) :-
    activeQuest(X,Y,Z),
    X=<0,
    Y=<0,
    Z=<0,
    reward(A,B,C),
    BonusExp is A + B + C,
    addExp(BonusExp),
    BonusGold is 3 * BonusExp,
    addGold(BonusGold),
    write('\nQUEST COMPLETE!\n'),
    format('You got ~d Gold and ~d Exp', [BonusGold, BonusExp]), nl,
    retract(reward(_,_,_)),
    retract(activeQuest(_,_,_)),
    retract(isQuestActive(true)),
    assertz(isQuestActive(false)).

cekApakahQuestSelesai(0) :-
    activeQuest(X,Y,Z),
    (X>0; Y>0; Z>0).