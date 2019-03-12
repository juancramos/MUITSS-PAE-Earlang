-module(structures).

-compile(export_all).

-record(person, {name, phone, email, address}).

new_db() -> dict:new().

store_db(DNI, U = #person{}) ->
    dict:store(DNI, U, dict:new()).

store_db(DNI, U = #person{}, DB) ->
    dict:store(DNI, U, DB).

store_db_from_list(L = [{_, #person{}}], DB) ->
    DIR = dict:from_list(L),
    dict:merge(fun () -> true end, DIR, DB).

delete_db(DNI, DB) -> dict:erase(DNI, DB).

get_name(U = #person{}) ->
    case U#person.name of
      undefined -> error;
      X -> X
    end;
get_name(_) -> error.

get_name(DNI, DB) ->
    case dict:find(DNI, DB) of
      {ok, Value} -> get_name(Value);
      _ -> false
    end.

set_name(DNI, Name, DB) ->
    case dict:is_key(DNI, DB) of
      true ->
	  dict:update(DNI,
		      fun (U = #person{}) -> U#person{name = Name} end, DB);
      _ -> undefined
    end.

get_phone(U = #person{}) ->
    case U#person.phone of
      undefined -> error;
      X -> X
    end;
get_phone(_) -> error.

get_phone(DNI, DB) ->
    case dict:find(DNI, DB) of
      {ok, Value} -> get_phone(Value);
      _ -> false
    end.

set_phone(DNI, Phone, DB) ->
    case dict:is_key(DNI, DB) of
      true ->
	  dict:update(DNI,
		      fun (U = #person{}) -> U#person{phone = Phone} end, DB);
      _ -> undefined
    end.

get_email(U = #person{}) ->
    case U#person.email of
      undefined -> error;
      X -> X
    end;
get_email(_) -> error.

get_email(DNI, DB) ->
    case dict:find(DNI, DB) of
      {ok, Value} -> get_email(Value);
      _ -> false
    end.

set_email(DNI, Email, DB) ->
    case dict:is_key(DNI, DB) of
      true ->
	  dict:update(DNI,
		      fun (U = #person{}) -> U#person{email = Email} end, DB);
      _ -> undefined
    end.

get_address(U = #person{}) ->
    case U#person.address of
      undefined -> error;
      X -> X
    end;
get_address(_) -> error.

get_address(DNI, DB) ->
    case dict:find(DNI, DB) of
      {ok, Value} -> get_address(Value);
      _ -> false
    end.

set_address(DNI, Address, DB) ->
    case dict:is_key(DNI, DB) of
      true ->
	  dict:update(DNI,
		      fun (U = #person{}) -> U#person{address = Address} end,
		      DB);
      _ -> undefined
    end.

name_warnings(BD) ->
    dict:fold(fun (_, V, {A, B}) ->
		      case lists:member(V, A) of
			true -> {A, [V | B]};
			false -> {[V | A], B}
		      end
	      end,
	      {[], []}, BD).
