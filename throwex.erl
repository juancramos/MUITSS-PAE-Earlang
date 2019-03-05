-module(throwex).

-compile(export_all).

mysearch(E, L) ->
    lists:any(fun (X) ->
		      R = mysearch1(E, X), io:format("~p~n", [R]), R
	      end,
	      L).

mysearch1(E, E) -> true;
mysearch1(E, L) when is_list(L) -> mysearch(E, L);
mysearch1(_, _) -> false.

mysearchTr(E, L) ->
    try lists:any(fun (X) ->
			  R = mysearchTr1(E, X), io:format("~p~n", [R]), R
		  end,
		  L)
    catch
      found -> true
    end.

mysearchTr1(E, E) -> throw(found);
mysearchTr1(E, L) when is_list(L) -> mysearchTr(E, L);
mysearchTr1(_, _) -> false.
