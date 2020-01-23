#!/bin/sh

if [ "`git status -s`" ]
then
	echo "commit pending changes"
	exit 1;
fi

echo "Deleting old public"
rm -rf public
mkdir public
git worktree prune
rm -rf .git/worktrees/public/

echo "checking out gh-pages into public"
git worktree add -B gh-pages public origin/gh-pages

echo "Removing existing files"
rm -rf public/*

echo "generate site"
hugo

echo "Updating gh-pages branch"
cd public
git add --all
git commit -m "publishing to gh-pages"

echo "pushing to github"
git push -all
