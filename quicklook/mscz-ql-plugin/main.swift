import Foundation

@_silgen_name("NSExtensionMain")
func _NSExtensionMain(argc: Int32, argv: UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>)

_NSExtensionMain(argc: Int32(CommandLine.argc), argv: CommandLine.unsafeArgv)