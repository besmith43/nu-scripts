#!/usr/bin/env nu

def main [] {

	if not ((which cargo).0.path | path exists) {
		echo "cargo is not installed"
		exit 1
	}

	let rustup_default = (rustup show | find "Default host" | parse --regex ':(.*)$' | str trim)

	echo "Installing utilities"

	cargo install du-dust
	cargo install bat
	cargo install starship
	cargo install nu
	cargo install ripgrep
	cargo install tokei
	cargo install broot
	cargo install diskonaut
	cargo install watchexec-cli
	cargo install oha
	cargo install fclones
	cargo install zoxide
	cargo install procs
	cargo install tickrs

	if ($rustup_default.0.Capture1 | into string | str contains "aarch64-pc-windows-msvc") {
		# waiting on ring to get updated
		cargo install pueue --target x86_64-pc-windows-msvc
		cargo install mdcat --target x86_64-pc-windows-msvc
	} else {
		cargo install pueue
		cargo install mdcat
	}

	if not ($rustup_default.0.Capture1 | into string | str contains "windows") {
		cargo install typeracer
		cargo install dijo
		cargo install skim
		cargo install rusty-man
	}

	echo "Installing Cargo Add-ons"

	cargo install cargo-show-asm
	cargo install cargo-audit
	cargo install cargo-depgraph
	cargo install cargo-docgen
	cargo install cargo-generate

	if ($rustup_default.0.Capture1 | into string | str contains "aarch64-pc-windows-msvc") {
		# waiting on ring to get updated
		cargo install cargo-edit --target x86_64-pc-windows-msvc
	} else {
		cargo install cargo-edit
	}

	if ($rustup_default.0.Capture1 | into string | str contains "aarch64-pc-windows-msvc") {
		# waiting on ring to get updated
		cargo install cargo-make --target x86_64-pc-windows-msvc
	} else {
		cargo install cargo-make
	}
}