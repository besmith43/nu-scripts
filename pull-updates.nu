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

	if ($git_status | str contains "Your branch is up to date") {
		echo $"($env.PWD) - your branch is up to date"
	} else {
		echo $"getting updates for ($env.PWD)"
		git pull
	}
}