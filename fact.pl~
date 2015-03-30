%Start and Final States
start(dormant).
final(final).

%Top-level States
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

%States in the monitor state
state(monidle).
state(regulate_environment).
state(lockdown).

%Superstates
superstate(init, boot_hw).
superstate(init, senchk).
superstate(init, tchk).
superstate(init, psichk).
superstate(init, ready).
superstate(monitoring, monidle).
superstate(monitoring, regulate_environment).
superstate(monitoring, lockdown).

% Initial states
initial_state(dormant, null).
initial_state(boot_hw, init).
initial_state(monidle, monitoring).

% Top-level Transitions written in the form
%transition(Source,Destination, Event, Guard, Action1, Action2)
transition(idle , final, kill, null, null, null).
transition(init , final, kill, null, null, null).
transition(dormant ,final, kill, null, null, null).
transition(monitoring, final, kill, null, null, null).
transition(safe_shutdown, final, kill, null, null, null).
transition(error_diagnosis, final, kill, null, null, null).
transition(dormant, init, start, null, null, null).
transition(init, idle, init_ok, null, null, null).
transition(idle, monitoring, begin_monitoring, null, null, null).
transition(init, error_diagnosis, init_crash, null, init_err_msg, null).
transition(idle, error_diagnosis, idle_crash, null, idle_err_msg, null).
transition(monitoring, error_diagnosis, monitor_crash, null, moni_err_msg, null).
transition(error_diagnosis, init, retry_init, retry<3, null, null).
transition(error_diagnosis, idle, idle_rescue, null, null, null).
transition(error_diagnosis, monitorings, moni_rescue, null, null, null).

%Transitions in the init state
transition(boot_hw, senchk, hw_ok, null, null, null).
transition(senchk, tchk, senok, null, null, null).
transition(tchk, psichk, t_ok, null, null, null).
transition(psichk, ready, psi_ok, null, null, null).

%Transitions in the monitoring state
transition(monidle, regulate_environment, no_contagion, null, null, null).
transition(regulate_environment, monidle, after_100ms, null, null, null).
transition(regulate_environment, lockdown, contagion_alert, null, facility_crit_mesg, inlockdown = true).
transition(lockdown, monidle, purge_succ, null, lockdown = false, null).
transition(monitoring, monitoring, null, [lockdown == true], null, null).


