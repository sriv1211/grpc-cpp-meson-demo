#!/usr/bin/env bash

set -euxo pipefail

apt-get update
apt-get install -y python3-pip python3-venv pkg-config git wget clang-18 clang++-18

python3 -m venv /app/.venv
. /app/.venv/bin/activate
pip3 install meson ninja

CC=clang-18 CXX=clang++-18 meson setup build-clang -Dcpp_std=c++17

pushd build-clang 

# Build fails first time due to abseil/protobuf dependency
ninja || true
echo "The build has likely failed (known issue), rebuilding"

popd
CC=clang-18 CXX=clang++-18 meson setup --reconfigure build-clang -Dcpp_std=c++17

# Run a few more times due to depency issues with protobuf/grpc/protoc-cpp
pushd build-clang
echo "Running the build a few times due to depency chaining..."

for i in {0..2}; do
  echo "Iteration: $i"
  ninja || true
done

# The file should now exist
if [[ -f grpc-demo ]]; then
  echo "grpc-demo file exists"
else
  echo "grpc-demo file doesn't exist"
  exit 1
fi
