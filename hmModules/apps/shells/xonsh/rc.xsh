#!/usr/bin/env xonsh

if $XONSH_INTERACTIVE:
  if '__HM_SESS_VARS_SOURCED' in ${...}:
    del $__HM_SESS_VARS_SOURCED
  source-bash "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" --suppress-skip-message
  cat "$HOME/.cache/wallust/sequences"
