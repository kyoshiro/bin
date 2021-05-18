#!/bin/bash

# Migrate local repo from master to main and update reference to origin
git branch -m master main
git fetch origin
git branch -u origin/main main
git remote set-head origin -a
