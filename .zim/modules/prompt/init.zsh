#
# Load user-defined prompt
#

[[ ${TERM} == 'dumb' ]] && return 1

local -a zprompt_array
autoload -Uz promptinit && promptinit && \
  zstyle -a ':zim:prompt' theme 'zprompt_array' && prompt ${zprompt_array}
