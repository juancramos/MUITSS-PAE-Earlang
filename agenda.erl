-module(agenda).

-compile(export_all).

new() -> dict:new().

get_phone(Name, DB) ->
    case dict:find(Name, DB) of
      {ok, [H | T]} -> [H | T];
      _ -> []
    end.

send_get_phone(Pid, Name) ->
    Pid ! {self(), {get, Name}},
    receive {Pid, Msg} -> Msg after 3000 -> timeout end.

del_phone(Name, DB) -> dict:erase(Name, DB).

send_del_phone(Pid, Name) ->
    Pid ! {self(), {del, Name}},
    receive {Pid, Msg} -> Msg after 3000 -> timeout end.

add_phone(Name, Phone, DB) ->
    X = case get_phone(Name, DB) of
	  Value -> [Phone | Value]
	end,
    try dict:store(Name, X, DB) catch _ -> error end.

send_add_phone(Pid, Name, Phone) ->
    Pid ! {self(), {add, {Name, Phone}}},
    receive {Pid, Msg} -> Msg after 3000 -> timeout end.

agenda(Dir) ->
    receive
      {From, {add, {Name, Phone}}} ->
	  Ndir = add_phone(Name, Phone, Dir),
	  From ! {self(), Ndir},
	  agenda(Ndir);
      {From, {get, Name}} ->
	  From ! {self(), get_phone(Name, Dir)}, agenda(Dir);
      {From, {del, Name}} ->
	  Ndir = del_phone(Name, Dir),
	  From ! {self(), Ndir},
	  agenda(Ndir);
      terminate -> ok
    end.

start() -> spawn_link(fun () -> agenda(new()) end).
