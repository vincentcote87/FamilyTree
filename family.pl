male(vincent).
male(tighe).
male(brodie).
male(reg).
male(dany).
male(rodolph).
male(jeff).
male(michel).
male(gerald).
male(mario).
male(julien).

female(krista).
female(hailie).
female(sus).
female(celine).
female(valerie).
female(gyslene).
female(monique).
female(dianne).

parent(vincent,brodie).
parent(vincent,tighe).
parent(vincent,hailie).
parent(krista,brodie).
parent(krista,tighe).
parent(krista,hailie).
parent(reg,krista).
parent(sus,krista).
parent(dany,vincent).
parent(dany,valerie).
parent(dany,jeff).
parent(celine,vincent).
parent(celine,valerie).
parent(celine,jeff).
parent(rodolph,celine).
parent(gyslene,celine).
parent(rodolph,mario).
parent(gyslene,mario).
parent(gerald,michel).
parent(monique,michel).
parent(mario,julien).
parent(dianne,julien).


father(X,Y) :-
  male(X),
  parent(X,Y).

mother(X,Y) :-
  female(X),
  parent(X,Y).

son(X,Y) :-
  male(X),
  parent(Y,X).

daughter(X,Y) :-
  female(X),
  parent(Y,X).

% goes through twice since son returns two parents.
brother(X,Y) :-
%  \+ (X = Y),
  son(X,Z),
  parent(Z,Y).

% goes through twice since daughter returns two parents.
sister(X,Y) :-
%  \+ (X = Y),
  daughter(X,Z),
  parent(Z,Y).

grandfather(X,Y) :-
  male(X),
  parent(X,Z),
  parent(Z,Y).

grandmother(X,Y) :-
  female(X),
  parent(X,Z),
  parent(Z,Y).

grandson(X,Y) :-
  male(X),
  (grandfather(Y,X);
   grandmother(Y,X)).

granddaughter(X,Y) :-
  female(X),
  (grandfather(Y,X);
   grandmother(Y,X)).

uncle(X,Y) :-
  parent(Z,Y),
  brother(X,Z).

aunt(X,Y) :-
  parent(Z,Y),
  sister(X,Z).

nephew(X,Y) :-
  male(X),
  (uncle(Y,X);
   aunt(Y,X)).

niece(X,Y) :-
  female(X),
  (uncle(Y,X);
   aunt(Y,X)).

cousin(X,Y) :-
  (son(X,Z);
   daughter(X,Z)),
  (uncle(Z,Y);
   aunt(Z,Y)),
   \+ (X = Y).