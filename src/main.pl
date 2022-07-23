:- include('database.pl').
:- include('farming.pl').
:- include('fishing.pl').
:- include('help.pl').
:- include('house.pl').
:- include('main_menu.pl').
:- include('map.pl').
:- include('marketplace_and_ranch').
:- include('move.pl').
:- include('quest.pl').
:- include('start.pl').
:- include('status.pl').
:- include('energy.pl').

exit :- 
    gameStarted,
    retract(gameStarted),
    write('\nTHANKS FOR PLAYING!\n').
exitGame :-
    \+ gameStarted,
    gameStarteda,
    retract(gameStarteda),
    write('\nSEE YOU AGAIN!\n').