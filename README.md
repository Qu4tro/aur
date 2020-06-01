# Arch Linux AUR PKGBUILDs

[![CircleCI](https://circleci.com/gh/Qu4tro/aur.svg?style=svg)](https://circleci.com/gh/Qu4tro/aur)

This repo holds the PKGBUILD files from https://aur.archlinux.org/packages/?K=quatro&SeB=m

## Captain log

  - Uses subtrees to keep track of the remote AUR repositories.
      - That means PRs can have non-published packages, which was a problem with submodules, since the CI had no way to retrieve it from the submodule remote (since it didn't exist).
      - That also means, this repository history gets cluttered really fast.

  - It should be possible for the CI to handle publishing on it's own [TODO]
      - In theory, whenever master has a new commit, the CI just needs to run `git subtree push` on all packages.
      - The CI would also need an SSH key that is connected to a AUR account (AUR allows multiple ssh keys, by separating each with a newline).
  - The parts of the playbook marked with TODO are a WIP. Don't trust them too much, although it _should_ be fine.
  - `sync.sh` is my WIP script to handle this workflow. It's not ready for any use.


## Playbook

### Importing a package that already exists in AUR (TODO)

- Create a branch.
- Run `git subtree add --prefix <pkgname> ssh+git://aur@aur.archlinux.org/<pkgname>.git master`. 
- Add package entry to CircleCI
- Push and create a new pull request. Resolve any issue the CI raises.
- If you do any additional commits, you have to run `git subtree split --prefix <pkgname> --rejoin`¹.
- Push the new subtree commits, wait for CI and merge into master.
- (Hopefully temporary) Push into AUR locally².

### Updating a package that already exists here

- Create a branch.
- Update the ``PKGBUILD`` and `.SRCINFO` of the package. Commit changes.
- Push and create a new pull request. Resolve any issue the CI raises.
- Run `git subtree split --prefix <pkgname> --rejoin`. 
- Push the new subtree commits, wait for CI and merge into master.
- (Hopefully temporary) Push into AUR locally.

### Creating a package from scratch

- Create a branch.
- Create a directory with the same name as the pkgname. Add the ``PKGBUILD``³ and `.SRCINFO` of the package and commit the changes.
- Add package entry to CircleCI
- Push and create a new pull request. Resolve any issue the CI raises.
- Run `git subtree split --prefix <pkgname> --rejoin`.
- Push the new subtree commits, wait for CI and merge into master.
- (Hopefully temporary) Push into AUR locally.

### Updating a package with changes from AUR (TODO)

This is useful when someone edits a AUR package without editing this repository.

- Run `git subtree pull --prefix <pkgname> ssh+git://aur@aur.archlinux.org/<pkgname>.git master`. 
- Create a branch.
- Push and create a new pull request. Resolve any issue the CI raises.
- If you do any additional commits, you have to run `git subtree split --prefix <pkgname> --rejoin`.
- Push the new subtree commits, wait for CI and merge into master.

#### Notes
¹ This creates a commit for the subtree HEAD. It also updates ours to reflect the new commit.

² Run `git subtree push --prefix="$1" "ssh+git://aur@aur.archlinux.org/$1.git" master` while on the master branch.

³ You can use `curl https://git.archlinux.org/pacman.git/plain/proto/PKGBUILD.proto > PKGBUILD` as a starting point.


## Credits
Workflow introduced [here](https://gergely.imreh.net/blog/2018/04/circleci-aur/).
