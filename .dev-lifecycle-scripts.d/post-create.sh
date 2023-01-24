#! /bin/bash

mkdir -p ~vscode/.cargo

cat << EOF > ~vscode/.cargo/config
[registries]
kerrys-learning-lab-carbernetes = { index = "https://dl.cloudsmith.io/public/kerrys-learning-lab/carbernetes/cargo/index.git" }
EOF
