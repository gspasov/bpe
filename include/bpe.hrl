-ifndef(BPE_HRL).
-define(BPE_HRL, true).

-include_lib("kvs/include/kvs.hrl").

% BPMN 2.0 API

-record(task,         { name=[] :: [] | atom(),
                        module=[] :: [] | atom(),
                        prompt=[] :: list(tuple()),
                        roles=[] :: binary() }).
-record(userTask,     { name=[] :: [] | atom(),
                        module=[] :: [] | atom(),
                        prompt=[] :: list(tuple()),
                        roles=[] :: [] | binary() }).
-record(serviceTask,  { name=[] :: [] | atom(),
                        module=[] :: [] | atom(),
                        prompt=[] :: list(tuple()),
                        roles=[] :: [] | binary()}).
-record(receiveTask,  { name=[] :: [] | atom(),
                        module=[] :: [] | atom(),
                        prompt=[] :: list(tuple()),
                        roles=[] :: binary()}).
-record(messageEvent, { name=[] :: [] | atom(),
                        module=[] :: [] | atom(),
                        prompt=[] :: list(tuple()),
                        payload=[] :: [] | binary(),
                        timeout=[] :: {integer(),{integer(),integer(),integer()}} }).
-record(boundaryEvent,{ name=[] :: [] | atom(),
                        module=[] :: [] | atom(),
                        prompt=[] :: list(tuple()),
                        payload=[] :: binary(),
                        timeout=[] :: {integer(),{integer(),integer(),integer()}},
                        timeDate=[] :: binary(),
                        timeDuration=[] :: binary(),
                        timeCycle=[] :: binary() }).
-record(timeoutEvent, { name=[] :: [] | atom(),
                        module=[] :: [] | atom(),
                        prompt=[] :: list(tuple()),
                        payload=[] :: [] | binary(),
                        timeout=[] :: [] | {integer(),{integer(),integer(),integer()}},
                        timeDate=[] :: [] | binary(),
                        timeDuration=[] :: [] | binary(),
                        timeCycle=[] :: [] | binary() }).
-record(beginEvent ,  { name=[] :: [] | atom(),
                        module=[] :: [] | atom(),
                        prompt=[] :: list(tuple())}).
-record(endEvent,     { name=[] :: [] | atom(),
                        module=[] :: [] | atom(),
                        prompt=[] :: list(tuple())}).
-record(sequenceFlow, { source=[] :: [] | atom(),
                        target=[] :: [] | atom() | list(atom()) }).
-record(hist,         { ?ITERATOR(feed),
                        name=[] :: [] | binary(),
                        task=[] :: atom(),
                        docs=[] :: list(tuple()),
                        time=[] :: term() }).
-record(process,      { ?ITERATOR(feed), name=[] :: [] | binary(),
                        roles=[] :: list(),
                        tasks=[] :: list(#task{} | #serviceTask{} | #userTask{} | #receiveTask{}),
                        events=[] :: list(#messageEvent{} | #boundaryEvent{} | #timeoutEvent{}),
                        hist=[] :: [],
                        flows=[] :: list(#sequenceFlow{}),
                        rules=[] :: [],
                        docs=[] :: list(tuple()),
                        options=[] :: term(),
                        task='Init' :: [] | atom(),
                        timer=[] :: [] | binary(),
                        notifications=[] :: [] | term(),
                        result=[] :: [] | binary(),
                        started=[] :: [] | {term(),term(),term()},
                        beginEvent=[] :: [] | atom(),
                        endEvent=[] :: [] | atom()}).

% BPE API

-record(complete,     { id=[] :: [] | integer() }).
-record(proc,         { id=[] :: [] | integer() }).
-record(load,         { id=[] :: [] | integer() }).
-record(histo,        { id=[] :: [] | integer() }).
-record(create,       { proc=[] :: [] | #process{} | binary(),
                        docs=[] :: [] | list(tuple()) }).
-record(amend,        { id=[] :: [] | integer(),
                        docs=[] :: [] | list(tuple()) }).

-endif.
