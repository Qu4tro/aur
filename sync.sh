#!/usr/bin/env bash

usage(){
  cat << EOF
Usage: 
  ./sync.sh all             - Synchronizes all subtrees
  ./sync.sh <subtree>       - Synchronizes a single subtree
  ./sync.sh                 - This screen
  ./sync.sh <anything-else> - This screen

Available subtrees:
$(subtrees | sed 's/^/  /' )
EOF
}

subtrees(){
  git log \
    | grep git-subtree-dir \
    | tr -d ' ' \
    | cut -d ":" -f2 \
    | sort \
    | uniq \
    | xargs -I {} bash -c "if [ -d $(git rev-parse --show-toplevel)/{} ] ; then echo {}; fi"
}

sync(){
  [ -z "$1" ] && return 1

  # The code for the push below could usually be replaced with:
  #     git subtree push --prefix="$1"
  #       "ssh+git://aur@aur.archlinux.org/$1.git" master
  # but we want to push from a different branch to master
  # in lieu, of what the above does: master to master.
  remote="ssh+git://aur@aur.archlinux.org/$1.git"
  current_branch="$(git symbolic-ref --short -q HEAD)"
  split_commit="$(git subtree split --prefix="$1" "${current_branch}")"
  git push "${remote}" "${split_commit}:master" --force


  git subtree pull --prefix="$1" "${remote}" master --squash
}

new(){
  [ -z "$1" ] && return 1
  remote="ssh+git://aur@aur.archlinux.org/$1.git"

  git remote add "$1" "$remote"
  current_branch="$(git symbolic-ref --short -q HEAD)"
  split_commit="$(git subtree split --prefix="$1" "${current_branch}")"
  git push "$remote" "$(git_current_branch):master"
}

main(){
  if [ -z "$1" ]; then
    usage
  elif [ "$1" = "all" ]; then
    subtrees | while read -r subtree ; do sync "${subtree}" ; done
  elif [[ "$(subtrees)" =~ $1 ]]; then
    sync "$1"
  else
    usage
  fi
}

main "$@"
