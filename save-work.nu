#!/usr/bin/env nu

def main [dev_folder: string = "~/dev"] {

	ls $dev_folder | each { |$repo|
		echo $"checking ($repo.name)"
		cd $repo.name

		if ($"($repo.name)/.git" | path exists) {
			run-git
		} else {
			echo $"($repo.name) isnt a git repo"
		}
	}
}

def run-git [] {
	git fetch

	let git_status = (git status)

	if ($git_status | str contains "Changes not staged for commit") {
		echo $"($env.PWD) - changes not staged for commit"
		git pull; git add -A; git commit -m "saving work"; git push
	} else if ($git_status | str contains "Untracked files") {
		echo $"($env.PWD) - untracked files"
		git pull; git add -A; git commit -m "saving work"; git push
	} else if ($git_status | str contains "Your branch is up to date") {
		echo $"($env.PWD) - your branch is up to date"
	} else if ($git_status | str contains "Your branch is behind") {
		echo $"($env.PWD) - your branch is behind"
		git pull
	} else {
		git pull; git add -A; git commit -m "saving work"; git push
	}
}
