-module(funtions_patern).

-compile(export_all).

% 1
ordinal(I) ->
    ORD = case I of
	    1 -> "st";
	    2 -> "nd";
	    3 -> "rd";
	    I when I > 3 -> "th";
	    _ -> "not a number"
	  end,
    {I, "ordinal is " ++ integer_to_list(I) ++ ORD ++ "!"}.

% 2
same({X, X}) -> true;
same(_) -> false.

% 3
samel([{X, X} | T]) -> T;
samel([{X, Y} | _]) -> {Y, X}.

% 4
calc({add, X, Y}) -> X + Y;
calc({sub, X, Y}) -> X - Y;
calc({mul, X, Y}) -> X * Y;
calc({coc, X, Y}) -> X / Y;
calc({rec, X, Y}) -> X rem Y;
calc({neg, X}) -> X * -1.

% 5
string(N) when is_number(N) -> integer_to_list(N);
string(N) when is_atom(N) -> atom_to_list(N);
string(N) when is_list(N); is_tuple(N) -> N;
string(_) -> "*".
