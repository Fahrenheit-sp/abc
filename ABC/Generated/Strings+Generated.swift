// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum Canvas {
    /// Clear all
    internal static let clearAll = L10n.tr("Localizable", "canvas.clearAll")
  }

  internal enum Menu {
    internal enum Item {
      /// Alphabet
      internal static let alphabet = L10n.tr("Localizable", "menu.item.alphabet")
      /// Canvas
      internal static let canvas = L10n.tr("Localizable", "menu.item.canvas")
      /// Catch a letter
      internal static let catchALetter = L10n.tr("Localizable", "menu.item.catchALetter")
      /// Games
      internal static let games = L10n.tr("Localizable", "menu.item.games")
      /// Make a word
      internal static let makeAWord = L10n.tr("Localizable", "menu.item.makeAWord")
      /// Memorize
      internal static let memorize = L10n.tr("Localizable", "menu.item.memorize")
      /// Numbers
      internal static let numbers = L10n.tr("Localizable", "menu.item.numbers")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
