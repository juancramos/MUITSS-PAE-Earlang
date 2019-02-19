-module(class).
-compile(export_all).

add(A,B) -> A + B.

%% Shows greetings.
%% io:format/1 is the standard function used to output text.
hello() -> io:format("Hello, world!~n").

greet_and_add_two(X) ->    
    hello(), add(X,2).