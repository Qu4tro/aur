#!/bin/sh

subtrees(){
  git log | grep git-subtree-dir | tr -d ' ' | cut -d ":" -f2 | sort | uniq | xargs -I {} bash -c "if [ -d $(git rev-parse --show-toplevel)/{} ] ; then echo {}; fi"
}

sync(){
  git subtree push --prefix="$1" "ssh+git://aur@aur.archlinux.org/$1.git" master
  git subtree pull --prefix="$1" "https://aur@aur.archlinux.org/$1.git" master --squash
}

subtrees | while read -r subtree ; do sync "$subtree" ; done
