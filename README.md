# Arch Linux AUR PKGBUILDs

[![CircleCI](https://circleci.com/gh/Qu4tro/aur.svg?style=svg)](https://circleci.com/gh/qu4tro/aur)

This repo holds the PKGBUILD files from https://aur.archlinux.org/packages/?K=quatro&SeB=m

## Playbook

### Adding a new package

- Create a branch
- Here `git submodule add ssh+git://aur@aur.archlinux.org/<PACKAGENAME>.git`. 
  - Make sure that `ssh+git://` address is used, not `git://`, nor `ssh://`, nor `git+ssh://`
  - Ignore the warning and the fatal error
- Add content, push.
- Repeat command `git submodule add ssh+git://aur@aur.archlinux.org/<PACKAGENAME>.git`.
- git push --set-upstream origin $(git_current_branch) (AKA `ggpush`) and create PR.

> ### Updating (TODO)

> * Somewhere else `git clone ssh+git://aur@aur.archlinux.org/<PACKAGENAME>.git`, add content, push

## Credits
Workflow introduced [here](https://gergely.imreh.net/blog/2018/04/circleci-aur/).
