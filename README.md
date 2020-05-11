# Arch Linux AUR PKGBUILDs

[![CircleCI](https://circleci.com/gh/Qu4tro/aur.svg?style=svg)](https://circleci.com/gh/Qu4tro/aur)

This repo holds the PKGBUILD files from https://aur.archlinux.org/packages/?K=quatro&SeB=m

## Captain log

I've just migrated this repo from submodules to subtrees. I think subtrees are a better fit here, since it includes the project files in here. 
That means PRs can have non-published packages, which was a problem, since the CI had no way to retrieve it from the submodule remote (since it didn't exist).

It would be great for the CI to take care of the publishing whenever a commit was made into master. The main barrier is the SSH key. The public key need to be added to AUR and Github. The private key needs to be in CircleCI. This accomplishes two goals:
  - CircleCI can push into AUR to publish new packages.
  - CircleCI can push into Github to update master with newly created commits in the step above.
I'm not sure if there's a way around this.

Maaaybe there's a way around this. After a subtree split, the commit does exist locally, no remote involved. That's the same commit, that will end up on AUR.
On the case for new packages, I'm thinking a `git subtree add` with the correct prefix and the newly created package directory as the remote.


FYI, the playbook below is still a work in progress, so don't trust it.

## Playbook (TODO)

### Importing a package that already exists in AUR

- [1] Create a branch.
- [2] Run `git subtree add --prefix <pkg-name> ssh+git://aur@aur.archlinux.org/<pkg-name>.git master`. 
- [3] If you do any additional commits, you have to run `git subtree split --prefix <pkg-name> --rejoin`¹ .
- [4] Push and create a new pull request. Resolve any issue the CI raises.
- [5] Merge into master.
- [6] (Hopefully temporary) Push into AUR locally

### Updating a package that already exists here

- [1] Create a branch.
- [2] Update the PKGBUILD and .SRCINFO of the package. Commit changes.
- [3] Push and create a new pull request. Resolve any issue the CI raises.
- [4] Run `git subtree split --prefix <pkg-name> --rejoin`. 
- [5] Push the new subtree commits, wait for CI and merge into master.
- [6] (Hopefully temporary) Push into AUR locally

### Creating a package from scratch

- [1] Create a branch.
- [2] Create a directory with PKGBUILD² and .SRCINFO of the package. Commit changes.
- [3] Push and create a new pull request. Resolve any issue the CI raises.
- [4] Run `git subtree split --prefix <pkg-name> --rejoin`.
- [5] Push the new subtree commits, wait for CI and merge into master.
- [6] (Hopefully temporary) Push into AUR locally

### Updating a package with changes in AUR

This is useful when someone edits a AUR package without editing this repository.

- [1] Run `git subtree pull --prefix <pkg-name> ssh+git://aur@aur.archlinux.org/<pkg-name>.git master`. 
- [2] Create a branch.
- [3] Push and create a new pull request. Resolve any issue the CI raises.
- [4] Merge into master.

¹ This commits in our subtree and updates our branch to the new subtree HEAD.
² You can use `curl https://git.archlinux.org/pacman.git/plain/proto/PKGBUILD.proto > PKGBUILD` as a starting point.


## Credits
Workflow introduced [here](https://gergely.imreh.net/blog/2018/04/circleci-aur/).
