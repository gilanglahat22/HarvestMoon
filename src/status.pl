status :-
    gameStarted,
    player(_,Level,Exp,LevelFarming,ExpFarming,LevelFishing,ExpFishing,LevelRanching,ExpRanching,Gold),
    energy(Energy),
    maxEnergy(MaxEnergy),
    write('Your status:'), nl,
    writeJob, nl,
    format('Level          : ~d', [Level]), nl,
    format('Exp            : ~d/~d', [Exp, 300*Level]), nl,
    format('Level farming  : ~d', [LevelFarming]), nl,
    format('Exp farming    : ~d/~d', [ExpFarming, 100*LevelFarming]), nl,
    format('Level fishing  : ~d', [LevelFishing]), nl,
    format('Exp fishing    : ~d/~d', [ExpFishing, 100*LevelFishing]), nl,
    format('Level ranching : ~d', [LevelRanching]), nl,
    format('Exp ranching   : ~d/~d', [ExpRanching, 100*LevelRanching]), nl,
    format('Gold           : ~d', [Gold]), nl,
    format('Energy         : ~d/~d', [Energy, MaxEnergy]), nl.

writeJob :-
    player(Job,_,_,_,_,_,_,_,_,_),
    Job == fisherman,
    write('Job            : Fisherman'), !.

writeJob :-
    player(Job,_,_,_,_,_,_,_,_,_),
    Job == farmer,
    write('Job            : Farmer'), !.

writeJob :-
    player(Job,_,_,_,_,_,_,_,_,_),
    Job == rancher,
    write('Job            : Rancher'), !.

% semua yang berkaitan dengan gold
addGold(X) :-
    player(Job,Level,Exp,LevelFarming,ExpFarming,LevelFishing,ExpFishing,LevelRanching,ExpRanching,Gold),
    NewGold is Gold + X,
    retract(player(Job,Level,Exp,LevelFarming,ExpFarming,LevelFishing,ExpFishing,LevelRanching,ExpRanching,Gold)),
    assertz(player(Job,Level,Exp,LevelFarming,ExpFarming,LevelFishing,ExpFishing,LevelRanching,ExpRanching,NewGold)),
    checkGold(_), !.

subtractGold(X) :-
    player(Job,Level,Exp,LevelFarming,ExpFarming,LevelFishing,ExpFishing,LevelRanching,ExpRanching,Gold),
    NewGold is Gold - X,
    retract(player(Job,Level,Exp,LevelFarming,ExpFarming,LevelFishing,ExpFishing,LevelRanching,ExpRanching,Gold)),
    assertz(player(Job,Level,Exp,LevelFarming,ExpFarming,LevelFishing,ExpFishing,LevelRanching,ExpRanching,NewGold)).

checkGold(0) :-
    player(_,_,_,_,_,_,_,_,_,Gold),
    Gold < 20000.

checkGold(1) :-
    player(_,_,_,_,_,_,_,_,_,Gold),
    Gold >= 20000,
    win.

% cek day
checkDay(0) :-
    day(X),
    X =< 50.

checkDay(1) :-
    day(X),
    X > 50,
    lose.

% end game
win :-
    write('\nCongratulations! You have finally collected 20000 golds!\n'),
    exit.

lose :-
    write('\nYou have worked hard, but in the end result is all that matters.'), nl,
    write('May God bless you in the future with kind people!\n'),
    exit.

% sistem level up untuk level overall
addExp(X) :-
    player(Job,Level,Exp,LevelFarming,ExpFarming,LevelFishing,ExpFishing,LevelRanching,ExpRanching,Gold),
    NewExp is Exp + X,
    retract(player(Job,Level,Exp,LevelFarming,ExpFarming,LevelFishing,ExpFishing,LevelRanching,ExpRanching,Gold)),
    assertz(player(Job,Level,NewExp,LevelFarming,ExpFarming,LevelFishing,ExpFishing,LevelRanching,ExpRanching,Gold)),
    checkLevelUp(_), !.

checkLevelUp(0) :-
    player(_,Level,Exp,_,_,_,_,_,_,_),
    Exp < 300 * Level.

checkLevelUp(1) :-
    player(_,Level,Exp,_,_,_,_,_,_,_),
    Exp >= 300 * Level,
    levelUp.

levelUp :-
    player(Job,Level,Exp,LevelFarming,ExpFarming,LevelFishing,ExpFishing,LevelRanching,ExpRanching,Gold),
    write('\nLEVEL UP!\n'),
    NewLevel is Level + 1,
    NewExp is Exp - (300 * Level),
    retract(player(Job,Level,Exp,LevelFarming,ExpFarming,LevelFishing,ExpFishing,LevelRanching,ExpRanching,Gold)),
    assertz(player(Job,NewLevel,NewExp,LevelFarming,ExpFarming,LevelFishing,ExpFishing,LevelRanching,ExpRanching,Gold)),
    addMaxEnergy(20).

% sistem level up untuk level farming
addExpFarming(X) :-
    player(Job,Level,Exp,LevelFarming,ExpFarming,LevelFishing,ExpFishing,LevelRanching,ExpRanching,Gold),
    NewExpFarming is ExpFarming + X,
    retract(player(Job,Level,Exp,LevelFarming,ExpFarming,LevelFishing,ExpFishing,LevelRanching,ExpRanching,Gold)),
    assertz(player(Job,Level,Exp,LevelFarming,NewExpFarming,LevelFishing,ExpFishing,LevelRanching,ExpRanching,Gold)),
    checkLevelFarmingUp(_), !.

checkLevelFarmingUp(0) :-
    player(_,_,_,LevelFarming,ExpFarming,_,_,_,_,_),
    ExpFarming < 100 * LevelFarming.

checkLevelFarmingUp(1) :-
    player(_,_,_,LevelFarming,ExpFarming,_,_,_,_,_),
    ExpFarming >= 100 * LevelFarming,
    levelFarmingUp.

levelFarmingUp :-
    player(Job,Level,Exp,LevelFarming,ExpFarming,LevelFishing,ExpFishing,LevelRanching,ExpRanching,Gold),
    write('\nLEVEL FARMING UP!\n'),
    NewLevelFarming is LevelFarming + 1,
    NewExpFarming is ExpFarming - (100 * LevelFarming),
    retract(player(Job,Level,Exp,LevelFarming,ExpFarming,LevelFishing,ExpFishing,LevelRanching,ExpRanching,Gold)),
    assertz(player(Job,Level,Exp,NewLevelFarming,NewExpFarming,LevelFishing,ExpFishing,LevelRanching,ExpRanching,Gold)).

% sistem level up untuk level fishing
addExpFishing(X) :-
    player(Job,Level,Exp,LevelFarming,ExpFarming,LevelFishing,ExpFishing,LevelRanching,ExpRanching,Gold),
    NewExpFishing is ExpFishing + X,
    retract(player(Job,Level,Exp,LevelFarming,ExpFarming,LevelFishing,ExpFishing,LevelRanching,ExpRanching,Gold)),
    assertz(player(Job,Level,Exp,LevelFarming,ExpFarming,LevelFishing,NewExpFishing,LevelRanching,ExpRanching,Gold)),
    checkLevelFishingUp(_), !.

checkLevelFishingUp(0) :-
    player(_,_,_,_,_,LevelFishing,ExpFishing,_,_,_),
    ExpFishing < 100 * LevelFishing.

checkLevelFishingUp(1) :-
    player(_,_,_,_,_,LevelFishing,ExpFishing,_,_,_),
    ExpFishing >= 100 * LevelFishing,
    levelFishingUp.

levelFishingUp :-
    player(Job,Level,Exp,LevelFarming,ExpFarming,LevelFishing,ExpFishing,LevelRanching,ExpRanching,Gold),
    write('\nLEVEL FISHING UP!\n'),
    NewLevelFishing is LevelFishing + 1,
    NewExpFishing is ExpFishing - (100 * LevelFishing),
    retract(player(Job,Level,Exp,LevelFarming,ExpFarming,LevelFishing,ExpFishing,LevelRanching,ExpRanching,Gold)),
    assertz(player(Job,Level,Exp,LevelFarming,ExpFarming,NewLevelFishing,NewExpFishing,LevelRanching,ExpRanching,Gold)).

% sistem level up untuk level ranching
addExpRanching(X) :-
    player(Job,Level,Exp,LevelFarming,ExpFarming,LevelFishing,ExpFishing,LevelRanching,ExpRanching,Gold),
    NewExpRanching is ExpRanching + X,
    retract(player(Job,Level,Exp,LevelFarming,ExpFarming,LevelFishing,ExpFishing,LevelRanching,ExpRanching,Gold)),
    assertz(player(Job,Level,Exp,LevelFarming,ExpFarming,LevelFishing,ExpFishing,LevelRanching,NewExpRanching,Gold)),
    checkLevelRanchingUp(_), !.

checkLevelRanchingUp(0) :-
    player(_,_,_,_,_,_,_,LevelRanching,ExpRanching,_),
    ExpRanching < 100 * LevelRanching.

checkLevelRanchingUp(1) :-
    player(_,_,_,_,_,_,_,LevelRanching,ExpRanching,_),
    ExpRanching >= 100 * LevelRanching,
    levelRanchingUp.

levelRanchingUp :-
    player(Job,Level,Exp,LevelFarming,ExpFarming,LevelFishing,ExpFishing,LevelRanching,ExpRanching,Gold),
    write('\nLEVEL RANCHING UP!\n'),
    NewLevelRanching is LevelRanching + 1,
    NewExpRanching is ExpRanching - (100 * LevelRanching),
    retract(player(Job,Level,Exp,LevelFarming,ExpFarming,LevelFishing,ExpFishing,LevelRanching,ExpRanching,Gold)),
    assertz(player(Job,Level,Exp,LevelFarming,ExpFarming,LevelFishing,ExpFishing,NewLevelRanching,NewExpRanching,Gold)).

% specialty advantage
isFisherman(X) :-
    (player(fisherman,_,_,_,_,_,_,_,_,_), write('\nYOU GOT DOUBLE EXP!\n'), XX is 2 * X, addExpFishing(XX), addExp(XX);
    \+player(fisherman,_,_,_,_,_,_,_,_,_), addExpFishing(X), addExp(X)).

isFarmer(X) :-
    (player(farmer,_,_,_,_,_,_,_,_,_), write('\nYOU GOT DOUBLE EXP!\n'), XX is 2 * X, addExpFarming(XX), addExp(XX);
    \+player(farmer,_,_,_,_,_,_,_,_,_), addExpFarming(X), addExp(X)).

isRancher(X) :-
    (player(rancher,_,_,_,_,_,_,_,_,_), write('\nYOU GOT DOUBLE EXP!\n'), XX is 2 * X, addExpRanching(XX), addExp(XX);
    \+player(rancher,_,_,_,_,_,_,_,_,_), addExpRanching(X), addExp(X)).