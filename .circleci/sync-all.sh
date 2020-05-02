#!/bin/sh

git log | grep git-subtree-dir | tr -d ' ' | cut -d ":" -f2 | sort | uniq | xargs -I {} bash -c 'if [ -d $(git rev-parse --show-toplevel)/{} ] ; then echo {}; fi' | xargs -L1 -I% git subtree push --prefix=% ssh+git://aur@aur.archlinux.org/%.git master
