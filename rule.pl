append([],Lst1,Lst1).
append([H|T],Lst2,[H|Lst3])  :-  append(T,Lst2,Lst3).

is_loop(Event, Guard) :-
	transition(Source,Destination,Event,Guard,_,_),
	Source =:= Destination.

all_loops(Set) :-
	findall(Event-Guard,(transition(Source, Destination,Event,Guard,_,_),
			     Source =:= Destination),Lst),
	list_to_set(Lst, Set).

is_edge(Event, Guard) :-
	findall(Event-Guard,transition(_,_,Event,Guard,_,_),Lst),
	length(Lst, N),
	N >= 1.

size(Length) :-
	findall(State, transition(State,_,_,_,_,_), Lst),
	length(Lst, Length).

is_link(Event, Guard) :-
	transition(_, _,Event, Guard,_,_).

all_superstates(Set) :-
	findall(SState, superstate(SState,_), Lst),
	list_to_set(Lst, Set).

ancestor(Ancestor, Descendant) :-
	superstate(Ancestor,Descendant).

inheritss_transitions(State, List) :-
	findall(State-D-E-G-A1-A2,(state(State),transition(State,D,E,G,A1,A2)),List).

all_states(L) :-
	findall(S, state(S), L).

all_init_states(L) :-
	findall(State, initial_state(State, _), L).

get_starting_state(State) :-
	initial_state(State,null).

state_is_reflexive(State) :-
	findall(Event,transition(State,State,Event,_,_,_),Lst),
	length(Lst,N),
	N >= 1.

graph_is_reflexive :-
	get_starting_state(State),
	transition(State,NextState,_,_,_,_),
	graph_is_reflexive(State,NextState).

graph_is_reflexive(StartState,NextState) :-
	transition(NextState,StartState,_,_,_).

graph_is_reflexive(StartState,NextState) :-
	transition(NextState,NextNextState,_,_,_),
	graph_is_reflexive(StartState,NextNextState).

get_guards(Ret) :-
	findall(Guards, transition(_,_,_,Guards,_,_),Lst),
	list_to_set(Lst,Ret).

get_events(Ret) :-
	findall(Events, transition(_,_,Events,_,_,_),Lst),
	list_to_set(Lst,Ret).

get_actions(Ret) :-
	findall(Action1, transition(_,_,_,_,Action1,_),Lst1),
	findall(Action2, transition(_,_,_,_,_,Action2),Lst2),
	append(Lst1, Lst2, Lst3),
	list_to_set(Lst3, Ret).

get_only_guarded(Ret) :-
	findall(State1-State2, (transition(State1, State2,_,Guard,_,_),Guard =\= null),Lst),
	list_to_set(Lst, Ret).

legal_events_of(State, L) :-
	findall(Event-Guard,transition(State,_,Event,Guard,_,_),L).

