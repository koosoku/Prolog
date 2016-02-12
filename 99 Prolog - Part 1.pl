%Find the last element of a list.
findLast([H|[]],H):-!.
findLast([_|T],X):-
	findLast(T,X).
%?- findLast([1,2,3,4,5],X).

%Find the second last element of a list.
findSecondLast([H,_],H):-!.
findSecondLast([_|T],X):- 
	findSecondLast(T,X).
%?- findSecondLast([1,2,3,4,5,a],X).

%Find the kth element of a list.
findKth(1,[H|_],H):-!.
findKth(Count,[_|T],X):-
	CountOneLess is Count - 1,
	findKth(CountOneLess,T,X).
%?- findKth(3,[1,2,3,4,5],X).