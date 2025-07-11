erSearchPath("lib"),
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
																												    )~
																												    