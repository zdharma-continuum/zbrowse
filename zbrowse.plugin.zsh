#
# No plugin manager is needed to use this file. All that is needed is adding:
#   source {where-zbrowse-is}/zbrowse.plugin.zsh
#
# to ~/.zshrc.
#

ZERO="${(%):-%N}" # this gives immunity to functionargzero being unset
ZBROWSE_REPO_DIR="${ZERO%/*}"

[[ ! -d "${XDG_CONFIG_HOME:-$HOME/.config}/zbrowse" ]] && command mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}/zbrowse"

#
# Update FPATH if:
# 1. Not loading with Zplugin
# 2. Not having fpath already updated (that would equal: using other plugin manager)
#

if [[ -z "$ZPLG_CUR_PLUGIN" && "${fpath[(r)$ZBROWSE_REPO_DIR]}" != $ZBROWSE_REPO_DIR ]]; then
    fpath+=( "$ZBROWSE_REPO_DIR" )
fi

autoload zbrowse
zle -N zbrowse
bindkey '^B' zbrowse

zmodload zsh/parameter || { echo "No zsh/parameter module, zdharma/zbrowse not registering itself"; return 0 }

# Holds 1) all defined parameters, 2) ZBROWSE_IPARAMS'
# values, both at preexec. Keys are "types", "values"
typeset -gAH ZBROWSE_BEFORE

# Holds interactively defined parameters
typeset -gaUH ZBROWSE_IPARAMS

# Holds parameters that changed recently, order matters
typeset -gaUH ZBROWSE_CHANGED_IPARAMS

# Holds types of parameters before change
typeset -gH ZBROWSE_IPARAMS_PRE

# Holds types of parameters after change
typeset -gH ZBROWSE_IPARAMS_POST

# Holds black-listed parameters
typeset -gaH ZBROWSE_BLACK_LIST
ZBROWSE_BLACK_LIST=(
    '?' '*' '$' '#' '!' '@'

    ZUI_PB_WORDS
    ZUI_PB_LEFT
    ZUI_PB_WORDS_BEGINNINGS
    ZUI_PB_RIGHT
    ZUI_PB_SPACES
    ZUI_PB_SELECTED_WORD

    ZUILIST_NONSELECTABLE_ELEMENTS
    ZUILIST_HOP_INDICES
    ZUILIST_ACTIVE_SEGMENTS

    zcurses_attrs
    zcurses_keycodes
    zcurses_windows
    zcurses_colors
    ZCURSES_COLORS
    ZCURSES_COLOR_PAIRS
)

# Ran before command
__zbrowse_preexec() {
    ZBROWSE_BEFORE[types]="${(j: :)${(qkv)parameters[@]}}"

    return 0
}

# Ran after command
__zbrowse_precmd() {
    builtin setopt localoptions extendedglob

    local ZBROWSE_TYPES_AFTER="${(j: :)${(qkv)parameters[@]}}"

    # Paranoid defence against the parameters being only spaces
    [[ "${ZBROWSE_BEFORE[types]}" != *[$'! \t']* || "$ZBROWSE_TYPES_AFTER" != *[$'! \t']* ]] && return 0

    # De-concatenated parameters
    local -A params_before params_after
    params_before=( "${(z)ZBROWSE_BEFORE[types]}" )
    params_after=( "${(z)ZBROWSE_TYPES_AFTER}" )
    ZBROWSE_BEFORE[types]=""

    # The parameters that changed, with save of what
    # parameter was when diff started or when diff ended
    typeset -A params_pre params_post
    params_pre=( )
    params_post=( )

    # Iterate through all existing keys, before or after diff,
    # i.e. after all variables that were somehow live across
    # the diffing process
    local key
    typeset -aU keys
    keys=( "${(k)params_after[@]}" "${(k)params_before[@]}" );
    for key in "${keys[@]}"; do
        key="${(Q)key}"

        # Checks if given parameter is from black-list
        [[ -n "${ZBROWSE_BLACK_LIST[(er)$key]}" ]] && continue

        if [[ -z "${params_before[$key]}" ]]; then
            ZBROWSE_IPARAMS+=( "$key" )
            ZBROWSE_CHANGED_IPARAMS[1,0]=( "$key" )
        elif [[ "${params_after[$key]}" != "${params_before[$key]}" ]]; then
            ZBROWSE_CHANGED_IPARAMS[1,0]=( "$key" )
            # Empty for a new param, a type otherwise
            [[ -z "${params_before[$key]}" ]] && params_before[$key]="\"\""
            params_pre[$key]="${params_before[$key]}"

            # Current type, can also be empty, when plugin
            # unsets a parameter
            [[ -z "${params_after[$key]}" ]] && params_after[$key]="\"\""
            params_post[$key]="${params_after[$key]}"
        fi
    done

    # Serialize
    ZBROWSE_IPARAMS_PRE+="${(j: :)${(qkv)params_pre[@]}}"
    ZBROWSE_IPARAMS_POST+="${(j: :)${(qkv)params_post[@]}}"
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec __zbrowse_preexec
add-zsh-hook precmd __zbrowse_precmd

