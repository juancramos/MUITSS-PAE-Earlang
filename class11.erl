-module(class11).

-compile(export_all).

store2(Pid, Food) ->
    Pid ! {self(), {store, Food}},
    receive {Pid, Msg} -> Msg after 3000 -> timeout end.

take2(Pid, Food) ->
    Pid ! {self(), {take, Food}},
    receive {Pid, Msg} -> Msg after 3000 -> timeout end.

monitor() ->
    erlang:monitor(process,
		   spawn(fun () -> timer:sleep(500) end)).

spaw_monitor() ->
    {Pid, Ref} = spawn_monitor(fun () ->
				       receive _ -> exit(boom) end
			       end),
    erlang:demonitor(Ref),
    Pid ! die.

start_critic() -> spawn(?MODULE, critic, []).

judge(Pid, Band, Album) ->
    Pid ! {self(), {Band, Album}},
    receive
      {Pid, Criticism} -> Criticism after 2000 -> timeout
    end.

critic() ->
    receive
      {From,
       {"Rage Against the Turing Machine", "Unit Testify"}} ->
	  From ! {self(), "They are great!"};
      {From, {"System of a Downtime", "Memoize"}} ->
	  From !
	    {self(),
	     "They're not Johnny Crash but they're "
	     "good."};
      {From, {"Johnny Crash", "The Token Ring of Fire"}} ->
	  From ! {self(), "Simply incredible."};
      {From, {_Band, _Album}} ->
	  From ! {self(), "They are terrible!"}
    end,
    critic().
