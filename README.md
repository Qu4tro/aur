# Arch Linux AUR PKGBUILDs

[![CircleCI](https://circleci.com/gh/Qu4tro/aur.svg?style=svg)](https://circleci.com/gh/qu4tro/aur)

This repo holds the PKGBUILD files from https://aur.archlinux.org/packages/?K=quatro&SeB=m

## Concept / Goals / Setup

I've just migrated this repo from submodules to subtrees. I think subtrees are a better fit here, since it includes the project files in here. 
That means PRs can have non-published packages, which was a problem, since the CI had no way to retrieve it.

Current goals:
  - Adding a new package should be simple:
    - Create directory with the package name
    - Add PKGINFO & SRCINFO
    - PR and wait for CI to give you the green
    - Merge. CI should take of publishing.
  - Any runs on master on CI should check if the packages are up-to-date with AUR

## Playbook

### Adding / Updating a package

- [1] Create a branch
- [2] Run: `make new PKG=<pkg-name>` . If you're updating a package already in this repository, skip this step.
- [3] Update PKGBUILD and .SRCINFO on the submodule. Commit changes.
- [4] Add submodule changes and commit the changes on this repository. Push to create a pull request.
- [5] If CI gives you the okay, merge the changes.
- [6] Push submodule repository into AUR. (`cd pkg && git push`)

## Credits
Workflow introduced [here](https://gergely.imreh.net/blog/2018/04/circleci-aur/).
