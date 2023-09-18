# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2001
#heh
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#my stuffsss
if [ "$(which nvim)" == "" ]; then
  sudo add-apt-repository ppa:neovim-ppa/unstable
  sudo apt-get update
  sudo apt-get install neovim 
fi 
alias vim=nvim

if [ "$(which eza)" == "" ]; then
 sudo wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo tee /etc/apt/trusted.gpg.d/gierens.asc
  echo "deb http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
  sudo apt update
  sudo apt install -y eza
  echo "EZA installed"
fi

alias ls='eza --icons --hyperlink -T --level=1 --group-directories-first --color always -s=name'

if [ "$(which oh-my-posh)" == "" ]; then
  echo "Installing oh-my-posh and CascadiaCode font..."
  sudo curl -s https://ohmyposh.dev/install.sh | bash -s
  oh-my-posh font install CascadiaCode
  echo "Installed"
else
  if [ -d "$HOME/.config/ohmyposh" ] ; then
     eval "$(oh-my-posh init bash --config $HOME/.config/ohmyposh/ohmyposhconfig.json)"
  else
    eval "$(oh-my-posh init bash)"
    echo "config file doesn't exist"
    echo "initializing default configs"
  fi 
fi

export LS_COLORS="st=0:rs=0:ex=1;38;2;255;92;87:fi=0:do=0;38;2;0;0;0;48;2;255;106;193:sg=0:no=0:tw=0:su=0:or=0;38;2;0;0;0;48;2;255;92;87:mi=0;38;2;0;0;0;48;2;255;92;87:cd=0;38;2;255;106;193;48;2;51;51;51:di=0;38;2;87;199;255:ca=0:pi=0;38;2;0;0;0;48;2;87;199;255:bd=0;38;2;154;237;254;48;2;51;51;51:ln=0;38;2;255;106;193:so=0;38;2;0;0;0;48;2;255;106;193:mh=0:*~=0;38;2;102;102;102:ow=0:*.h=0;38;2;90;247;142:*.t=0;38;2;90;247;142:*.a=1;38;2;255;92;87:*.d=0;38;2;90;247;142:*.p=0;38;2;90;247;142:*.z=4;38;2;154;237;254:*.c=0;38;2;90;247;142:*.r=0;38;2;90;247;142:*.m=0;38;2;90;247;142:*.o=0;38;2;102;102;102:*.ex=0;38;2;90;247;142:*.bc=0;38;2;102;102;102:*.sh=0;38;2;90;247;142:*.gz=4;38;2;154;237;254:*.7z=4;38;2;154;237;254:*.hh=0;38;2;90;247;142:*.gv=0;38;2;90;247;142:*.fs=0;38;2;90;247;142:*.rs=0;38;2;90;247;142:*.pl=0;38;2;90;247;142:*.ko=1;38;2;255;92;87:*.pm=0;38;2;90;247;142:*.di=0;38;2;90;247;142:*.xz=4;38;2;154;237;254:*.wv=0;38;2;255;180;223:*.cc=0;38;2;90;247;142:*.cp=0;38;2;90;247;142:*.as=0;38;2;90;247;142:*.kt=0;38;2;90;247;142:*.js=0;38;2;90;247;142:*.nb=0;38;2;90;247;142:*.so=1;38;2;255;92;87:*.cr=0;38;2;90;247;142:*.pp=0;38;2;90;247;142:*.go=0;38;2;90;247;142:*.la=0;38;2;102;102;102:*.md=0;38;2;243;249;157:*.hs=0;38;2;90;247;142:*.ui=0;38;2;243;249;157:*.lo=0;38;2;102;102;102:*.el=0;38;2;90;247;142:*.rm=0;38;2;255;180;223:*.hi=0;38;2;102;102;102:*.bz=4;38;2;154;237;254:*.mn=0;38;2;90;247;142:*.td=0;38;2;90;247;142:*css=0;38;2;90;247;142:*.ps=0;38;2;255;92;87:*.ts=0;38;2;90;247;142:*.py=0;38;2;90;247;142:*.cs=0;38;2;90;247;142:*.ll=0;38;2;90;247;142:*.rb=0;38;2;90;247;142:*.jl=0;38;2;90;247;142:*.ml=0;38;2;90;247;142:*.vb=0;38;2;90;247;142:*.pdf=0;38;2;255;92;87:*.m4v=0;38;2;255;180;223:*.nix=0;38;2;243;249;157:*.psd=0;38;2;255;180;223:*.img=4;38;2;154;237;254:*.csv=0;38;2;243;249;157:*.asa=0;38;2;90;247;142:*.odt=0;38;2;255;92;87:*.rtf=0;38;2;255;92;87:*.pkg=4;38;2;154;237;254:*.csx=0;38;2;90;247;142:*.tex=0;38;2;90;247;142:*.flv=0;38;2;255;180;223:*.zip=4;38;2;154;237;254:*.doc=0;38;2;255;92;87:*.pid=0;38;2;102;102;102:*.fsi=0;38;2;90;247;142:*.pro=0;38;2;165;255;195:*.xml=0;38;2;243;249;157:*.hpp=0;38;2;90;247;142:*.lua=0;38;2;90;247;142:*.eps=0;38;2;255;180;223:*.arj=4;38;2;154;237;254:*.wmv=0;38;2;255;180;223:*.aif=0;38;2;255;180;223:*.fnt=0;38;2;255;180;223:*hgrc=0;38;2;165;255;195:*.yml=0;38;2;243;249;157:*.tml=0;38;2;243;249;157:*.elm=0;38;2;90;247;142:*.log=0;38;2;102;102;102:*.bsh=0;38;2;90;247;142:*.ico=0;38;2;255;180;223:*.mid=0;38;2;255;180;223:*.bag=4;38;2;154;237;254:*.rst=0;38;2;243;249;157:*.tgz=4;38;2;154;237;254:*.bbl=0;38;2;102;102;102:*.mli=0;38;2;90;247;142:*.pyd=0;38;2;102;102;102:*.xmp=0;38;2;243;249;157:*.m4a=0;38;2;255;180;223:*.com=1;38;2;255;92;87:*.sbt=0;38;2;90;247;142:*.php=0;38;2;90;247;142:*.xlr=0;38;2;255;92;87:*.mp3=0;38;2;255;180;223:*.ogg=0;38;2;255;180;223:*.mkv=0;38;2;255;180;223:*.otf=0;38;2;255;180;223:*.mov=0;38;2;255;180;223:*.bin=4;38;2;154;237;254:*.ics=0;38;2;255;92;87:*.idx=0;38;2;102;102;102:*.fls=0;38;2;102;102;102:*.tcl=0;38;2;90;247;142:*.swf=0;38;2;255;180;223:*.pbm=0;38;2;255;180;223:*.apk=4;38;2;154;237;254:*.png=0;38;2;255;180;223:*.h++=0;38;2;90;247;142:*.epp=0;38;2;90;247;142:*.gif=0;38;2;255;180;223:*.pyo=0;38;2;102;102;102:*.swp=0;38;2;102;102;102:*.jar=4;38;2;154;237;254:*.rpm=4;38;2;154;237;254:*.inc=0;38;2;90;247;142:*.tbz=4;38;2;154;237;254:*.vob=0;38;2;255;180;223:*TODO=1:*.ltx=0;38;2;90;247;142:*.rar=4;38;2;154;237;254:*.htm=0;38;2;243;249;157:*.mir=0;38;2;90;247;142:*.txt=0;38;2;243;249;157:*.dmg=4;38;2;154;237;254:*.tmp=0;38;2;102;102;102:*.bst=0;38;2;243;249;157:*.deb=4;38;2;154;237;254:*.ppm=0;38;2;255;180;223:*.bcf=0;38;2;102;102;102:*.ps1=0;38;2;90;247;142:*.zst=4;38;2;154;237;254:*.ini=0;38;2;243;249;157:*.fsx=0;38;2;90;247;142:*.dll=1;38;2;255;92;87:*.wma=0;38;2;255;180;223:*.def=0;38;2;90;247;142:*.sxi=0;38;2;255;92;87:*.tar=4;38;2;154;237;254:*.iso=4;38;2;154;237;254:*.jpg=0;38;2;255;180;223:*.pod=0;38;2;90;247;142:*.pyc=0;38;2;102;102;102:*.ttf=0;38;2;255;180;223:*.kex=0;38;2;255;92;87:*.blg=0;38;2;102;102;102:*.ipp=0;38;2;90;247;142:*.aux=0;38;2;102;102;102:*.cfg=0;38;2;243;249;157:*.cxx=0;38;2;90;247;142:*.ods=0;38;2;255;92;87:*.bz2=4;38;2;154;237;254:*.awk=0;38;2;90;247;142:*.cgi=0;38;2;90;247;142:*.bmp=0;38;2;255;180;223:*.htc=0;38;2;90;247;142:*.kts=0;38;2;90;247;142:*.gvy=0;38;2;90;247;142:*.toc=0;38;2;102;102;102:*.erl=0;38;2;90;247;142:*.pps=0;38;2;255;92;87:*.fon=0;38;2;255;180;223:*.tsx=0;38;2;90;247;142:*.sxw=0;38;2;255;92;87:*.odp=0;38;2;255;92;87:*.sql=0;38;2;90;247;142:*.vcd=4;38;2;154;237;254:*.exs=0;38;2;90;247;142:*.ilg=0;38;2;102;102;102:*.out=0;38;2;102;102;102:*.bak=0;38;2;102;102;102:*.dpr=0;38;2;90;247;142:*.hxx=0;38;2;90;247;142:*.exe=1;38;2;255;92;87:*.wav=0;38;2;255;180;223:*.zsh=0;38;2;90;247;142:*.xcf=0;38;2;255;180;223:*.svg=0;38;2;255;180;223:*.ppt=0;38;2;255;92;87:*.inl=0;38;2;90;247;142:*.git=0;38;2;102;102;102:*.tif=0;38;2;255;180;223:*.pgm=0;38;2;255;180;223:*.avi=0;38;2;255;180;223:*.mp4=0;38;2;255;180;223:*.bib=0;38;2;243;249;157:*.pas=0;38;2;90;247;142:*.c++=0;38;2;90;247;142:*.mpg=0;38;2;255;180;223:*.sty=0;38;2;102;102;102:*.ind=0;38;2;102;102;102:*.dot=0;38;2;90;247;142:*.clj=0;38;2;90;247;142:*.vim=0;38;2;90;247;142:*.dox=0;38;2;165;255;195:*.cpp=0;38;2;90;247;142:*.xls=0;38;2;255;92;87:*.bat=1;38;2;255;92;87:*.bash=0;38;2;90;247;142:*.psd1=0;38;2;90;247;142:*.json=0;38;2;243;249;157:*.hgrc=0;38;2;165;255;195:*.lisp=0;38;2;90;247;142:*.toml=0;38;2;243;249;157:*.xlsx=0;38;2;255;92;87:*.mpeg=0;38;2;255;180;223:*.lock=0;38;2;102;102;102:*.dart=0;38;2;90;247;142:*.conf=0;38;2;243;249;157:*.fish=0;38;2;90;247;142:*.orig=0;38;2;102;102;102:*.purs=0;38;2;90;247;142:*.webm=0;38;2;255;180;223:*.opus=0;38;2;255;180;223:*.diff=0;38;2;90;247;142:*.make=0;38;2;165;255;195:*.java=0;38;2;90;247;142:*.tiff=0;38;2;255;180;223:*.epub=0;38;2;255;92;87:*.less=0;38;2;90;247;142:*.flac=0;38;2;255;180;223:*.yaml=0;38;2;243;249;157:*.html=0;38;2;243;249;157:*.h264=0;38;2;255;180;223:*.docx=0;38;2;255;92;87:*.tbz2=4;38;2;154;237;254:*.jpeg=0;38;2;255;180;223:*.pptx=0;38;2;255;92;87:*.rlib=0;38;2;102;102;102:*.psm1=0;38;2;90;247;142:*.shtml=0;38;2;243;249;157:*.ipynb=0;38;2;90;247;142:*.swift=0;38;2;90;247;142:*.xhtml=0;38;2;243;249;157:*.toast=4;38;2;154;237;254:*.patch=0;38;2;90;247;142:*.cache=0;38;2;102;102;102:*.class=0;38;2;102;102;102:*README=0;38;2;40;42;54;48;2;243;249;157:*.cmake=0;38;2;165;255;195:*.mdown=0;38;2;243;249;157:*.cabal=0;38;2;90;247;142:*.scala=0;38;2;90;247;142:*shadow=0;38;2;243;249;157:*.dyn_o=0;38;2;102;102;102:*passwd=0;38;2;243;249;157:*.flake8=0;38;2;165;255;195:*COPYING=0;38;2;153;153;153:*.dyn_hi=0;38;2;102;102;102:*LICENSE=0;38;2;153;153;153:*.matlab=0;38;2;90;247;142:*.ignore=0;38;2;165;255;195:*.config=0;38;2;243;249;157:*.groovy=0;38;2;90;247;142:*TODO.md=1:*.gradle=0;38;2;90;247;142:*INSTALL=0;38;2;40;42;54;48;2;243;249;157:*.gemspec=0;38;2;165;255;195:*Doxyfile=0;38;2;165;255;195:*setup.py=0;38;2;165;255;195:*.desktop=0;38;2;243;249;157:*TODO.txt=1:*Makefile=0;38;2;165;255;195:*configure=0;38;2;165;255;195:*.fdignore=0;38;2;165;255;195:*.markdown=0;38;2;243;249;157:*.kdevelop=0;38;2;165;255;195:*README.md=0;38;2;40;42;54;48;2;243;249;157:*.DS_Store=0;38;2;102;102;102:*.rgignore=0;38;2;165;255;195:*.cmake.in=0;38;2;165;255;195:*COPYRIGHT=0;38;2;153;153;153:*INSTALL.md=0;38;2;40;42;54;48;2;243;249;157:*SConstruct=0;38;2;165;255;195:*.gitignore=0;38;2;165;255;195:*README.txt=0;38;2;40;42;54;48;2;243;249;157:*SConscript=0;38;2;165;255;195:*.gitconfig=0;38;2;165;255;195:*CODEOWNERS=0;38;2;165;255;195:*.scons_opt=0;38;2;102;102;102:*.localized=0;38;2;102;102;102:*Dockerfile=0;38;2;243;249;157:*MANIFEST.in=0;38;2;165;255;195:*.travis.yml=0;38;2;90;247;142:*LICENSE-MIT=0;38;2;153;153;153:*Makefile.am=0;38;2;165;255;195:*.gitmodules=0;38;2;165;255;195:*Makefile.in=0;38;2;102;102;102:*INSTALL.txt=0;38;2;40;42;54;48;2;243;249;157:*.synctex.gz=0;38;2;102;102;102:*configure.ac=0;38;2;165;255;195:*CONTRIBUTORS=0;38;2;40;42;54;48;2;243;249;157:*.fdb_latexmk=0;38;2;102;102;102:*appveyor.yml=0;38;2;90;247;142:*.applescript=0;38;2;90;247;142:*.clang-format=0;38;2;165;255;195:*LICENSE-APACHE=0;38;2;153;153;153:*.gitattributes=0;38;2;165;255;195:*CMakeCache.txt=0;38;2;102;102;102:*CMakeLists.txt=0;38;2;165;255;195:*CONTRIBUTORS.md=0;38;2;40;42;54;48;2;243;249;157:*requirements.txt=0;38;2;165;255;195:*CONTRIBUTORS.txt=0;38;2;40;42;54;48;2;243;249;157:*.sconsign.dblite=0;38;2;102;102;102:*package-lock.json=0;38;2;102;102;102:*.CFUserTextEncoding=0;38;2;102;102;102"
