#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
scripts_dir="$repo_dir/scripts"
install_dir="${HOME:?HOME must be set}/local/bin"

if [[ ! -d "$scripts_dir" ]]; then
    echo "Scripts directory not found: $scripts_dir" >&2
    exit 1
fi

mkdir -p -- "$install_dir"

installed=0
for script in "$scripts_dir"/*; do
    [[ -f "$script" ]] || continue
    install -m 0755 -- "$script" "$install_dir/"
    echo "Installed $(basename -- "$script") to $install_dir"
    ((installed += 1))
done

if ((installed == 0)); then
    echo "No scripts found in $scripts_dir" >&2
    exit 1
fi
