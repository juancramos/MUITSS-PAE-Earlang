-module(class).

-compile(export_all).

add(A, B) -> A + B.

%% Shows greetings.
%% io:format/1 is the standard function used to output text.
hello() -> io:format("Hello, world!~n").

greet_and_add_two(X) -> hello(), add(X, 2).

beach(Temperature) ->
    case Temperature of
      {celsius, N} when N >= 20, N =< 45 -> favorable;
      {kelvin, N} when N >= 293, N =< 318 ->
	  'scientifically favorable';
      {fahrenheit, N} when N >= 68, N =< 113 ->
	  'favorable in the US';
      _ -> 'avoid beach'
    end.

beach1({celsius, N}) when N >= 20, N =< 45 -> favorable;
beach1({kelvin, N}) when N >= 293, N =< 318 ->
    'scientifically favorable';
beach1({fahrenheit, N}) when N >= 68, N =< 113 ->
    'favorable in the US';
beach1(_) -> 'avoid beach'.

heh_fine(C) ->
    if C =:= 1 -> works;
       C =:= 2 -> works;
       true -> fails
    end.

help_me(Animal) ->
    Talk = if Animal == cat -> "meow";
	      Animal == beef -> "mooo";
	      Animal == dog -> "bark";
	      Animal == tree -> "bark";
	      true -> "fgdadfgna"
	   end,
    {Animal, "says " ++ Talk ++ "!"}.

help_me_case(Animal) ->
    Talk = case Animal of
	     cat -> "meow";
	     beef -> "mooo";
	     dog -> "bark";
	     tree -> "bark";
	     _ -> "fgdadfgna"
	   end,
    {Animal, "says " ++ Talk ++ "!"}.

quicksort([]) -> [];
quicksort([Pivot | Rest]) ->
    {Smaller, Larger} = partition(Pivot, Rest, [], []),
    quicksort(Smaller) ++ [Pivot] ++ quicksort(Larger).

partition(_, [], Smaller, Larger) -> {Smaller, Larger};
partition(Pivot, [H | T], Smaller, Larger) ->
    if H =< Pivot ->
	   partition(Pivot, T, [H | Smaller], Larger);
       H > Pivot -> partition(Pivot, T, Smaller, [H | Larger])
    end.

len([]) -> 0;
len([_ | T]) -> 1 + len(T).

lenT(L) -> lenT(L, 0).

lenT([], Acc) -> Acc;
lenT([_ | T], Acc) -> lenT(T, Acc + 1).
