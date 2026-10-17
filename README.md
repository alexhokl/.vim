.vim
====

My vim dot files.

## Shortcuts

- `Ctrl-P`: Find files
- `Ctrl-T`: Live grep
- `Ctrl-R`: Refresh the file sidebar
- `Ctrl-D`: Multiple cursor support
- `Ctrl-X`: Switch to the next buffer
- `Ctrl-Z`: Switch to the previous buffer

There's a lot more if you hit `,` you can peruse all the ones connected to the leader `,`

## Temporary workarounds

### `kotlin-lsp` Mason package override

The upstream [mason-registry](https://github.com/mason-org/mason-registry)
package for `kotlin-lsp` downloads from `download-cdn.jetbrains.com`, which
now returns 404 unless the URL is signed, so `:MasonInstall kotlin-lsp` fails.
Mason may report this as `Could not find executable "wget"`, but that is only
the last fallback error.

Until [mason-org/mason-registry#17323](https://github.com/mason-org/mason-registry/pull/17323)
is merged, a local registry at `mason-registry/` overrides the package with
URLs on `download.jetbrains.com`. It is listed first in the mason `registries`
in `lua/plugin/lsp.lua`, and needs `yq` (installed by `flake.nix` as `yq-go`).

To remove it once the upstream fix is released:

1. Delete the `mason-registry/` directory.
2. Remove the `file:` registry entry from `lua/plugin/lsp.lua`.
3. Optionally remove `yq-go` from `flake.nix`.
4. Run `:MasonUpdate` and `:MasonInstall kotlin-lsp` to confirm it installs.
