-module(recursive).

-compile(export_all).

% 1
is_in(_, []) -> false;
is_in(E, [E | _]) -> true;
is_in(E, [_ | T]) -> is_in(E, T).

% 2
reverse([]) -> [];
reverse([H | T]) -> reverse(T) ++ [H].

% unzip([{1,3}, {4,3}, {5,6}]) -> {[1,4,5],[3,3,6]}
unzip(T) -> unzip(T, {[], []}).

unzip([], {Acc1, Acc2}) ->
    {reverse(Acc1), reverse(Acc2)};
% unzip([{} | _], {Acc1, Acc2}) -> {Acc1, Acc2};
% unzip([_ | {}], {Acc1, Acc2}) -> {Acc1, Acc2};
unzip([{A, B} | T], {Acc1, Acc2}) ->
    unzip(T, {[A | Acc1], [B | Acc2]}).

% 3
% calc({{A1}, {B1}, {C1}}) ->
%     calc({calc(A1), calc(B1), calc(C1)});
% calc({{A1}, B1, {C1}}) ->
%     calc({calc(A1), B1, calc(C1)});
% calc({{A1}, {B1}, C1}) ->
%     calc({calc(A1), calc(B1), C1});
% calc({A1, {B1, B2, {B3}}, {C1}}) ->
%     calc({A1, calc({B1, B2, calc(B3)}), calc(C1)});
calc({add, X, Y}) -> calc(X) + calc(Y);
calc({sub, X, Y}) -> calc(X) - calc(Y);
calc({mul, X, Y}) -> calc(X) * calc(Y);
calc({coc, X, Y}) -> calc(X) / calc(Y);
calc({rec, X, Y}) -> calc(X) rem calc(Y);
calc({neg, X}) -> calc(X) * -1;
calc(X) -> X.

% 5
string(N) when is_number(N) -> integer_to_list(N);
string(N) when is_atom(N) -> atom_to_list(N);
string(N) when is_list(N) -> string:join([string(X) || X <- N] , ", ");
string(N) when is_tuple(N) -> string(tuple_to_list(N));
string(_) -> "*".