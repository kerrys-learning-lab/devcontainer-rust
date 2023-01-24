#! /bin/bash

if [ -f Cargo.toml ]; then
  cargo fetch
fi