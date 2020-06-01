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


FYI, the playbook below is still a work in progress, so don't trust it.

## Playbook

### Importing a package that already exists in AUR (TODO)

- Create a branch.
- Run `git subtree add --prefix <pkgname> ssh+git://aur@aur.archlinux.org/<pkgname>.git master`. 
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

### Creating a package from scratch (TODO)

- Create a branch.
- Create a directory with the same name as the pkgname. Add the ``PKGBUILD``³ and `.SRCINFO` of the package and commit the changes.
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
