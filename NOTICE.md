# Notices

VectorCore AAA is derived from the Osmocom osmo-epdg project.

Original Osmocom copyright notices and license terms are preserved in the source tree where applicable.

VectorCore-specific modifications are copyright their respective authors/contributors.

This project is not affiliated with, sponsored by, or endorsed by the Osmocom project.

## Modifications in this fork (itskimffs/vectorcore-aaa)

This fork of vectorcore-mobile/vectorcore-aaa (upstream commit 7dc609e) is distributed under the
same GNU Affero General Public License version 3 or later, including the additional permission
for Erlang/OTP under section 7. Changes by itskimffs, each modified file carries a notice:

- 2026-10: SWx MAR – on a first (non-resync) SWm authentication no SIP-Authorization is sent
  (`src/aaa_ue_fsm.erl`).
- 2026-10: SWm/S6b Session-Termination per session and support for several PDN connections per
  UE: SWm STR grammar extended (DRMP, Destination-Host, OC-Supported-Features), malformed SWm STR
  answered with an STA, new `src/aaa_sessions.erl` (Copyright (C) 2026 itskimffs) tracking SWm and
  S6b sessions per IMSI, FSM handling of terminations during (re-)authentication
  (`dia/diameter_3gpp_ts29_273_swm.dia`, `src/aaa_diameter_swm.erl`, `src/aaa_diameter_swm_cb.erl`,
  `src/aaa_diameter_s6b.erl`, `src/aaa_diameter_s6b_cb.erl`, `src/aaa_ue_fsm.erl`).
  `include/diameter_3gpp_ts29_273_swm.hrl` and `src/diameter_3gpp_ts29_273_swm.erl` are generated
  from the `.dia` file and changed with it.
