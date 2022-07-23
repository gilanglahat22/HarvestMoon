/* Command map */
map :-
    gameStarted,
    mapDimension(X,Y),
    printHorizontalWall(X),
    nl,
    printMapContents(X,Y),
    printHorizontalWall(X),
    nl,
    !.

/* Menampilkan tembok horizontal pada map */
printHorizontalWall(0) :- 
    write('##').
printHorizontalWall(X) :-
    write('#'),
    X2 is X - 1, 
    printHorizontalWall(X2).

/* Menampilkan isi map */
printMapContents(_,0).
printMapContents(X,Y) :-
    write('#'),
    printRowContents(X,Y),
    write('#'),
    nl,
    Y2 is Y - 1,
    printMapContents(X,Y2).

/* Menampilkan isi 1 baris map */
printRowContents(0,_).
printRowContents(X,Y) :-
    mapDimension(XMax,_),
    XCoor is XMax - X + 1,
    printMapSymbol(XCoor,Y),
    X2 is X - 1,
    printRowContents(X2,Y).

/* Menampilkan simbol suatu koordinat */
printMapSymbol(X,Y) :-
    currentPosition(XC,YC),
    X = XC,
    Y = YC,
    !,
    write('P').
printMapSymbol(X,Y) :-
    isDiggedTile(X,Y),
    !,
    write('=').
printMapSymbol(X,Y) :-
    isNormalTile(X,Y),
    !,
    write('-').
printMapSymbol(X,Y) :-
    tileType(X,Y,Symbol),
    write(Symbol).


isCarrotTile(X,Y) :-
    tileType(X,Y,Symbol),
    Symbol = 'C'.
isCornTile(X,Y) :-
    tileType(X,Y,Symbol),
    Symbol = 'c'.
isPotatoTile(X,Y) :-
    tileType(X,Y,Symbol),
    Symbol = 'p'.
isTomatoTile(X,Y) :-
    tileType(X,Y,Symbol),
    Symbol = 'T'.

/* Mengganti jenis tile yang sedang ditempati saat ini */
changeCurrentTile(Type) :-
    currentPosition(X,Y),
    retract(tileType(X,Y,_)),
    assertz(tileType(X,Y,Type)).

/* Mengganti jenis tile di suatu koordinat */
changeTileType(X,Y,Type) :-
    retract(tileType(X,Y,_)),
    assertz(tileType(X,Y,Type)).
changeTileType(X,Y,Type) :-
    isNormalTile(X,Y),
    assertz(tileType(X,Y,Type)).

/*Rule untuk mengetahui jenis tile suatu koordinat*/
isMarketplace(X,Y) :- 
    tileType(X,Y,Symbol), 
    Symbol = 'M'.

isRanch(X,Y) :-
    tileType(X,Y,Symbol),
    Symbol = 'R'.

isHouse(X,Y) :-
    tileType(X,Y,Symbol),
    Symbol = 'H'.

isTempatQuest(X,Y) :-
    tileType(X,Y,Symbol),
    Symbol = 'Q'.

isTileAir(X,Y) :-
    tileType(X,Y,Symbol),
    Symbol = 'o'.

isDiggedTile(X,Y) :-
    tileType(X,Y,Symbol),
    Symbol = 'D'.

isPlantTile(X,Y,PlantType) :-
    tileType(X,Y,Symbol),
    Symbol = PlantType.

isNormalTile(X,Y) :-
    \+ tileType(X,Y,_).

isNearTileAir(X,Y) :-
    YW is Y + 1,
    isTileAir(X,YW), !.
isNearTileAir(X,Y) :-
    XA is X - 1,
    isTileAir(XA,Y), !.
isNearTileAir(X,Y) :-
    YS is Y - 1,
    isTileAir(X,YS), !.
isNearTileAir(X,Y) :-
    XD is X + 1,
    isTileAir(XD,Y), !.