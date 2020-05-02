#!/bin/sh

subtrees(){
  git log | grep git-subtree-dir | tr -d ' ' | cut -d ":" -f2 | sort | uniq | xargs -I {} bash -c 'if [ -d $(git rev-parse --show-toplevel)/{} ] ; then echo {}; fi'
}

subtrees | xargs -L1 -I% git subtree push --prefix=% ssh+git://aur@aur.archlinux.org/%.git master
subtrees | xargs -L1 -I% git subtree pull --prefix=% https://aur@aur.archlinux.org/%.git master --squash
