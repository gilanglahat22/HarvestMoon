dig :-
    gameStarted,
    (currentPosition(X,Y),isNormalTile(X,Y),
    write('You digged the tile.\n'),
    assertz(tileType(X,Y,'D')),
    farmingEnergy(Energy),
    reduceEnergy(Energy),!;
    currentPosition(X,Y),\+ isNormalTile(X,Y),
    write('You cannot dig this tile!\n'),!),
    exhaustedEnergyAction,
    printLowEnergyMsg.

plant :-
    gameStarted,
    currentPosition(X,Y),
    (isDiggedTile(X,Y),
    write('You have:\n'),
    stock('carrot_seed',JUMLAH_CARROT),write('- '),write(JUMLAH_CARROT),write(' carrot seed'),nl,
    stock('corn_seed',JUMLAH_CORN),write('- '),write(JUMLAH_CORN),write(' corn seed'),nl,
    stock('tomato_seed',JUMLAH_TOMATO),write('- '),write(JUMLAH_TOMATO),write(' tomato seed'),nl,
    stock('potato_seed',JUMLAH_POTATO),write('- '),write(JUMLAH_POTATO),write(' potato seed'),nl,
    write('What do you want to plant?\n'),
    write('| ?- '), read(DITANAM),
    atom_concat(DITANAM,'_seed',DITANAM_SEED),
    stock(DITANAM_SEED,STOK),
    (STOK>0,
    subtractInven(1,DITANAM_SEED),
    write('You planted a '), write(DITANAM), write(' seed\n'),
    plantSymbol(SIMBOL,DITANAM),
    changeCurrentTile(SIMBOL),
    durasiTanam(DITANAM, DURASI),
    day(HARIINI),
    WAKTUPANEN is HARIINI+DURASI,
    assertz(waktuPanen(X,Y,WAKTUPANEN)),
    farmingEnergy(Energy),
    reduceEnergy(Energy),!;
    STOK is 0, write('You don\'t have enough seed!\n')),!;
    isPlantTile(X,Y,_),write('You have planted this tile!\n'),!;
    \+isDiggedTile(X,Y),write('You have not digged this tile!\n')),
    exhaustedEnergyAction,
    printLowEnergyMsg, !.

harvest :-
    gameStarted,
    currentPosition(X,Y),
    (isPlantTile(X,Y,SIMBOL),
    plantSymbol(SIMBOL,TANAMAN),
    waktuPanen(X,Y,WAKTUPANEN),
    day(HARIINI),
    (WAKTUPANEN=<HARIINI,
    write('You harvested '),write(TANAMAN),write('.'),nl,
    retract(waktuPanen(X,Y,WAKTUPANEN)),
    retract(tileType(X,Y,SIMBOL)),
    tambahanEXP(SIMBOL,POIN),
    isFarmer(POIN),
    (SIMBOL=='c',addInven(1, 'corn');
    SIMBOL=='C',addInven(1, 'carrot');
    SIMBOL=='p',addInven(1, 'potato');
    SIMBOL=='T',addInven(1, 'tomato')),
    (isQuestActive(true),
    activeQuest(HARVEST,FISH,RANCH),
    SISA is HARVEST-1,
    retract(activeQuest(HARVEST,FISH,RANCH)),
    assertz(activeQuest(SISA,FISH,RANCH)),
    cekApakahQuestSelesai(_);
    isQuestActive(false)),
    farmingEnergy(Energy),
    reduceEnergy(Energy),!;
    WAKTUPANEN>HARIINI,
    write('You cannot harvest it today!\n'),!),!;
    \+ isPlantTile(X,Y,SIMBOL),write('You don\'t have a plant here!\n'),!),
    exhaustedEnergyAction,
    printLowEnergyMsg, !.