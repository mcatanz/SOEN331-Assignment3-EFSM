%Start and Final States
start(dormant).
final(final).

%States
state(idle).
state(init).
state(dormant).
state(monitoring).
state(error_diagnosis).
state(safe_shutdown).

%States in the init state
state(boot_hw).
state(senchk).
state(tchk).
state(psichk).
state(ready).


%Superstates
superstate(init, boot_hw).
superstate(init, senchk).
superstate(init, tchk).
superstate(init, psichk).
superstate(init, ready).


% Initial states
initial_state(dormant, null).
initial_state(boot_hw, init).

% Top-level Transitions written in the form
% transition(Source, Destination, Event, Guard, Action1, Action2)
transition(idle , final, kill, null, null).
transition(init , final, kill, null, null).
transition(dormant ,final, kill, null, null).
transition(monitoring, final, kill, null, null).
transition(safe_shutdown, final, kill, null, null).
transition(error_diagnosis, final, kill, null, null).
transition(dormant, init, start, null, null).
transition(init, idle, init_ok, null, null).
transition(idle, monitoring, begin_monitoring, null, null).
transition(init, error_diagnosis, init_crash, null, init_err_msg).
transition(idle, error_diagnosis, idle_crash, null, idle_err_msg).
transition(monitoring, error_diagnosis, monitor_crash, null, moni_err_msg).
transition(error_diagnosis, init, retry_init, retry<3, null).
transition(error_diagnosis, idle, idle_rescue, null, null).
transition(error_diagnosis, monitorings, moni_rescue, null, null).

%Transitions in the init state
transition(boot_hw, senchk, hw_ok, null, null).
transition(senchk, tchk, senok, null, null).
transition(tchk, psichk, t_ok, null, null).
transition(psichk, ready, psi_ok, null, null).
