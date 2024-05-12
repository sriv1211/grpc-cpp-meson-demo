# grpc-cpp-meson-demo

An example repo to build a grpc application purely with meson.

See [meson.build](meson.build) for details. 

Note this requires multiple passes of `ninja` due to cross dependencies between libraries (abseil, protobuf and gRPC). PRs welcome to ensure this can be done in a single run of `ninja`.