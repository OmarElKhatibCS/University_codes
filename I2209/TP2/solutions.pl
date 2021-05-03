pgcd(A,0,A).
pgcd(A,B,R) :- A < B , R is A.
pgcd(A,B,R) :- A > B , B>0 , Rem is rem(A,B) , pgcd(B , Rem , R).

fib(0, 0).
fib(1, 1).
fib(N, R) :- 
    N>1,
    N1 is N - 1,
    N2 is N - 2,
    fib(N1, R1),
    fib(N2, R2),
    R is R1+R2.

sumNum(A,R) :- sumNum(A,R,0).
sumNum(A , R , S) :- A < 1 , R is S.
sumNum(A,R,S) :- A>0,Div is div(A,10) , Rem is rem(A,10) , N is S+Rem,
    			sumNum(Div , R , N).

concat(A,B,R) :- append(A,B,R).

find([H|T] , Target) :- find(T,Target); H = Target.

count(List , R) :- count(List , 0 , R).
count([], N , N).
count([_|T], Count , R) :- N is Count+1 , count(T,N,R).

appearence(List , Target , R) :- appearence(List, Target , [] , R).
appearence([], _ , Founds , R) :- length(Founds,R).
appearence([H|T] , Target , Founds , R) :- 
    (   H = Target ->
    append(Founds,[Target],X),
    appearence(T,Target,X,R) ; appearence(T,Target,Founds,R)).

supression(List , Target , R) :- supression(List , Target , [] , R).
supression([] , _ , FinalList ,FinalList).
supression([H|T], Target , FinalList , R) :-
    (   H = Target ->  supression(T,Target,FinalList,R);
    	append(FinalList , [H] , X),supression(T,Target,X,R)
    ).

substitution(List , Target , With , R) :- substitution(List , Target , With , [] , R).
substitution([] , _ , _ , FinalList , FinalList).
substitution([H|T], Target , With , FinalList , R) :-
    (   H = Target ->  append(FinalList , [With] , X) , substitution(T,Target,With,X,R);
    	append(FinalList , [H] , X),substitution(T,Target,With,X,R)
    ).

inverse(List , R) :- inverse(List,R,[]).
inverse([],X,X).
inverse([H|T], R , Acc) :- inverse(T , R , [H|Acc]).

last([H],H).
last([_|T] , R) :- last(T,R).


