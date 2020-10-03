-module(the_sound_of_erlang).

%% API exports
-export([main/1]).

%%====================================================================
%% API functions
%%====================================================================

%% escript Entry point
main(Args) ->
    Wave = wave(),
    Filename = "out/" ++ hd(Args),
    save(Filename, Wave),
    play(Filename),
    erlang:halt(0).

%%====================================================================
%% Internal functions
%%====================================================================

wave() ->
	frequency(440, 2, 48000).

frequency(Hz, Duration, SampleRate) ->
    Signals = lists:seq(1, round(SampleRate * Duration)),
    Step = Hz * 2 * math:pi() / SampleRate,
    [ math:sin(Step * Signal) || Signal <- Signals ].

save(Filename, Wave) ->
    Content = lists:foldl(
        fun(Elem, Acc) -> <<Acc/binary, Elem/float>> end, 
        <<"">>, 
        Wave
    ),
    ok = file:write_file(Filename, Content).

play(Filename) ->
    Cmd = "ffplay -f f64be -ar 48000 " ++ Filename,
    os:cmd(Cmd).