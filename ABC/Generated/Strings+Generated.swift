// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum Error {
    /// We were not able to find any purchases to restore
    internal static let nothingToRestore = L10n.tr("Localizable", "error.nothingToRestore")
  }

  internal enum General {
    /// and
    internal static let and = L10n.tr("Localizable", "general.and")
    /// Something wrong
    internal static let error = L10n.tr("Localizable", "general.error")
    /// OK
    internal static let ok = L10n.tr("Localizable", "general.ok")
  }

  internal enum Menu {
    internal enum Item {
      /// Alphabet
      internal static let alphabet = L10n.tr("Localizable", "menu.item.alphabet")
      /// Canvas
      internal static let canvas = L10n.tr("Localizable", "menu.item.canvas")
      /// Games
      internal static let games = L10n.tr("Localizable", "menu.item.games")
      /// Listen
      internal static let listen = L10n.tr("Localizable", "menu.item.listen")
      /// Make a word
      internal static let makeAWord = L10n.tr("Localizable", "menu.item.makeAWord")
      /// Memorize
      internal static let memorize = L10n.tr("Localizable", "menu.item.memorize")
      /// Numbers
      internal static let numbers = L10n.tr("Localizable", "menu.item.numbers")
      /// Subscribe
      internal static let subscribe = L10n.tr("Localizable", "menu.item.subscribe")
    }
  }

  internal enum Subscription {
    /// Free upcoming updates and features
    internal static let freeUpdates = L10n.tr("Localizable", "subscription.freeUpdates")
    /// Full access to all available games
    internal static let fullAccess = L10n.tr("Localizable", "subscription.fullAccess")
    /// More billing options
    internal static let moreBillingOptions = L10n.tr("Localizable", "subscription.moreBillingOptions")
    /// No annoying ads
    internal static let noAds = L10n.tr("Localizable", "subscription.noAds")
    /// %@/%@
    internal static func priceWithoutTrial(_ p1: Any, _ p2: Any) -> String {
      return L10n.tr("Localizable", "subscription.priceWithoutTrial", String(describing: p1), String(describing: p2))
    }
    /// %@ free then %@/%@
    internal static func priceWithTrial(_ p1: Any, _ p2: Any, _ p3: Any) -> String {
      return L10n.tr("Localizable", "subscription.priceWithTrial", String(describing: p1), String(describing: p2), String(describing: p3))
    }
    /// Privacy Policy
    internal static let privacyPolicy = L10n.tr("Localizable", "subscription.privacyPolicy")
    /// Restore
    internal static let restore = L10n.tr("Localizable", "subscription.restore")
    /// Terms of Use
    internal static let termsOfUse = L10n.tr("Localizable", "subscription.termsOfUse")
    /// Get unlimited access
    internal static let title = L10n.tr("Localizable", "subscription.title")
    /// Try Free & Subscribe
    internal static let tryFreeAndSubscribe = L10n.tr("Localizable", "subscription.tryFreeAndSubscribe")
  }

  internal enum Term {
    /// month
    internal static let month = L10n.tr("Localizable", "term.month")
    /// week
    internal static let week = L10n.tr("Localizable", "term.week")
    /// year
    internal static let year = L10n.tr("Localizable", "term.year")
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
