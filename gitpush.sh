#!/bin/bash
cd /home/xujus/Documents/Spring2024/EEE333/Lab/Lab4
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/github
ssh -T git@github.com
git remote add 333Lab4 git@github.com:JX518/Lab_4_SV_HDL.git
git branch -M main
git add /home/xujus/Documents/Spring2024/EEE333/Lab/Lab4/*
git commit
git push -u configs main
