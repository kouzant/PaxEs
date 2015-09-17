-module(utils).

-include_lib("PaxEs/include/paxos_def.hrl").

-export([pid_to_num/1, read_config/0, bcast/2]).

pred(X, Acc) ->
    case X of
	$. ->
	    Acc;
	$> ->
	    Acc;
	N ->
	    Acc + N
    end.

pid_to_num([_F | Pid]) ->
    lists:foldl(fun(X, Acc) -> pred(X, Acc) end, 0, Pid).

bcast(Fun, Destination) ->
    lists:map(Fun, Destination).

read_config() ->
    {ok, Terms} = file:consult(?CONFIG),
    Leader = lists:keyfind(leader, 1, Terms),
    Peers = lists:keyfind(peers, 1, Terms),
    {Leader, Peers}.
