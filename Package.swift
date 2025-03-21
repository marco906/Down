// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Down",
    platforms: [
        .macOS("13.0"),
        .iOS("17.0"),
        .tvOS("17.0")
    ],
    products: [
        .library(
            name: "Down",
            targets: ["Down"]
        )
    ],
    targets: [
        .target(
            name: "libcmark",
            dependencies: [],
            path: "Sources/cmark",
            exclude: [
              "include",
              "case_fold_switch.inc",
              "entities.inc",
              "COPYING"
            ],
            publicHeadersPath: "./"
        ),
        .target(
            name: "Down",
            dependencies: ["libcmark"],
            path: "Sources/Down",
            exclude: ["Down.h"],
          resources: [
            .copy("Resources/DownViewLight.bundle"),
            .copy("Resources/DownViewDark.bundle"),
          ]
        ),
        .testTarget(
            name: "DownTests",
            dependencies: ["Down"],
            path: "Tests/DownTests",
            exclude: [
                "AST/VisitorTests.swift",
                "AST/__Snapshots__",
                "DownViewTests.swift",
                "Fixtures",
                "Styler/__Snapshots__",
                "Styler/BlockQuoteStyleTests.swift",
                "Styler/CodeBlockStyleTests.swift",
                "Styler/DownDebugLayoutManagerTests.swift",
                "Styler/HeadingStyleTests.swift",
                "Styler/LinkStyleTests.swift",
                "Styler/InlineStyleTests.swift",
                "Styler/ListItemStyleTests.swift",
                "Styler/StylerTestSuite.swift",
                "Styler/ThematicBreakSyleTests.swift"
            ]
        )
    ],
    swiftLanguageVersions: [.v5]
)
