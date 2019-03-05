-module(class4).

-compile(export_all).

foo() ->
    Y = fun (Room) ->
		io:format("Alarm set in ~s.~n", [Room]),
		fun () ->
			io:format("Alarm tripped in ~s! Call Batman!~n", [Room])
		end
	end,
    X = Y("HEY"),
    X().

sumMax(A, B) when B > A ->
    lists:foldl(fun (X, Y) -> X + Y end, 0,
		lists:seq(A, B));
sumMax(_, _) -> false.

sumPow(A, B) when B > A ->
    L = lists:map(fun (Z) -> Z * Z end, lists:seq(A, B)),
    lists:foldl(fun (X, Y) -> X + Y end, 0, L);
sumPow(_, _) -> false.

pow(X) -> X * X.

% Where X is head of list and Y the Acc param.
sumPow2(A, B) when B > A ->
    L = lists:seq(A, B),
    % usage of a "external function" like pow
    lists:foldl(fun (X, Y) -> fun class4:pow/1(X) + Y end,
		0, L);
sumPow2(_, _) -> false.

% Using aux variables
sumEven(A, B) when B > A ->
    S = lists:seq(A, B),
    F = lists:filter(fun (W) -> W rem 2 == 0 end, S),
    L = lists:map(fun (Z) -> Z * Z end, F),
    lists:foldl(fun (X, Y) -> X + Y end, 0, L);
sumEven(_, _) -> false.
