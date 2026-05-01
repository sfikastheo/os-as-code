{ pkgs }:

let
  isDarwin = pkgs.stdenv.isDarwin;

  # special modifier key
  modKey = if isDarwin then "rmet" else "ralt";

  # physical bottom row source
  bottomRowSrc =
    if isDarwin then
      "fn  lctl lalt lmet      spc             rmet ralt"
    else
      "lctl lmet lalt           spc            ralt rmet rctl";

  bottomRowBase =
    if isDarwin then
      "_    _    _    _         @spc-sym       _    _"
    else
      "_    _    _              @spc-sym       _    _    _";

  bottomRowSym =
    if isDarwin then
      "_    _    _    _         _              _    _"
    else
      "_    _    _              _              _    _    _";

  topRowFn =
    if isDarwin then
      "_    🔅   🔆   mctl sls  dtn  dnd  ◀◀   ▶⏸   ▶▶   🔇   🔉   🔊"
    else
      "_    _    _    _    _    _    _    _    _    _    _    _    _";

  # platform specific configurations
  platformSpecificDefCfg =
    if isDarwin then
      ''
        ;; kanata -l
        macos-dev-names-exclude (
          "Voyager"
        )
      ''
    else
      ''
        ;; evtest
        linux-dev-names-exclude (
          "ZSA Technology Labs Voyager"
        )
      '';
in
''
  (defcfg
    process-unmapped-keys no
    ${platformSpecificDefCfg}
  )


  ;; ------ physical layout ------

  (defsrc
    esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12
    grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
    tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
    caps a    s    d    f    g    h    j    k    l    ;    '    ret
    lsft z    x    c    v    b    n    m    ,    .    /    rsft
    ${bottomRowSrc}
  )

  ;; ------ aliases ------

  (defalias
    ;; Space: hold for symbol layer
    spc-sym (tap-hold 200 200 spc (layer-while-held sym))

    ;; Backtick: grv alone, ${modKey}+grv switches layers
    qwt (fork grv (layer-switch qwerty) (${modKey}))
    col (fork grv (layer-switch colemak) (${modKey}))
  )


  ;; ------ layers ------

  (deflayer colemak
    ${topRowFn}
    @qwt 9    7    1    3    5    4    2    0    6    8    _    _    _
    _    q    w    f    p    b    j    l    u    y    ;    _    _    _
    _    a    r    s    t    g    m    n    e    i    o    _    _
    _    z    x    c    d    v    k    h    ,    .    /    _
    ${bottomRowBase}
  )

  (deflayer qwerty
    _    _    _    _    _    _    _    _    _    _    _    _    _
    @col _    _    _    _    _    _    _    _    _    _    _    _    _
    _    _    _    _    _    _    _    _    _    _    _    _    _    _
    _    _    _    _    _    _    _    _    _    _    _    _    _
    _    _    _    _    _    _    _    _    _    _    _    _
    ${bottomRowBase}
  )

  ;; Symbol layer layout:
  ;;     grv  <    (    [    {    }    ]    )    >    %
  ;;     '    $    +    =    !    |    -    _    "    ;
  ;;     ~    /    &    *    ^    #    :    ?    \    @

  (deflayer sym
    _    _    _    _    _    _    _    _    _    _    _    _    _
    _    _    _    _    _    _    _    _    _    _    _    _    _   _
    _    grv  S-,  S-9  [    S-[  S-]  ]    S-0  S-.  S-5  _    _   _
    _    '    S-4  S-=  =    S-1  S-\  -    S--  S-'  ;    _    _
    _    S-grv /   S-7  S-8  S-6  S-3  S-;  S-/  \    S-2  _
    ${bottomRowSym}
  )
''
