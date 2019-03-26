-module(tarea7).

-compile(export_all).

start() -> spawn_link(?MODULE, agenda, [dict:new()]).

agenda(Agenda) ->
    receive
      {From, {add, Name, Phone}} ->
	  From ! added,
	  case dict:find(Name, Agenda) of
	    {ok, _} -> agenda(dict:append(Name, Phone, Agenda));
	    error -> agenda(dict:store(Name, [Phone], Agenda))
	  end;
      {From, {del, Name}} ->
	  From ! erased, agenda(dict:erase(Name, Agenda));
      {From, {get, Name}} ->
	  case dict:find(Name, Agenda) of
	    {ok, Value} -> From ! Value;
	    error -> From ! not_found
	  end,
	  agenda(Agenda);
      {From, terminate} -> From ! bye
    end.

add_phone(Pid, Name, Phone) ->
    Pid ! {self(), {add, Name, Phone}},
    receive
      X -> X
      after 3000 -> io:format("Server not responding...~n")
    end.

del_phone(Pid, Name) ->
    Pid ! {self(), {del, Name}},
    receive
      X -> X
      after 3000 -> io:format("Server not responding...~n")
    end.

get_phone(Pid, Name) ->
    Pid ! {self(), {get, Name}},
    receive
      X -> io:format("~p's phones: ~p~n", [Name, X])
      after 3000 -> io:format("Server not responding...~n")
    end.

terminate(Pid) ->
    Pid ! {self(), terminate},
    receive
      X -> X
      after 3000 -> io:format("Server not responding...~n")
    end.
