%Find the last element of a list.
findLast([H|[]],H):-!.
findLast([_|T],X):-
	findLast(T,X).
%?- findLast([1,2,3,4,5],X).

%Find the second last element of a list.
findSecondLast([H,_],H):-!.
findSecondLast([_|T],X):- 
	findSecondLast(T,X).