project(
    'grpc-demo',
    'cpp',
    version: '0.1',
    default_options: ['warning_level=3', 'cpp_std=c++17'],
)

re2 = subproject('re2')
abseil_proj = subproject('abseil')
absl_dep = dependency('absl_base', required: true)
protobuf = subproject('protobuf')
protobuf_dep = dependency('protobuf', required: true)

cares = subproject('c-ares')

openssl = subproject('openssl')
libcrypto_dep = dependency('libcrypto')
libssl_dep = dependency('libssl')

grpc = subproject('grpc')
grpc_dep = dependency('grpc', main: true, required: true)
grpcpp_dep = dependency('grpc++', main: true, required: true)

protobuf_proj = subproject('protobuf')
protoc = protobuf_proj.get_variable('protoc')

grpc_cpp_plugin = grpc.get_variable('grpc_cpp_plugin')
grpc_cpp_plugin_path = grpc_cpp_plugin.full_path()

proto_gen = generator(
    protoc,
    output: ['@BASENAME@.pb.cc', '@BASENAME@.pb.h'],
    arguments: [
        '--proto_path=@CURRENT_SOURCE_DIR@',
        '--cpp_out=@BUILD_DIR@',
        '@INPUT@',
    ],
)

proto_grpc_gen = generator(
    protoc,
    output: ['@BASENAME@.grpc.pb.cc', '@BASENAME@.grpc.pb.h'],
    arguments: [
        f'--plugin=protoc-gen-grpc=@grpc_cpp_plugin_path@',
        '--proto_path=@CURRENT_SOURCE_DIR@',
        '--grpc_out=@BUILD_DIR@',
        '@INPUT@',
    ],
)

proto_generated = proto_gen.process('helloworld.proto')
proto_grpc_generated = proto_grpc_gen.process('helloworld.proto')

project_source_files = [
    'main.cpp',
]

app_deps = [
    grpc_dep,
    grpcpp_dep,
    absl_dep,
    protobuf_dep,
    libssl_dep,
    libcrypto_dep,
]

executable(
    'grpc-demo',
    'main.cpp',
    proto_generated,
    proto_grpc_generated,
    project_source_files,
    install: true,
    dependencies: app_deps,
)