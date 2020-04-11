# Arch Linux AUR PKGBUILDs

[![CircleCI](https://circleci.com/gh/qu4tro/aur.svg?style=svg)](https://circleci.com/gh/qu4tro/aur)

This repo holds the PKGBUILD files from https://aur.archlinux.org/packages/?K=quatro&SeB=m

## Adding a new package (reminder)

* Somewhere else `git clone ssh+git://aur@aur.archlinux.org/<PACKAGENAME>.git`, add content, push
* Here `git submodule add ssh+git://aur@aur.archlinux.org/<PACKAGENAME>.git`
* Make sure that `ssh+git://` address is used, not `git://`, nor `ssh://`, nor `git+ssh://`
