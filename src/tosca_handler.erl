%% @author Tobias Rodaebel
%% @doc Tosca Event Handler

-module(tosca_handler).

-behaviour(gen_event).

%% API 
-export([start/1, stop/0]).

%% Callbacks of the gen_event behaviour
-export([init/1, code_change/3, handle_event/2, handle_call/2, handle_info/2,
         terminate/2]).

%% @doc Starts the handler.
%% @spec start(Options) -> already_started | ok
start(Options) ->
    case lists:member(?MODULE, gen_event:which_handlers(tosca_event)) of
        true  ->
            already_started;
        false ->
            gen_event:add_sup_handler(tosca_event, ?MODULE, Options)
    end.

%% @doc Stops the handler.
%% @spec stop() -> ok
stop() ->
    gen_event:delete_handler(tosca_event, ?MODULE, []).

%% @doc Initializes the handler.
%% @spec init(Args) -> {ok, initialized}
init(_Args) ->
    {ok, initialized}.

%% @private
%% @doc Handles events.
%% @spec handle_event(Event, State) -> {ok, State}
handle_event(Event, State)->
    error_logger:info_msg("~p ~p~n", [self(), Event]),
    {ok, State}.

%% @private
%% @doc Handles call messages.
%% @spec handle_call(Request, State) -> {ok, {error, bad_query}, Events}
handle_call(_Query, State) ->
    {ok, {error, bad_request}, State}.

%% @private
%% @doc Handles all non call/cast messages.
%% @spec handle_info(Info, State) -> {noreply, State}
handle_info(_Info, State) ->
    {noreply, State}.

%% @private
%% @doc Performs cleanup on termination.
%% @spec terminate(Reason, State) -> ok
terminate(_Reason, _Events) ->
    ok.

%% @private
%% @doc Converts process state when code is changed.
%% @spec code_change(OldVsn, Library, Extra) -> {ok, Library}
code_change(_OldVsn, Library, _Extra) ->
    {ok, Library}.
