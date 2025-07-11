// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "AMSMB2",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13)],
    products: [
        .library(
            name: "AMSMB2",
            type: .dynamic,
            targets: ["AMSMB2"]),
    ],
    targets: [
        .target(
            name: "libsmb2",
            path: "Dependencies/libsmb2",
            exclude: [
                "lib/CMakeLists.txt",
                "lib/libsmb2.syms",
                "lib/Makefile.am",
                "lib/Makefile.DC_KOS",
                "lib/Makefile.PS2_EE",
                "lib/Makefile.PS2_IOP",
                "lib/Makefile.PS3_PPU",
                "lib/Makefile.PS4",
                "include/esp",
                "include/xbox", 
                "include/ps3",
                "include/ps2",
                "include/amiga_os",
                "include/picow",
                "include/apple",  // This should exclude the apple config
            ],
            sources: [
                "lib",
            ],
            publicHeadersPath: ".",
            cSettings: [
                // PUT YOUR CUSTOM CONFIG FIRST so it gets found before any other config.h
                .headerSearchPath("../../Sources/libsmb2-config"),
                .headerSearchPath("include"),
                .headerSearchPath("include/smb2"), 
                .headerSearchPath("lib"),
                .define("_U_", to: "__attribute__((unused))"),
                .define("HAVE_CONFIG_H", to: "1"),
                .define("HAVE_LIBKRB5", to: "1"),
                .define("HAVE_GSSAPI_GSSAPI_H", to: "1"),
                .define("__APPLE__", to: "1"),
            ],
            linkerSettings: [
                .linkedFramework("GSS"),
            ]
        ),
        .target(
            name: "AMSMB2",
            dependencies: ["libsmb2"],
            path: "AMSMB2",
            exclude: ["Info.plist"]),
        .testTarget(
            name: "AMSMB2Tests",
            dependencies: ["AMSMB2"],
            path: "AMSMB2Tests",
            exclude: ["Info.plist"]),
    ],
    swiftLanguageVersions: [.v5]
)
