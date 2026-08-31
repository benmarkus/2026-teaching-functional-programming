# Functional Programming - Course Repository

This repository holds the material for the course: skeleton files you will
work from during each lesson, and completed reference files that get added
once a lesson is over. This README explains how to use git to get that
material onto your own computer and keep it up to date, even if you have
never used git before.

## What is in here

Each lesson shows up as a Haskell file named `LessonNN_skeleton.hs`, for
example `Lesson03_skeleton.hs`. That is what you start from during the
lesson.

After the lesson, a file named `LessonNN_finished.hs` gets added, for
example `Lesson03_finished.hs`, showing one way of solving it.

New material gets added to this repository throughout the semester, so you
will need to pull those updates regularly rather than cloning it once and
forgetting about it.

## Leave the skeleton files alone

Do not edit the `_skeleton` files themselves. Instead, make a copy without
the `_skeleton` suffix and do your work there, for example copy
`Lesson03_skeleton.hs` to `Lesson03.hs`. That copy is yours to mess with
however you like, and since git does not track it as a file it already
knows about, `git pull` will never complain about it or touch it.

If the skeleton file has a `module Lesson03_skeleton where` line at the
top, change it to match your new file name, so `module Lesson03 where`.
GHC expects the module name and the file name to line up.

This also means that when I upload `Lesson03_finished.hs` later, it will
sit next to your own `Lesson03.hs` without overwriting anything, so you
can compare the two side by side.

## Installing git

If you do not already have git installed, get it from
https://git-scm.com/downloads and follow the instructions for your
operating system. On Linux it is usually just a package away, for example
`sudo apt install git` on Debian or Ubuntu, or installed by default on modern distros.

Once installed, open a terminal and check it worked:

```
git --version
```

## Getting the repository for the first time

Clone the repository to your machine. You only do this once. Replace the
URL below with the actual URL of this repository (you will find it on the
course page or in the address bar if you are looking at it on GitHub).

```
git clone https://github.com/benmarkus/2026-teaching-functional-programming.git
```

This creates a folder on your computer with a full copy of the repository,
including its history. Move into that folder before running any other git
command:

```
cd 2026-teaching-functional-programming
```

## Getting new material during the semester

Before each lesson, and any time you want the latest files, run:

```
git pull
```

This downloads whatever has changed on the repository since you last
checked and merges it into your local folder. If you have not changed
anything yourself, this will always work cleanly.

## A word of warning about editing files in this repo

If you write your own code directly inside a `_skeleton` file instead of
your own copy, and then run `git pull` later, git may refuse to overwrite
your changes, because it does not want to throw away work you have done.
This is the single most common problem students can run into with this repo,
so stick to the copy habit described above: leave `_skeleton` files
untouched, work in your own unsuffixed copy, and `git pull` will always
run cleanly.

If you do end up editing a `_skeleton` file by accident and `git pull`
complains, commit your changes before pulling:

```
git add .
git commit -m "my work on lesson X"
git pull
```

Git will try to merge your commit with the new material. This usually
works fine, but if it does not, see the conflicts section below.

## If git pull refuses to run

You will typically see a message like `error: Your local changes to the
following files would be overwritten by merge`. This means you have
edited a file that also changed upstream. You have a few ways out:

Save your edits as a commit, then pull (see Option B above):

```
git add .
git commit -m "my work"
git pull
```

Or, if you do not care about your local edits and just want the version
from the repository, throw your changes away:

```
git checkout -- <filename>
git pull
```

Or stash your changes temporarily, pull, then bring them back:

```
git stash
git pull
git stash pop
```

`git stash pop` can also produce a conflict if the same lines changed on
both sides. If that happens, see the next section.

## Resolving a merge conflict

If a conflict happens, git will mark the file at the conflicting spots
like this:

```
<<<<<<< HEAD
your version of the line
=======
the version from the repository
>>>>>>> origin/main
```

Open the file, decide what the code should actually look like, delete the
`<<<<<<<`, `=======`, and `>>>>>>>` markers along with whichever version
you do not want, then save the file and run:

```
git add <filename>
git commit
```

That completes the merge. If this looks intimidating the first time it
happens, that is normal. Ask in class or during office hours and it will
make sense quickly.

## Command cheat sheet

```
git clone <url>        get a copy of the repository (first time only)
git pull                get the latest changes
git status              show what has changed locally
git diff                show the exact changes, line by line
git log                 show the history of commits
git add <file>          stage a file to be committed
git commit -m "msg"     save a snapshot of the staged files
git checkout -- <file>  discard local changes to a file
git stash               temporarily set aside local changes
git stash pop           bring stashed changes back
```

## Basic workflow summary

1. Clone the repository once, at the start of the semester.
2. Before each lesson, run `git pull` inside the repository folder.
3. Do your own coding either in a copy outside the repository, or commit
   your work before pulling again.
4. If a pull fails, commit or stash your changes first, then pull.

If you get stuck, do not panic. Git very rarely loses work outright, it
just sometimes refuses to proceed until you tell it what to do with
conflicting changes. Ask for help if a message does not make sense, and
include the exact text of the error when you do.
