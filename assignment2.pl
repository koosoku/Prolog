% Player definitions for ghislain and gilles since they have specific scores.
player(ghislain, Occupation, 72):-
	!,occupation(Occupation).
player(gilles, Occupation, 82):-
	!,occupation(Occupation),
	not(Occupation = mason).

player(Name,Occupation,Score):-
	golfer(Name),
	between(32,42,S),
	Score is S*2,
	occupation(Occupation).
	
%database for available players and occupations
golfer(jules).
golfer(gilles).
golfer(jean).
golfer(joe).
golfer(ghislain).

occupation(mason).
occupation(plasterer).
occupation(carpenter).
occupation(tinsmith).
occupation(roofer).

%constraints
constraintRoofer(player(N,roofer,74)):- not(N = ghislain).
constraintMason(player(N,mason,70)):- not(N = giles).
constraintTinsmith(player(N,tinsmith,S),player(joe,JoeOccupation,JoeScore)):-
	not(N = joe),
	not(JoeOccupation = tinsmith),
	S is JoeScore - 4,
	S >= 64.
constraintCarpenter(player(N,carpenter,S),player(jules,_JulesOccupation,JulesScore)):-
	not(N = jules),
	S is JulesScore + 8,
	S =< 84.
constraintWin(player(NTinsmith,tinsmith,STinSmith), SCarpenter, SRoofer, SMason, SPlasterer):- 
	not(NTinsmith = jules), not(NTinsmith = joe),
	STinSmith < SCarpenter,
	STinSmith < SRoofer,
	STinSmith < SMason,
	STinSmith < SPlasterer.

scores(player(N1, M1, P1), player(N2, M2, P2), player(N3, M3, P3), player(N4, M4, P4), player(N5, M5, P5)):-
	player(N1, M1, P1),
	player(N2, M2, P2),
	player(N3, M3, P3),
	player(N4, M4, P4),
	player(N5, M5, P5),

	%check that there is no duplicate for occupations
	noDuplicate([M1,M2,M3,M4,M5]),

	%throw all the players into a list
	PlayerList = [player(N1, M1, P1), player(N2, M2, P2), player(N3, M3, P3), player(N4, M4, P4), player(N5, M5, P5)],
	
	%use find player to find the appropriate player from the list and 
	%name the variables(Name,Occupation or Score) accordingly
	getPlayer(PlayerList,player(NRoofer,roofer,SRoofer)),
	getPlayer(PlayerList,player(NMason,mason,SMason)),
	getPlayer(PlayerList,player(NTinsmith,tinsmith,STinSmith)),
	getPlayer(PlayerList,player(joe,OJoe,SJoe)),
	getPlayer(PlayerList,player(_NPlasterer,plasterer,SPlasterer)),	
	getPlayer(PlayerList,player(NCarpenter,carpenter,SCarpenter)),		
	getPlayer(PlayerList,player(jules,OJules,SJules)),

	%Call the constraints with the information
	constraintRoofer(player(NRoofer,roofer,SRoofer)),
	constraintMason(player(NMason,mason,SMason)),
	constraintTinsmith(player(NTinsmith, tinsmith, STinSmith),player(joe,OJoe,SJoe)),
	constraintCarpenter(player(NCarpenter,carpenter,SCarpenter),player(jules,OJules,SJules)),
	constraintWin(player(NTinsmith,tinsmith,STinSmith), SCarpenter, SRoofer, SMason, SPlasterer),!.


%getPlayer finds the specific player in the list by inputting an occupation, name or score 
getPlayer([player(Name,Occupation,S)|_],player(Name,Occupation,S)):-!.
getPlayer([_|T],Player):-
	getPlayer(T,Player).

%check there's no duplicate in a list
noDuplicate([H|L]):-
	not(member(H,L)),
	noDuplicate(L).
noDuplicate([]).


%Question 2 we'll traverse the tree with both nodes, and the lca will be 
	%1. when the keys split OR 
	%2. when we find one of the keys, in which the other key is a child of the found key, so lca
	%is by definition, the found key.
treeA(X):- X = t(73,t(31,t(5,nil,nil),nil),t(101, t(83,nil, t(97,nil,nil)),t(2016,nil,nil))).

lca(K1,K2,T):-
	doubleBinarySearch(K1,K2,T).

%Normal Binary Search to ensure that the keys exist in the tree
binarySearch(Key,t(Key,_,_)):-!.
binarySearch(Key,t(Root,Left,_)):-
	Root>Key,
	binarySearch(Key,Left),!.
binarySearch(Key,t(Root,_,Right)):-
	Root<Key,
	binarySearch(Key,Right),!.

%doubleBinarySearch to find the lca, each binary search case has two variations for (K1,K2) and (K2,K1)
%case 2. when one of the key is found, print the key as the lca
doubleBinarySearch(Key1,Key2, t(Key1,Left,Right)):-
	write(t(Key1,Left,Right)),!.
doubleBinarySearch(Key1,Key2, t(Key2,Left,Right)):-
	write(t(Key2,Left,Right)),!.

%case 1. when the two keys are on different side of the node, print the node as lca
doubleBinarySearch(Key1,Key2,t(Root,Left,Right)):-
	Root>Key1,
	Root<Key2,
	binarySearch(Key1,Left),
	binarySearch(Key2,Right),
	write(t(Root,Left,Right)),!.
doubleBinarySearch(Key1,Key2,t(Root,Left,Right)):-
	Root<Key1,
	Root>Key2,
	binarySearch(Key2,Left),
	binarySearch(Key1,Right),
	write(t(Root,Left,Right)),!.

%recursive case to keep going to the left or to the right of the tree for when keys are on the same side.
doubleBinarySearch(Key1,Key2,t(Root,_Left,Right)):-
	Root<Key1,
	Root<Key2,
	doubleBinarySearch(Key1,Key2,Right),!.	
doubleBinarySearch(Key1,Key2,t(Root,Left,_Right)):-
	Root>Key1,
	Root>Key2,
	doubleBinarySearch(Key1,Key2,Left),!.	


