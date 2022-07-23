/* Primitif yang diperlukan */

ganti_fact(OldFact, NewFact) :-
call(OldFact), retract(OldFact), assertz(NewFact)
. 

addInven(X, Item) :-
    stock(Item, Stock_Lama), Stock_baru is Stock_Lama + X, count_inventory(Y), Z is X + Y, (Z =< 100, ganti_fact(count_inventory(Y), count_inventory(Z)), ganti_fact(stock(Item, Stock_Lama), stock(Item, Stock_baru))).

subtractInven(X, Item) :-
    stock(Item, Stock_Lama), Stock_baru is Stock_Lama - X, count_inventory(Y), Z is Y - X, (Z >= 0, Stock_baru >= 0, ganti_fact(count_inventory(Y), count_inventory(Z)), ganti_fact(stock(Item, Stock_Lama), stock(Item, Stock_baru))).

throwItem(Throw) :-
    stock(Throw, X), write('You have '), write(X),write(' '), write(Throw), write('.'), nl, write('How many do you want to throw ? '), nl, write('> '), read(Numbers_want_toThrow), ((Numbers_want_toThrow =< X, subtractInven(Numbers_want_toThrow, Throw), write('You threw away '), write(Numbers_want_toThrow), write(' '), write(Throw)); (write('You don''t have enough '), write(Throw), write(' to throw'))), nl
. 

throwItem :-
    gameStarted, inventory, nl, write('What do you want to throw ?'), nl, write('> '), read(Throw), throwItem(Throw), !
. 

buy_item(Item, Gold, Sum_Cost) :-
    stock(Item, Level_awal), cost(Item, Coast), ((((Item == 'fishing_rod'); (Item == 'shovel')), Level_Akhir is Level_awal + 1, ((Gold >= Coast, Sum_Cost is Coast, ganti_fact(stock(Item, Level_awal), stock(Item, Level_Akhir)), decreaseEnergyReq(Item), write('You are upgraded level of'), write(' '), write(Item), nl, write('You are charged '), write(Sum_Cost), write(' golds'), nl); (Sum_Cost is 0, write('You don''t have enough gold to upgrade level'), nl))); (((Item \== 'fishing_rod'),(Item \== 'shovel'),(Item \== 'keluar')),write('How many do you want to buy ?'), nl, write('| ?- '), read(Numbers_to_buy), Sum_Cost is Numbers_to_buy * Coast, ((Gold >= Sum_Cost, addInven(Numbers_to_buy, Item), write('You have bought '), write(Numbers_to_buy), write(' '), write(Item), nl, write('You are charged '), write(Sum_Cost), write(' golds'), nl); (write('You don''t have enough gold to buy'), Sum_Cost is 0))),!)
. 
sell_item(Item, Sum_Cost) :-
    ((Item == 'exitSell', Sum_Cost is 0, market, !);
    (stock(Item, Stock_item), costSell(Item, Coast), ((Stock_item =:= 0, write('The item is not available'), Sum_Cost is 0); (write('How many do you want to sell ?'), nl, write('| ?- '), read(TheNumbers), Sum_Cost is Coast * TheNumbers, ((Stock_item >= TheNumbers, subtractInven(TheNumbers, Item), write('You sold '), write(TheNumbers), write(' '), write(Item), write('.'), nl, write('You received '), write(Sum_Cost), write(' golds.\n')); (Sum_Cost is 0, write('Your '), write(Item), write(' does''nt enough to sell'), nl))))),!)
. 

commandInt_Tostr(The_Number, Item) :-
    ((The_Number =:= 1, Item = 'carrot_seed'); (The_Number =:= 2, Item = 'corn_seed'); (The_Number =:= 3, Item = 'tomato_seed'); (The_Number =:= 4, Item = 'potato_seed'); (The_Number =:= 5, Item = 'chicken'); (The_Number =:= 6, Item = 'sheep'); (The_Number =:= 7, Item = 'cow'); (The_Number =:= 8, Item = 'shovel'); (The_Number =:= 9, Item = 'fishing_rod'); (The_Number =:= 0, Item = 'keluar', market, !))
.

input(Command) :-
    write('| ?- '), read(Inputan), Command = Inputan
. 

exitMarket :-
    gameStarted,
    write('Thanks for coming to market.\n'), !
. 

exitRanch :-
    gameStarted,
    write('Thanks for coming to ranch.\n'), !
. 

/* Main Fungsi*/

inventory :-
    gameStarted, stock('chicken', Numbers_chicken), stock('sheep', Numbers_sheep), stock('cow', Numbers_cow), stock('corn_seed', Numbers_cornSeed), stock('carrot_seed', Numbers_carrotSeed), stock('potato_seed', Numbers_potatoSeed), stock('tomato_seed', Numbers_tomatoSeed), stock('corn', Numbers_corn), stock('carrot', Numbers_carrot), stock('tomato', Numbers_tomato), stock('potato', Numbers_potato), stock('shovel', Shovel_level), stock('fishing_rod', FishingRod_level), stock('chicken_egg', Numbers_egg), stock('milk_cow', Numbers_milk), stock('wool_sheep', Numbers_wool), stock('cupang', Numbers_cupang), stock('lele', Numbers_lele), stock('tongkol', Numbers_tongkol), stock('bandeng', Numbers_bandeng), stock('cakalang', Numbers_cakalang), stock('gurame', Numbers_gurame), stock('kakap', Numbers_kakap), stock('tuna', Numbers_tuna), stock('salmon', Numbers_salmon), stock('megalodon', Numbers_megalodon), count_inventory(Numbers_inventory),
    write('[]****************** Your inventory ('), write(Numbers_inventory), write(' / 100) ****************[]'), nl,
    write('                                                      '), nl,
    ((Numbers_carrotSeed > 0, write('                  - '), write(Numbers_carrotSeed), write(' carrot_seed                                      '), nl); Numbers_carrotSeed == 0, write('')),
    ((Numbers_cornSeed > 0, write('                  - '), write(Numbers_cornSeed), write(' corn_seed                                             '), nl);
    Numbers_cornSeed == 0, write('')),
    ((Numbers_tomatoSeed > 0, write('                  - '), write(Numbers_tomatoSeed), write(' tomato_seed                                      '), nl);
    Numbers_tomatoSeed == 0, write('')),
    ((Numbers_potatoSeed > 0, write('                  - '), write(Numbers_potatoSeed), write(' potato_seed                                      '), nl);
    Numbers_potatoSeed == 0, write('')),
    ((Numbers_carrot > 0, write('                  - '), write(Numbers_carrot), write(' carrot                                       '), nl); Numbers_carrot == 0, write('')),
    ((Numbers_corn > 0, write('                  - '), write(Numbers_corn), write(' corn                                             '), nl);
    Numbers_corn == 0, write('')),
    ((Numbers_tomato > 0, write('                  - '), write(Numbers_tomato), write(' tomato                                       '), nl);
    Numbers_tomato == 0, write('')),
    ((Numbers_potato > 0, write('                  - '), write(Numbers_potato), write(' potato                                       '), nl);
    Numbers_potato == 0, write('')),
    (write('                  - '), write('Level_'), write(Shovel_level), write('_of_shovel                       '), nl),
    (write('                  - '), write('Level_'), write(FishingRod_level), write('_fishing_rod          '), nl),
    ((Numbers_chicken > 0, write('                  - '), write(Numbers_chicken), write(' chicken                                       '), nl);
    Numbers_chicken == 0, write('')),
    ((Numbers_sheep > 0, write('                  - '), write(Numbers_sheep), write(' sheep                                       '), nl);
    Numbers_sheep == 0, write('')),
    ((Numbers_cow > 0, write('                  - '), write(Numbers_cow), write(' cow                                       '), nl);
    Numbers_cow == 0, write('')),
    ((Numbers_egg > 0, write('                  - '), write(Numbers_egg), write(' egg                                                '), nl);
    Numbers_egg == 0, write('')),
    ((Numbers_milk > 0, write('                  - '), write(Numbers_milk), write(' liter_of_milk                                    '), nl);
    Numbers_milk == 0, write('')),
    ((Numbers_wool > 0, write('                  - '), write(Numbers_wool), write(' wool                                             '), nl);
    Numbers_wool == 0, write('')),
    ((Numbers_cupang > 0, write('                  - '), write(Numbers_cupang), write(' cupang                                             '), nl);
    Numbers_cupang == 0, write('')),
    ((Numbers_lele > 0, write('                  - '), write(Numbers_lele), write(' lele                                             '), nl);
    Numbers_lele == 0, write('')),
    ((Numbers_tongkol > 0, write('                  - '), write(Numbers_tongkol), write(' tongkol                                             '), nl);
    Numbers_tongkol == 0, write('')),
    ((Numbers_bandeng > 0, write('                  - '), write(Numbers_bandeng), write(' bandeng                                             '), nl);
    Numbers_bandeng == 0, write('')),
    ((Numbers_cakalang > 0, write('                  - '), write(Numbers_cakalang), write(' cakalang                                             '), nl);
    Numbers_cakalang == 0, write('')),
    ((Numbers_gurame > 0, write('                  - '), write(Numbers_gurame), write(' gurame                                             '), nl);
    Numbers_gurame == 0, write('')),
    ((Numbers_kakap > 0, write('                  - '), write(Numbers_kakap), write(' kakap                                             '), nl);
    Numbers_kakap == 0, write('')),
    ((Numbers_tuna > 0, write('                  - '), write(Numbers_tuna), write(' tuna                                             '), nl);
    Numbers_tuna == 0, write('')),
    ((Numbers_salmon > 0, write('                  - '), write(Numbers_salmon), write(' salmon                                             '), nl);
    Numbers_salmon == 0, write('')),
    ((Numbers_megalodon > 0, write('                  - '), write(Numbers_megalodon), write(' megalodon                                             '), nl);
    Numbers_megalodon == 0, write('')),
    (write('                                                      '), nl),
    write('[]*************************************************************[]'), !.


market :- /* Command dilakukan ketika berada di tile M */
    gameStarted,
    currentPosition(XC, YC),
    isMarketplace(XC,YC), stock('chicken', Numbers_chicken), stock('sheep', Numbers_sheep), stock('cow', Numbers_cow), stock('corn_seed', Numbers_cornSeed), stock('carrot_seed', Numbers_carrotSeed), stock('potato_seed', Numbers_potatoSeed), stock('tomato_seed', Numbers_tomatoSeed), stock('corn', Numbers_corn), stock('carrot', Numbers_carrot), stock('tomato', Numbers_tomato), stock('potato', Numbers_potato), stock('shovel', Shovel_level), stock('fishing_rod', FishingRod_level), stock('chicken_egg', Numbers_egg), stock('milk_cow', Numbers_milk), stock('wool_sheep', Numbers_wool), stock('cupang', Numbers_cupang), stock('lele', Numbers_lele), stock('tongkol', Numbers_tongkol), stock('bandeng', Numbers_bandeng), stock('cakalang', Numbers_cakalang), stock('gurame', Numbers_gurame), stock('kakap', Numbers_kakap), stock('tuna', Numbers_tuna), stock('salmon', Numbers_salmon), stock('megalodon', Numbers_megalodon), count_inventory(Numbers_inventory), 
    nl,
    write('[]** What do you want to do ? **[]'), nl,
    write('||                              ||'), nl,
    write('||        > 1. buy              ||'), nl,
    write('||        > 2. sell             ||'), nl,
    write('||        > 3. exitShop         ||'), nl,
    write('||                              ||'), nl,
    write('[]%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%[]'), nl,
    write(''), nl,
    input(Command), ((Command == 'buy' -> LevelUpshovel is Shovel_level + 1, 
    LevelUpFishingRod is FishingRod_level + 1, cost('shovel', Coast_shovelLevel), cost('fishing_rod', Coast_fishingRodLevel),
    write(''), nl,
    write('[]*********** What do you want to buy ? ***********[]'), nl,
    write('||                                                 ||'), nl,
    write('||   1. carrot_seed          (20 golds)            ||'), nl,
    write('||   2. tomato_seed          (40 golds)            ||'), nl,
    write('||   3. corn_seed            (60 golds)            ||'), nl,
    write('||   4. potato_seed          (80 golds)            ||'), nl,
    write('||   5. chicken              (500 golds)           ||'), nl,
    write('||   6. sheep                (1000 golds)          ||'), nl,
    write('||   7. cow                  (1500 golds)          ||'), nl,
    write('||   8. level '), write(LevelUpshovel), write(' shovel       ('), write(Coast_shovelLevel), write(' golds)           ||'), nl,
    write('||   9. level '), write(LevelUpFishingRod), write(' fishing_rod  ('), write(Coast_fishingRodLevel), write(' golds)           ||'), nl,
    write('||                                                 ||'), nl,
    write('[]%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%[]'), nl,
    write(''), nl,
    (Numbers_inventory < 100,
    write('The input must be integer'), nl,
    write('Type 0 if you want to exit this menu'), nl,
    write('| ?- '),
    read(The_Number), player(_,_,_,_,_,_,_,_,_,Gold), commandInt_Tostr(The_Number, Item), buy_item(Item, Gold, Sum_Cost), subtractGold(Sum_Cost), !); (Numbers_inventory =:= 100,write('Your inventory has full item')), !); (Command == 'sell', 
    write('[]************* Here are your item in your inventory ***********[]'), nl,
    write('                                                      '), nl,
    ((Numbers_carrotSeed > 0, write('                  - '), write(Numbers_carrotSeed), write(' carrot_seed                                      '), nl); Numbers_carrotSeed == 0, write('')),
    ((Numbers_cornSeed > 0, write('                  - '), write(Numbers_cornSeed), write(' corn_seed                                             '), nl);
    Numbers_cornSeed == 0, write('')),
    ((Numbers_tomatoSeed > 0, write('                  - '), write(Numbers_tomatoSeed), write(' tomato_seed                                      '), nl);
    Numbers_tomatoSeed == 0, write('')),
    ((Numbers_potatoSeed > 0, write('                  - '), write(Numbers_potatoSeed), write(' potato_seed                                      '), nl);
    Numbers_potatoSeed == 0, write('')),
    ((Numbers_carrot > 0, write('                  - '), write(Numbers_carrot), write(' carrot                                       '), nl); Numbers_carrot == 0, write('')),
    ((Numbers_corn > 0, write('                  - '), write(Numbers_corn), write(' corn                                             '), nl);
    Numbers_corn == 0, write('')),
    ((Numbers_tomato > 0, write('                  - '), write(Numbers_tomato), write(' tomato                                       '), nl);
    Numbers_tomato == 0, write('')),
    ((Numbers_potato > 0, write('                  - '), write(Numbers_potato), write(' potato                                       '), nl);
    Numbers_potato == 0, write('')),
    ((Numbers_chicken > 0, write('                  - '), write(Numbers_chicken), write(' chicken                                       '), nl);
    Numbers_chicken == 0, write('')),
    ((Numbers_sheep > 0, write('                  - '), write(Numbers_sheep), write(' sheep                                       '), nl);
    Numbers_sheep == 0, write('')),
    ((Numbers_cow > 0, write('                  - '), write(Numbers_cow), write(' cow                                       '), nl);
    Numbers_cow == 0, write('')),
    ((Numbers_egg > 0, write('                  - '), write(Numbers_egg), write(' egg                                                '), nl);
    Numbers_egg == 0, write('')),
    ((Numbers_milk > 0, write('                  - '), write(Numbers_milk), write(' liter_of_milk                                    '), nl);
    Numbers_milk == 0, write('')),
    ((Numbers_wool > 0, write('                  - '), write(Numbers_wool), write(' wool                                             '), nl);
    Numbers_wool == 0, write('')),
    ((Numbers_cupang > 0, write('                  - '), write(Numbers_cupang), write(' cupang                                             '), nl);
    Numbers_cupang == 0, write('')),
    ((Numbers_lele > 0, write('                  - '), write(Numbers_lele), write(' lele                                             '), nl);
    Numbers_lele == 0, write('')),
    ((Numbers_tongkol > 0, write('                  - '), write(Numbers_tongkol), write(' tongkol                                             '), nl);
    Numbers_tongkol == 0, write('')),
    ((Numbers_bandeng > 0, write('                  - '), write(Numbers_bandeng), write(' bandeng                                             '), nl);
    Numbers_bandeng == 0, write('')),
    ((Numbers_cakalang > 0, write('                  - '), write(Numbers_cakalang), write(' cakalang                                             '), nl);
    Numbers_cakalang == 0, write('')),
    ((Numbers_gurame > 0, write('                  - '), write(Numbers_gurame), write(' gurame                                             '), nl);
    Numbers_gurame == 0, write('')),
    ((Numbers_kakap > 0, write('                  - '), write(Numbers_kakap), write(' kakap                                             '), nl);
    Numbers_kakap == 0, write('')),
    ((Numbers_tuna > 0, write('                  - '), write(Numbers_tuna), write(' tuna                                             '), nl);
    Numbers_tuna == 0, write('')),
    ((Numbers_salmon > 0, write('                  - '), write(Numbers_salmon), write(' salmon                                             '), nl);
    Numbers_salmon == 0, write('')),
    ((Numbers_megalodon > 0, write('                  - '), write(Numbers_megalodon), write(' megalodon                                             '), nl);
    Numbers_megalodon == 0, write('')),
    (write('                                                      '), nl),
    write('[]**************************************************************[]'),
    nl, player(_,_,_,_,_,_,_,_,_,Gold), stock(_,NumberStock), ((NumberStock =:= 0, write('Sorry, you don''t have any item in your inventory'), nl, !);
    (write('What do you want to sell ? '), nl, write('You can type ''exitSell'' if you want to exit this menu'), nl, input(ChooseItem),
    (sell_item(ChooseItem, Sum_Cost), addGold(Sum_Cost)), !))); (Command == 'exitShop' -> exitMarket, !); (Command \== 'exitShop', Command \== 'buy', Command \== 'sell', write('Your Command was Not Found'), nl, market, !)).

ranch :- 
    gameStarted,
    currentPosition(XC, YC),
    isRanch(XC,YC),
    player(_,_,_,_,_,_,_,LevelRanching,_,_), X is 7 - LevelRanching,
    day(Day), stock('chicken', Number_chicken), stock('sheep', Number_sheep), stock('cow', Number_cow), Lay is Number_chicken, Exp_UpFromChicken is 10 * Lay, Exp_UpFromSheep is 20 * Number_sheep, Exp_UpFromCow is 30 * Number_cow,
    write('** Welcome to the ranch! You have **'), nl, write(''), nl,
    ((((Number_chicken > 0, write('             '), write(Number_chicken), write(' chicken')), nl);
    Number_chicken =:= 0, write('')),
    (((Number_sheep > 0, write('             '), write(Number_sheep), write(' sheep')), nl);
    Number_sheep =:= 0, write('')),
    (((Number_cow > 0, write('             '), write(Number_cow), write(' cow'))), nl);
    Number_cow =:= 0, write('')),
    nl, 
    write('************************************'), nl,
    write('What do you want to do?'), nl, write('Type ''exitRanch'' if you want to exit this menu'), nl,
    input(Choose), ((Choose == 'exitRanch', exitRanch, !); (((Choose == 'chicken'), ((Number_chicken =:= 0, write('You don''t have any chicken'), nl); (((mod(Day, X) =:= 0), write('Your chicken lays '), write(Lay), write(' eggs.'), nl, write('You got '), write(Lay), write(' eggs!'), nl, write('You gained '), (player(rancher,_,_,_,_,_,_,_,_,_), DoubleExp is 2 * Exp_UpFromChicken, write(DoubleExp); \+player(rancher,_,_,_,_,_,_,_,_,_), write(Exp_UpFromChicken)), write(' ranching exp!'), nl, write('This egg will automatically entry to your inventory\n'), addInven(Lay, 'chicken_egg'), isRancher(Exp_UpFromChicken), (isQuestActive(true), activeQuest(HARVEST, FISH, RANCH), SISA is RANCH - 1, retract(activeQuest(HARVEST, FISH, RANCH)), assertz(activeQuest(HARVEST, FISH, SISA)), cekApakahQuestSelesai(_); isQuestActive(false)), reduceEnergy(10), exhaustedEnergyAction, printLowEnergyMsg, !); (write('Your chicken hasn''t produced any egg'), nl, write('Please check again later.'), nl))), !); 
    ((Choose == 'sheep') -> (((mod(Day, X) =\= 0) -> write('Your sheep hasn''t produced any wool.'), nl, write('Please check again later.'), nl); ((mod(Day, X) =:= 0) -> write('Your sheep produced '), write(Number_sheep),write(' wool'), nl, write('You gained '), (player(rancher,_,_,_,_,_,_,_,_,_), DoubleExp is 2 * Exp_UpFromSheep, write(DoubleExp); \+player(rancher,_,_,_,_,_,_,_,_,_), write(Exp_UpFromSheep)), write(' ranching exp!'), nl, write('This wool will automatically entry to your inventory\n'), addInven(Number_sheep, 'wool_sheep'), isRancher(Exp_UpFromSheep), (isQuestActive(true), activeQuest(HARVEST, FISH, RANCH), SISA is RANCH - 1, retract(activeQuest(HARVEST, FISH, RANCH)), assertz(activeQuest(HARVEST, FISH, SISA)), cekApakahQuestSelesai(_); isQuestActive(false)), reduceEnergy(10), exhaustedEnergyAction, printLowEnergyMsg, !)));
    ((Choose == 'cow') -> (((mod(Day, X) =:= 0), write('Your cow produced '), write(Number_cow), write(' liter of milk'), nl, write('You gained '), (player(rancher,_,_,_,_,_,_,_,_,_), DoubleExp is 2 * Exp_UpFromCow, write(DoubleExp); \+player(rancher,_,_,_,_,_,_,_,_,_), write(Exp_UpFromCow)), write(' ranching exp!'), nl, write('This milk will automatically entry to your inventory\n'), addInven(Number_cow, 'milk_cow'), isRancher(Exp_UpFromCow), (isQuestActive(true), activeQuest(HARVEST, FISH, RANCH), SISA is RANCH - 1, retract(activeQuest(HARVEST, FISH, RANCH)), assertz(activeQuest(HARVEST, FISH, SISA)), cekApakahQuestSelesai(_); isQuestActive(false)), reduceEnergy(10), exhaustedEnergyAction, printLowEnergyMsg, !); (write('Your cow hasn''t produced any milk'), nl, write('Please check again later.'), nl)))), !).
