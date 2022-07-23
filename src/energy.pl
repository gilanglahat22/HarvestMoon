/* Fungsi-fungsi pembantu terkait energy */

/* Mengurangi energy pemain */
reduceEnergy(Reduced) :-
    energy(Energy),
    NewEnergy is Energy - Reduced,
    retract(energy(_)),
    assertz(energy(NewEnergy)).

/* Menambahkan maxEnergy pemain sebanyak Added */
addMaxEnergy(Added) :-
    maxEnergy(MaxEnergy),
    NewMaxVit is MaxEnergy + Added,
    retract(maxEnergy(_)),
    assertz(maxEnergy(NewMaxVit)).

/* Mengeset energy menjadi maxEnergy */
replenishEnergy :-
    maxEnergy(MaxEnergy),
    retract(energy(_)),
    assertz(energy(MaxEnergy)).

/* Menampilkan pesan saat energy rendah */
printLowEnergyMsg :-
    energy(Energy),
    Energy =< 50,
    format('\nYou are exhausted! ~d energy left. Sleep at your house to replenish your energy!', [Energy]),
    nl.
printLowEnergyMsg.

/* Mengurangi kebutuhan energi untuk melakukan fishing atau dig */
decreaseEnergyReq('fishing_rod') :-
    fishingEnergy(Energy),
    NewEnergy is Energy - 1,
    retract(fishingEnergy(_)),
    assertz(fishingEnergy(NewEnergy)).
decreaseEnergyReq('shovel') :-
    farmingEnergy(Energy),
    NewEnergy is Energy - 1,
    retract(farmingEnergy(_)),
    assertz(farmingEnergy(NewEnergy)).

/* Aksi saat energy mencapai <= 0 */
/* Saat energy mencapai <= 0, pemain akan dipindahkan secara otomatis ke House */
/* Pemain akan dikenakan denda sebesar jarak * 10 atau seluruh uang jika tidak mencukupi */
exhaustedEnergyAction :-
    energy(Energy),
    Energy =< 0,
    currentPosition(X,Y),
    isHouse(X,Y),
    write('\nYou are completely exhausted! You fell asleep right when you stepped into your house.\n'),
    houseOption(sleep),
    !,
    fail.
exhaustedEnergyAction :-
    energy(Energy),
    Energy =< 0,
    currentPosition(X,Y),
    player(_,_,_,_,_,_,_,_,_,Gold),
    Gold > 0,
    tileType(XHouse,YHouse,'H'),
    Fine is min(Gold, (abs(XHouse-X) + abs(YHouse-Y)) * 5),
    subtractGold(Fine),
    retract(currentPosition(_,_)),
    assertz(currentPosition(XHouse,YHouse)),
    write('\nYou are completely exhausted! You fell asleep on the road.'),
    nl,
    format('Someone brought you back to your house, but took ~d gold out of your pocket.\n', [Fine]),
    houseOption(sleep),
    !,
    fail.
exhaustedEnergyAction :-
    energy(Energy),
    Energy =< 0,
    player(_,_,_,_,_,_,_,_,_,Gold),
    Gold =:= 0,
    tileType(XHouse,YHouse,'H'),
    retract(currentPosition(_,_)),
    assertz(currentPosition(XHouse,YHouse)),
    write('\nYou are completely exhausted! You fell asleep on the road.'),
    nl,
    write('Someone brought you back to your house. He checked your pocket but it seems that you are broke.'),
    nl,
    write('Out of pity, he brought you back to your house for free.\n'),
    houseOption(sleep),
    !,
    fail.
exhaustedEnergyAction.