-module(bpe_app).
-behaviour(application).
-include("bpe.hrl").
-include_lib("kvs/include/feed.hrl").
-export([start/2, stop/1, worker/1]).

start(_StartType, _StartArgs) ->
    Res = bpe_sup:start_link(),
    kvs:join(),
    Table = process,
    spawn(fun() -> case kvs:get(feed,Table) of
          {ok,Feed} -> kvs:fold(fun(A,Acc) -> {M,F} = application:get_env(bpe,process_worker,{?MODULE,worker}),
                                               M:F(A) end,[],
                       Table, Feed#feed.top,undefined, #iterator.prev,#kvs{mod=store_mnesia});
                 __ -> skip end end),
    Res.

stop(_State) -> ok.

worker(#process{id=Id}=P) ->
    case bpe:history(Id) of
         [H|_] -> worker_do(calendar:time_difference(H#history.time,calendar:local_time()),P);
            __ -> skip end.

worker_do({Days,Time},P) when Days >= 14 -> skip;
worker_do({Days,Time},P) when P#process.task =:= 'Payment'     -> kvs:info(?MODULE,"BPE Start: ~p~n",[bpe:start(P,[])]);
worker_do({Days,Time},P) when P#process.task =:= 'Delay'       -> kvs:info(?MODULE,"BPE Start: ~p~n",[bpe:start(P,[])]);
worker_do({Days,Time},P) when P#process.task =:= 'FirstDelay'  -> kvs:info(?MODULE,"BPE Start: ~p~n",[bpe:start(P,[])]);
worker_do({Days,Time},P) when P#process.task =:= 'SecondDelay' -> kvs:info(?MODULE,"BPE Start: ~p~n",[bpe:start(P,[])]);
worker_do({Days,Time},P) -> skip.
