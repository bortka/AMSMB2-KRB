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
            ],
            sources: [
                "lib",
            ],
            publicHeadersPath: ".",
            cSettings: [
                .headerSearchPath("include"),
                .headerSearchPath("include/apple"),
                .headerSearchPath("include/smb2"),
                .headerSearchPath("lib"),
                .define("_U_", to: "__attribute__((unused))"),
                .define("HAVE_CONFIG_H", to: "1"),
                .define("HAVE_LIBKRB5", to: "1"),  // Enables Kerberos/GSSAPI in libsmb2
            ],
            linkerSettings: [
                .linkedFramework("GSS"),  // Links to iOS/macOS/tvOS GSS framework for built-in Kerberos
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
