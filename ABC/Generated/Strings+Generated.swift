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
    /// Avatars
    internal static let avatars = L10n.tr("Localizable", "general.avatars", fallback: "Avatars")
    /// Continue
    internal static let `continue` = L10n.tr("Localizable", "general.continue", fallback: "Continue")
    /// Something wrong
    internal static let error = L10n.tr("Localizable", "general.error", fallback: "Something wrong")
    /// Name
    internal static let name = L10n.tr("Localizable", "general.name", fallback: "Name")
    /// Next
    internal static let next = L10n.tr("Localizable", "general.next", fallback: "Next")
    /// OK
    internal static let ok = L10n.tr("Localizable", "general.ok", fallback: "OK")
    /// Play
    internal static let play = L10n.tr("Localizable", "general.play", fallback: "Play")
    /// Profile
    internal static let profile = L10n.tr("Localizable", "general.profile", fallback: "Profile")
    /// Settings
    internal static let settings = L10n.tr("Localizable", "general.settings", fallback: "Settings")
    /// Start
    internal static let start = L10n.tr("Localizable", "general.start", fallback: "Start")
  }
  internal enum Home {
    /// Welcome back, %@!
    internal static func welcome(_ p1: Any) -> String {
      return L10n.tr("Localizable", "home.welcome", String(describing: p1), fallback: "Welcome back, %@!")
    }
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
  internal enum Onboarding {
    internal enum First {
      /// Ready to play? Let's explore letters, numbers, and unlock your amazing knowledge superpowers!
      internal static let subtitle = L10n.tr("Localizable", "onboarding.first.subtitle", fallback: "Ready to play? Let's explore letters, numbers, and unlock your amazing knowledge superpowers!")
      /// Let's go on a
      /// fun adventure!
      internal static let title = L10n.tr("Localizable", "onboarding.first.title", fallback: "Let's go on a\nfun adventure!")
    }
    internal enum Name {
      /// What is your name?
      internal static let title = L10n.tr("Localizable", "onboarding.name.title", fallback: "What is your name?")
    }
    internal enum Second {
      /// Collect colorful stickers, unlock unique and funny avatars, and enjoy exciting daily prizes and surprises!
      internal static let subtitle = L10n.tr("Localizable", "onboarding.second.subtitle", fallback: "Collect colorful stickers, unlock unique and funny avatars, and enjoy exciting daily prizes and surprises!")
      /// Awesome Rewards Await you!
      internal static let title = L10n.tr("Localizable", "onboarding.second.title", fallback: "Awesome Rewards Await you!")
    }
    internal enum Third {
      /// Catch letters in games, memorize bright pictures with ease, build words and enjoy new discoveries every single day!
      internal static let subtitle = L10n.tr("Localizable", "onboarding.third.subtitle", fallback: "Catch letters in games, memorize bright pictures with ease, build words and enjoy new discoveries every single day!")
      /// What shall we play first?
      internal static let title = L10n.tr("Localizable", "onboarding.third.title", fallback: "What shall we play first?")
    }
  }
  internal enum Profile {
    /// Achievements
    internal static let achievements = L10n.tr("Localizable", "profile.achievements", fallback: "Achievements")
    /// Avatars
    internal static let avatars = L10n.tr("Localizable", "profile.avatars", fallback: "Avatars")
    /// Change your avatar's style!
    internal static let getAvatarsSubtitle = L10n.tr("Localizable", "profile.getAvatarsSubtitle", fallback: "Change your avatar's style!")
    /// Get new avatars!
    internal static let getAvatarsTitle = L10n.tr("Localizable", "profile.getAvatarsTitle", fallback: "Get new avatars!")
    /// See all
    internal static let seeAll = L10n.tr("Localizable", "profile.seeAll", fallback: "See all")
  }
  internal enum Settings {
    /// Music
    internal static let music = L10n.tr("Localizable", "settings.music", fallback: "Music")
    /// Sound
    internal static let sound = L10n.tr("Localizable", "settings.sound", fallback: "Sound")
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
    /// Unlimited access to all games
    internal static let subtitle = L10n.tr("Localizable", "subscription.subtitle", fallback: "Unlimited access to all games")
    /// Terms of Use
    internal static let termsOfUse = L10n.tr("Localizable", "subscription.termsOfUse", fallback: "Terms of Use")
    /// Get subscription!
    internal static let title = L10n.tr("Localizable", "subscription.title", fallback: "Get subscription!")
    /// %@ free trial
    internal static func trialTerm(_ p1: Any) -> String {
      return L10n.tr("Localizable", "subscription.trialTerm", String(describing: p1), fallback: "%@ free trial")
    }
    /// Try Free & Subscribe
    internal static let tryFreeAndSubscribe = L10n.tr("Localizable", "subscription.tryFreeAndSubscribe", fallback: "Try Free & Subscribe")
    internal enum DefaultScreen {
      /// Back
      internal static let back = L10n.tr("Localizable", "subscription.defaultScreen.back", fallback: "Back")
      /// Best Value
      internal static let bestValue = L10n.tr("Localizable", "subscription.defaultScreen.bestValue", fallback: "Best Value")
      /// Double tap to toggle free trial
      internal static let freeTrialAccessibilityHint = L10n.tr("Localizable", "subscription.defaultScreen.freeTrialAccessibilityHint", fallback: "Double tap to toggle free trial")
      /// Free Trial Disabled
      internal static let freeTrialDisabled = L10n.tr("Localizable", "subscription.defaultScreen.freeTrialDisabled", fallback: "Free Trial Disabled")
      /// Free Trial Enabled
      internal static let freeTrialEnabled = L10n.tr("Localizable", "subscription.defaultScreen.freeTrialEnabled", fallback: "Free Trial Enabled")
      /// Monthly
      internal static let monthly = L10n.tr("Localizable", "subscription.defaultScreen.monthly", fallback: "Monthly")
      /// Monthly plan
      internal static let monthlyAccessibilityLabel = L10n.tr("Localizable", "subscription.defaultScreen.monthlyAccessibilityLabel", fallback: "Monthly plan")
      /// $7,99
      internal static let monthlyPrice = L10n.tr("Localizable", "subscription.defaultScreen.monthlyPrice", fallback: "$7,99")
      /// No charges yet. Cancel anytime.
      internal static let noChargesYet = L10n.tr("Localizable", "subscription.defaultScreen.noChargesYet", fallback: "No charges yet. Cancel anytime.")
      /// Not selected
      internal static let notSelected = L10n.tr("Localizable", "subscription.defaultScreen.notSelected", fallback: "Not selected")
      /// /month
      internal static let perMonth = L10n.tr("Localizable", "subscription.defaultScreen.perMonth", fallback: "/month")
      /// /year
      internal static let perYear = L10n.tr("Localizable", "subscription.defaultScreen.perYear", fallback: "/year")
      /// Restore Purchase
      internal static let restorePurchase = L10n.tr("Localizable", "subscription.defaultScreen.restorePurchase", fallback: "Restore Purchase")
      /// Selected
      internal static let selected = L10n.tr("Localizable", "subscription.defaultScreen.selected", fallback: "Selected")
      /// Double tap to select monthly billing
      internal static let selectMonthlyAccessibilityHint = L10n.tr("Localizable", "subscription.defaultScreen.selectMonthlyAccessibilityHint", fallback: "Double tap to select monthly billing")
      /// Double tap to select yearly billing
      internal static let selectYearlyAccessibilityHint = L10n.tr("Localizable", "subscription.defaultScreen.selectYearlyAccessibilityHint", fallback: "Double tap to select yearly billing")
      /// Try 3 Days FREE & Subscribe
      internal static let subscribeCta = L10n.tr("Localizable", "subscription.defaultScreen.subscribeCta", fallback: "Try 3 Days FREE & Subscribe")
      /// All Games · Zero Ads · New Content
      internal static let subtitle = L10n.tr("Localizable", "subscription.defaultScreen.subtitle", fallback: "All Games · Zero Ads · New Content")
      /// Unlock Everything & Learn Ad-Free!
      internal static let title = L10n.tr("Localizable", "subscription.defaultScreen.title", fallback: "Unlock Everything & Learn Ad-Free!")
      /// Yearly
      internal static let yearly = L10n.tr("Localizable", "subscription.defaultScreen.yearly", fallback: "Yearly")
      /// Yearly plan
      internal static let yearlyAccessibilityLabel = L10n.tr("Localizable", "subscription.defaultScreen.yearlyAccessibilityLabel", fallback: "Yearly plan")
      /// $49,99
      internal static let yearlyPrice = L10n.tr("Localizable", "subscription.defaultScreen.yearlyPrice", fallback: "$49,99")
    }
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
