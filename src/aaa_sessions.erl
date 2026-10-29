%% Active SWm and S6b sessions per IMSI.
%%
%% aaa_ue_fsm keeps one state machine per IMSI with a single flag for the access (SWm) side and
%% one for the PGW (S6b) side. A VoWiFi UE has several PDN connections at once (ims, hos/xcap,
%% internet), each with its own SWm session (own IKE SA on the ePDG) and its own S6b session, so
%% those flags cannot tell when the user is really gone. The Diameter callbacks track the
%% Session-Ids here and only hand a termination to the FSM for the last session of its kind;
%% the others are answered directly. This follows TS 29.273 8.1.2.2.2.1: the HSS is told
%% USER_DEREGISTRATION "after all sessions for the user (i.e. the STa, SWm, S6b sessions) have
%% been terminated", and 7.1.2.3.2 / 9.1.2.3.3: an STR for an active session is answered with
%% DIAMETER_SUCCESS after releasing that session.
-module(aaa_sessions).

-export([new/1, add/3, take/2, imsi/2, count/2]).

%% Called from the init/1 of the gen_server that owns the table (it lives as long as the app).
new(Table) ->
	ets:new(Table, [set, public, named_table]).

add(Table, SessionId, Imsi) ->
	ets:insert(Table, {SessionId, Imsi}),
	ok.

imsi(Table, SessionId) ->
	case ets:lookup(Table, SessionId) of
	[{_, Imsi}] -> Imsi;
	[] -> undefined
	end.

count(Table, Imsi) ->
	ets:select_count(Table, [{{'_', Imsi}, [], [true]}]).

%% Removes the session. Returns {ok, Imsi, SessionsLeftForImsi} or unknown.
take(Table, SessionId) ->
	case ets:take(Table, SessionId) of
	[{_, Imsi}] -> {ok, Imsi, count(Table, Imsi)};
	[] -> unknown
	end.
