// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "url_shortener",
	targets: [],
	dependencies: [
		.Package(url: "https://github.com/PerfectlySoft/Perfect-SQLite.git", majorVersion: 2, minor: 0),
		.Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", majorVersion: 2, minor: 0),
		.Package(url: "https://github.com/PerfectlySoft/Perfect-Mustache.git", majorVersion: 2, minor: 0),
		.Package(url: "https://github.com/iamjono/SwiftString.git",majorVersion: 1, minor: 0),
		.Package(url: "https://github.com/iamjono/SwiftRandom.git",majorVersion: 0, minor: 2)
	]
)
