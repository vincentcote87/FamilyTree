male(bill).
male(john).
male(frank).
male(joe).
male(larrie).
male(philip).
male(kevin).
male(chris).
male(danny).

female(anne).
female(dorothy).
female(sharon).
female(rochelle).
female(danelle).
female(marg).
female(connie).
female(corrie).

parent(bill,john).
parent(bill,frank).
parent(bill,joe).
parent(anne,john).
parent(anne,frank).
parent(anne,joe).
parent(john,larrie).
parent(john,sharon).
parent(john,philip).
parent(john,kevin).
parent(dorothy,larrie).
parent(dorothy,sharon).
parent(dorothy,philip).
parent(dorothy,kevin).
parent(larrie,connie).
parent(larrie,corrie).
parent(larrie,chris).
parent(marg,connie).
parent(marg,corrie).
parent(marg,chris).
parent(danny,rochelle).
parent(danny,danelle).
parent(sharon,rochelle).
parent(sharon,danelle).

% X is a male parent of Y
father(X,Y) :-
  male(X),
  parent(X,Y).

% X is a female parent of Y
mother(X,Y) :-
  female(X),
  parent(X,Y).

% X is a male child of Y
son(X,Y) :-
  male(X),
  parent(Y,X).

% X is a female child of Y
daughter(X,Y) :-
  female(X),
  parent(Y,X).

% X is the son of the same mother or father of Y
brother(X,Y) :-
  son(X,Z),
  parent(Z,Y),
  X \= Y.

% X is the daughter of the same mother or father of Y
sister(X,Y) :-
  daughter(X,Z),
  parent(Z,Y),
  X \= Y.

% X is the father of Y’s father or mother
grandfather(X,Y) :-
  male(X),
  parent(X,Z),
  parent(Z,Y).

% X is the mother of Y’s father or mother
grandmother(X,Y) :-
  female(X),
  parent(X,Z),
  parent(Z,Y).

% X is the son of Y’s son or daughter
grandson(X,Y) :-
  male(X),
  (grandfather(Y,X);
   grandmother(Y,X)).

% X is the daughter of Y’s son or daughter
granddaughter(X,Y) :-
  female(X),
  (grandfather(Y,X);
   grandmother(Y,X)).

% X is the brother of Y’s father or mother
uncle(X,Y) :-
  parent(Z,Y),
  brother(X,Z).

% X is the sister of Y’s father or mother
aunt(X,Y) :-
  parent(Z,Y),
  sister(X,Z).

% X is the son of Y’s brother or sister
nephew(X,Y) :-
  male(X),
  (uncle(Y,X);
   aunt(Y,X)).

% X is the daughter of Y’s brother or sister
niece(X,Y) :-
  female(X),
  (uncle(Y,X);
   aunt(Y,X)).

 % X is the son or daughter of Y’s uncle or aunt
cousin(X,Y) :-
  (son(X,Z);
   daughter(X,Z)),
  (uncle(Z,Y);
   aunt(Z,Y)),
   X \= Y.

% Y descends from X
% base case of recursion, when parents of Y are not in the database.
ancestor(X,Y) :-
  parent(X,Y).

% recursive step, returns the parents of Y and passes them
% back recursively.
ancestor(X,Y) :-
  parent(X,Z),
  ancestor(Z,Y).

% X descends from Y
descendant(X,Y) :-
  ancestor(Y,X).
