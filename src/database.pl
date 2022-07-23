/*FILE BERISI FACT UTAMA*/

/*Cek game sudah dimulai atau belum*/
:- dynamic(gameStarteda/0).
:- dynamic(gameStarted/0).

/*PLAYER*/
/*player(Job,Level,Exp,LevelFarming,ExpFarming,LevelFishing,ExpFishing,LevelRanching,ExpRanching,Gold)*/
:- dynamic(player/10).

/* Atribut energy */
:- dynamic(energy/1).
energy(200).
:- dynamic(maxEnergy/1).
maxEnergy(200).
:- dynamic(fishingEnergy/1).
fishingEnergy(10).
:- dynamic(farmingEnergy/1).
farmingEnergy(5).

/*POSISI*/
:- dynamic(currentPosition/2).

/*HARI*/
:- dynamic(day/1).
day(1).

/*ISI DIARY*/
:- dynamic(isiDiary/2).

/*QUEST*/
:- dynamic(isQuestActive/1).
:- dynamic(activeQuest/3).
:- dynamic(reward/3).
isQuestActive(false).

/*FARMING*/
:- dynamic(waktuPanen/3).
plantSymbol('C','carrot').
plantSymbol('T','tomato').
plantSymbol('c','corn').
plantSymbol('p','potato').
durasiTanam('carrot',1).
durasiTanam('tomato',2).
durasiTanam('corn',3).
durasiTanam('potato',4).
tambahanEXP('C',10).
tambahanEXP('T',20).
tambahanEXP('c',30).
tambahanEXP('p',40).

/*MARKETPLACE DAN RANCH*/
:- dynamic(carrot/1).
:- dynamic(tomato/1).
:- dynamic(corn/1).
:- dynamic(potato/1).
:- dynamic(chicken/1).
:- dynamic(sheep/1).
:- dynamic(cow/1).
:- dynamic(shovel_level/1).
:- dynamic(fishing_rod_level/1).
:- dynamic(chicken_egg/1).
:- dynamic(wool_sheep/1).
:- dynamic(milk_cow/1).
:- dynamic(stockBiji/2).
:- dynamic(cupang/1).
:- dynamic(lele/1).
:- dynamic(tongkol/1).
:- dynamic(bandeng/1).
:- dynamic(cakalang/1).
:- dynamic(gurame/1).
:- dynamic(kakap/1).
:- dynamic(tuna/1).
:- dynamic(salmon/1).
:- dynamic(megalodon/1).
:- dynamic(stock/2).
/* Stock di Inventory */

stock('carrot_seed', 2).
stock('tomato_seed', 2).
stock('corn_seed', 2).
stock('potato_seed', 2).
stock('carrot', 0).
stock('tomato', 0).
stock('corn', 0).
stock('potato', 0).
stock('chicken', 3).
stock('sheep', 2).
stock('cow', 1).
stock('shovel', 1).
stock('fishing_rod', 1).
stock('chicken_egg', 0).
stock('wool_sheep', 0).
stock('milk_cow', 0).
stock('cupang', 0).
stock('lele', 0).
stock('tongkol', 0).
stock('bandeng', 0).
stock('cakalang', 0).
stock('gurame', 0).
stock('kakap', 0).
stock('tuna', 0).
stock('salmon', 0).
stock('megalodon', 0).

/* Harga Item Beli*/
cost('carrot_seed', 20).
cost('tomato_seed', 40).
cost('corn_seed', 60).
cost('potato_seed', 80).
cost('chicken', 500).
cost('sheep', 1000).
cost('cow', 1500).
cost('fishing_rod', X) :-
    stock('fishing_rod', LevelfishingRod), LevelfishingRod =:= 5, !, X is 99999. 
cost('fishing_rod', X) :-
    stock('fishing_rod', LevelfishingRod), LevelUpFishingRod is LevelfishingRod + 1, X is 150 * (LevelUpFishingRod).
cost('shovel', X) :-
    stock('shovel', LevelShovel), LevelShovel =:= 3, !, X is 99999.
cost('shovel', X) :-
    stock('shovel', LevelShovel), LevelUpshovel is LevelShovel + 1, X is 250 * (LevelUpshovel)
. 

/* Harga Item Jual */
costSell('carrot_seed', 10).
costSell('tomato_seed', 20).
costSell('corn_seed', 30).
costSell('potato_seed', 40).
costSell('carrot', 50).
costSell('tomato', 100).
costSell('corn', 150).
costSell('potato', 200).
costSell('chicken', 250).
costSell('sheep', 500).
costSell('cow', 750).
costSell('egg', 50).
costSell('wool', 100).
costSell('milk', 150).
costSell('cupang', 5).
costSell('lele', 10).
costSell('tongkol', 15).
costSell('bandeng', 20).
costSell('cakalang', 25).
costSell('gurame', 30).
costSell('kakap', 35).
costSell('tuna', 40).
costSell('salmon', 45).
costSell('megalodon', 100).

/* INVENTORY */
:- dynamic(count_inventory/1).
count_inventory(16).

/*MAP*/
/*Semua koordinat lokasi penting disimpan di sini*/
/*Koordinat pojok kiri bawah adalah (1,1)*/
:- dynamic(tileType/3).

tileType(2,2,'H').
tileType(3,6,'R').
tileType(11,2,'M').
tileType(10,8,'Q').

tileType(5,1,'o').
tileType(6,1,'o').
tileType(7,1,'o').
tileType(6,2,'o').
tileType(7,2,'o').
tileType(7,3,'o').
tileType(8,3,'o').
tileType(5,4,'o').
tileType(6,4,'o').
tileType(7,4,'o').
tileType(6,5,'o').

tileType(1,10,'o').
tileType(2,10,'o').
tileType(3,10,'o').
tileType(1,9,'o').
tileType(2,9,'o').
tileType(3,9,'o').
tileType(4,9,'o').
tileType(1,8,'o').
tileType(2,8,'o').
tileType(1,7,'o').

mapDimension(15,10).
currentPosition(1,1).
