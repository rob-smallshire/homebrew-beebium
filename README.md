# Beebium Homebrew Tap

Homebrew packages for [**Beebium**](https://github.com/rob-smallshire/beebium),
a BBC Micro emulator with a multi-process architecture: a headless emulation core
exposed over gRPC, driven by separate clients (Python, TypeScript, a macOS app).

This tap distributes the **macOS server** — the headless emulator itself. It is
designed to be used as a tool for running and testing BBC Micro software locally
and in CI, driven from the Python or TypeScript client.

| Package          | Type    | What it is                                                         |
|------------------|---------|--------------------------------------------------------------------|
| `beebium-server` | formula | The four headless emulator servers (Model B, B+, B+ 128K, ROM/RAM) |
| `beebium-gui`    | cask    | The macOS GUI front end *(planned, not yet available)*             |

> **Status: pre-release.** No tagged release has been cut yet, so install with
> `--HEAD` (builds from `master`) as shown below. Once `v0.1.0` is tagged, plain
> `brew install beebium-server` will work and pre-built bottles will follow.

## Install

```sh
brew tap rob-smallshire/beebium

# Pre-release (current): build the latest from master
brew install --HEAD beebium-server

# Once released:
# brew install beebium-server
```

The formula builds from source against Homebrew's `grpc`, `protobuf` and
`abseil`. Until bottles are published, installation compiles the servers (about a
minute on Apple Silicon, longer on older hardware).

## What you get

Four server executables on your `PATH`, one per machine variant:

```
beebium-model-b            # BBC Model B
beebium-model-b-plus       # BBC Model B+ (64K)
beebium-model-b-plus-128k  # BBC Model B+ 128K
beebium-model-b-romram     # Model B with ROM/RAM board
```

Each server discovers its bundled ROMs, presets and peripheral extensions
relative to its own install location — no environment setup required. List the
available extensions with:

```sh
beebium-model-b list-extensions
```

## Driving the server

The servers are headless and speak gRPC; you drive them from a client:

- **Python** — `pip install beebium` *(planned: PyPI)*
- **TypeScript** — `npm install beebium` *(planned: npm)*

A typical flow launches a server, mounts a disc, types into the emulated machine,
and reads back screen or memory state — see the
[Beebium repository](https://github.com/rob-smallshire/beebium) for client
documentation and examples.

## Other platforms

This tap is macOS-only. On **Linux**, install the self-contained server bundle
instead — a `.deb` (Debian/Ubuntu/Raspberry Pi OS) or `.tar.gz` (other distros),
for both `amd64` and `arm64`. See the
[Beebium packaging docs](https://github.com/rob-smallshire/beebium/blob/master/docs/packaging.md).

## License

Beebium is free software under the
[GNU General Public License v3.0 or later](https://github.com/rob-smallshire/beebium/blob/master/COPYING.txt).
