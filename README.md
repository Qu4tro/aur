# Arch Linux AUR PKGBUILDs

[![CircleCI](https://circleci.com/gh/Qu4tro/aur.svg?style=svg)](https://circleci.com/gh/qu4tro/aur)

This repo holds the PKGBUILD files from https://aur.archlinux.org/packages/?K=quatro&SeB=m

## Captain log

I've just migrated this repo from submodules to subtrees. I think subtrees are a better fit here, since it includes the project files in here. 
That means PRs can have non-published packages, which was a problem, since the CI had no way to retrieve it from the submodule remote (since it didn't exist)

It would be great for the CI to take care of the publishing whenever a commit was made into master. The main barrier is the SSH key. The public key need to be added to AUR and Github. The private key needs to be in CircleCI. This accomplishes two goals:
  - CircleCI can push into AUR to publish new packages.
  - CircleCI can push into Github to update master with newly created commits in the step above.
I'm not sure if there's a way around this.

## Playbook

### Updating a package

- [1] Create a branch.
- [2] Update the PKGBUILD and .SRCINFO of the package. Commit changes.
- [3] Push and create a new pull request.
- [4] If CI gives you the okay, Run `./sync-all.sh` and push the new commits.
- [5] Merge into master.

### Adding a package (TODO)

- [1] Create a branch
- [2] Add a directory with PKGBUILD (*) and .SRCINFO of the package. Commit changes.
- [3] Push and create a new pull request.
- [4] If CI gives you the okay, Run `?????` and push the new commits.
- [5] Merge into master.

* You can use `curl https://git.archlinux.org/pacman.git/plain/proto/PKGBUILD.proto > PKGBUILD` as a starting point.

## Credits
Workflow introduced [here](https://gergely.imreh.net/blog/2018/04/circleci-aur/).
