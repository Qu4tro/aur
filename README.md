# Arch Linux AUR PKGBUILDs

[![CircleCI](https://circleci.com/gh/Qu4tro/aur.svg?style=svg)](https://circleci.com/gh/qu4tro/aur)

This repo holds the PKGBUILD files from https://aur.archlinux.org/packages/?K=quatro&SeB=m

## Playbook

### Adding a new package

- Create a branch
- Inside this repo: `git submodule add ssh+git://aur@aur.archlinux.org/<PACKAGENAME>.git`. 
  - Make sure that `ssh+git://` address is used, not `git://`, nor `ssh://`, nor `git+ssh://`
  - Ignore the warning and the fatal error
- Inside the sobmodule add the content and `git add . && git commit && git push`.
- Repeat command inside this repo: `git submodule add ssh+git://aur@aur.archlinux.org/<PACKAGENAME>.git`.
- Again on this repo: `git push --set-upstream origin $(git_current_branch)` (AKA `ggpush`) and create PR.

### Updating (TODO)

* Update whatever is needed inside the submodule.
* Commit on the submodule git repository.
* Create a branch on this repo and `git add` the updated submodule .
* `ggpush` and create PR
* If it works, merge the PR and push into AUR as well.

## Credits
Workflow introduced [here](https://gergely.imreh.net/blog/2018/04/circleci-aur/).
