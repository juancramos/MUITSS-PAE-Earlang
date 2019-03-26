-module(agendaserver).

-compile(export_all).

-behavior(gen_server).

start() -> gen_server:start_link(?MODULE, [], []).

init([]) -> {ok, dict:new()}.

handle_call({add, Name, Phone}, _From, Agenda) ->
    case dict:find(Name, Agenda) of
      {ok, _} -> {reply, ok, dict:append(Name, Phone, Agenda)};
      error -> {reply, ok, dict:store(Name, [Phone], Agenda)}
    end;
handle_call({del, Name}, _From, Agenda) ->
    {reply, ok, dict:erase(Name, Agenda)};
handle_call({get, Name}, _From, Agenda) ->
    case dict:find(Name, Agenda) of
      {ok, Value} -> {reply, Value, Agenda};
      error -> {reply, not_found, Agenda}
    end;
handle_call(terminate, _From, Agenda) ->
    {stop, normal, ok, Agenda};
handle_call(prueba, _From, Agenda) ->
    {reply, ok, Agenda}.

handle_info(Msg, Agenda) ->
    io:format("Unexpected message: ~p~n", [Msg]),
    {noreply, Agenda}.

add_phone(Pid, Name, Phone) ->
    gen_server:call(Pid, {add, Name, Phone}).

del_phone(Pid, Name) ->
    gen_server:call(Pid, {del, Name}).

get_phone(Pid, Name) ->
    gen_server:call(Pid, {get, Name}).

test(Pid) -> gen_server:call(Pid, {prueba}).
