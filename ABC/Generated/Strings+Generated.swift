// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Error {
    /// We were not able to find any purchases to restore
    internal static let nothingToRestore = L10n.tr("Localizable", "error.nothingToRestore", fallback: "We were not able to find any purchases to restore")
    /// Unable to make purchase. Please check your connection and try again.
    internal static let productNotFound = L10n.tr("Localizable", "error.productNotFound", fallback: "Unable to make purchase. Please check your connection and try again.")
  }
  internal enum General {
    /// Localizable.strings
    ///   ABC
    /// 
    ///   Created by Игорь Майсюк on 17.08.21.
    internal static let and = L10n.tr("Localizable", "general.and", fallback: "and")
    /// Something wrong
    internal static let error = L10n.tr("Localizable", "general.error", fallback: "Something wrong")
    /// OK
    internal static let ok = L10n.tr("Localizable", "general.ok", fallback: "OK")
    /// Start
    internal static let start = L10n.tr("Localizable", "general.start", fallback: "Start")
  }
  internal enum Menu {
    internal enum Item {
      /// Alphabet
      internal static let alphabet = L10n.tr("Localizable", "menu.item.alphabet", fallback: "Alphabet")
      /// Canvas
      internal static let canvas = L10n.tr("Localizable", "menu.item.canvas", fallback: "Canvas")
      /// Catch a Letter
      internal static let catchLetter = L10n.tr("Localizable", "menu.item.catchLetter", fallback: "Catch a Letter")
      /// Listen
      internal static let listen = L10n.tr("Localizable", "menu.item.listen", fallback: "Listen")
      /// Make a word
      internal static let makeAWord = L10n.tr("Localizable", "menu.item.makeAWord", fallback: "Make a word")
      /// Memorize
      internal static let memorize = L10n.tr("Localizable", "menu.item.memorize", fallback: "Memorize")
      /// Numbers
      internal static let numbers = L10n.tr("Localizable", "menu.item.numbers", fallback: "Numbers")
      /// Pictures
      internal static let pictures = L10n.tr("Localizable", "menu.item.pictures", fallback: "Pictures")
      /// Subscribe
      internal static let subscribe = L10n.tr("Localizable", "menu.item.subscribe", fallback: "Subscribe")
    }
  }
  internal enum Subscription {
    /// Free upcoming updates and features
    internal static let freeUpdates = L10n.tr("Localizable", "subscription.freeUpdates", fallback: "Free upcoming updates and features")
    /// Full access to all available games
    internal static let fullAccess = L10n.tr("Localizable", "subscription.fullAccess", fallback: "Full access to all available games")
    /// More billing options
    internal static let moreBillingOptions = L10n.tr("Localizable", "subscription.moreBillingOptions", fallback: "More billing options")
    /// No annoying ads
    internal static let noAds = L10n.tr("Localizable", "subscription.noAds", fallback: "No annoying ads")
    /// Renews at %@
    internal static func paymentWithoutTrialDescription(_ p1: Any) -> String {
      return L10n.tr("Localizable", "subscription.paymentWithoutTrialDescription", String(describing: p1), fallback: "Renews at %@")
    }
    /// Free trial is available for new subscribers only. Renews after %@ at %@
    internal static func paymentWithTrialDescription(_ p1: Any, _ p2: Any) -> String {
      return L10n.tr("Localizable", "subscription.paymentWithTrialDescription", String(describing: p1), String(describing: p2), fallback: "Free trial is available for new subscribers only. Renews after %@ at %@")
    }
    /// per %@
    internal static func perTerm(_ p1: Any) -> String {
      return L10n.tr("Localizable", "subscription.perTerm", String(describing: p1), fallback: "per %@")
    }
    /// %@/%@
    internal static func priceWithoutTrial(_ p1: Any, _ p2: Any) -> String {
      return L10n.tr("Localizable", "subscription.priceWithoutTrial", String(describing: p1), String(describing: p2), fallback: "%@/%@")
    }
    /// %@ free then %@/%@
    internal static func priceWithTrial(_ p1: Any, _ p2: Any, _ p3: Any) -> String {
      return L10n.tr("Localizable", "subscription.priceWithTrial", String(describing: p1), String(describing: p2), String(describing: p3), fallback: "%@ free then %@/%@")
    }
    /// Privacy Policy
    internal static let privacyPolicy = L10n.tr("Localizable", "subscription.privacyPolicy", fallback: "Privacy Policy")
    /// Restore
    internal static let restore = L10n.tr("Localizable", "subscription.restore", fallback: "Restore")
    /// Terms of Use
    internal static let termsOfUse = L10n.tr("Localizable", "subscription.termsOfUse", fallback: "Terms of Use")
    /// Get unlimited access
    internal static let title = L10n.tr("Localizable", "subscription.title", fallback: "Get unlimited access")
    /// %@ free trial
    internal static func trialTerm(_ p1: Any) -> String {
      return L10n.tr("Localizable", "subscription.trialTerm", String(describing: p1), fallback: "%@ free trial")
    }
    /// Try Free & Subscribe
    internal static let tryFreeAndSubscribe = L10n.tr("Localizable", "subscription.tryFreeAndSubscribe", fallback: "Try Free & Subscribe")
  }
  internal enum Term {
    /// month
    internal static let month = L10n.tr("Localizable", "term.month", fallback: "month")
    /// week
    internal static let week = L10n.tr("Localizable", "term.week", fallback: "week")
    /// year
    internal static let year = L10n.tr("Localizable", "term.year", fallback: "year")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
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
