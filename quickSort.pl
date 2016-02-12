quickSort([],[]).
quickSort([H|L],O):-
	partition(L,Lesser,Greater,H),
	quickSort(Lesser,SortedLesser),
	quickSort(Greater,SortedGreater),
	append(SortedLesser,[H|SortedGreater],O).

partition([],[],[],_).
partition([H|L],[H|Lesser],Greater,P) :- 
	H < P,
	partition(L,Lesser,Greater,P).
partition([H|L],Lesser,[H|Greater],P) :- 
	H > P,
	partition(L,Lesser,Greater,P).