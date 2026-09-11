# zstd 1.5.7 musl release

Source-built Linux x86_64 musl shared libraries and development prefix.

Upstream: https://github.com/facebook/zstd, tag v1.5.7.

CI checks project tests, ELF GLIBC symbol requirements and the relocated release in a clean offline musl container. External shared libraries remain separate and are listed in build-manifest.json. This is not a fully static binary or a GPU hardware certification.

Tag musl-v1.5.7-N publishes only after all checks pass. Published tags and assets are never overwritten.

The upstream four CTest targets run, with the fuzzer using the upstream short-CI duration of two minutes and a fixed seed (`-T2m -s1`). The unconstrained default 30,000-case fuzz loop can exceed the shared runner test timeout.
