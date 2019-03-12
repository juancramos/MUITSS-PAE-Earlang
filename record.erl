-module(record).

-compile(export_all).

-record(user, {id, name, group, age}).

adult_section(U = #user{}) when U#user.age >= 18 ->
    %% Show stuff that can't be written in such a text.
    allowed;
adult_section(_) ->
    %% Redirect to Sesame Street site.
    forbidden.

get_age(U = #user{}) ->
    case U#user.age of
      undefined -> error;
      X -> X
    end;
get_age(_) -> error.

get_age1(#user{age = Age}) ->
    case Age of
      undefined -> error;
      X -> X
    end;
get_age1(_) -> error.

new() -> dict:new().

add(K, U = #user{}, Dir) ->
    try dict:store(K, U, Dir) catch _ -> error end.
