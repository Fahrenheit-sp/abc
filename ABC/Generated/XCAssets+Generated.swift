// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal enum Games {
    internal static let cloud = ImageAsset(name: "Cloud")
    internal static let ufo = ImageAsset(name: "Ufo")
    internal static let questionMark = ImageAsset(name: "question_mark")
    internal static let rocket = ImageAsset(name: "rocket")
    internal static let starEmpty = ImageAsset(name: "star_empty")
    internal static let starFilled = ImageAsset(name: "star_filled")
  }
  internal enum Icons {
    internal static let close = ImageAsset(name: "close")
    internal static let `left` = ImageAsset(name: "left")
    internal static let recycleBin = ImageAsset(name: "recycle_bin")
    internal static let `right` = ImageAsset(name: "right")
    internal static let soundOff = ImageAsset(name: "sound-off")
    internal static let soundOn = ImageAsset(name: "sound-on")
  }
  internal enum Listen {
    internal static let playButton = ImageAsset(name: "play_button")
  }
  internal enum Menu {
    internal static let abc = ImageAsset(name: "abc")
    internal static let alphabet = ImageAsset(name: "alphabet")
    internal static let background = ImageAsset(name: "background")
    internal static let canvas = ImageAsset(name: "canvas")
    internal static let catchLetter = ImageAsset(name: "catchLetter")
    internal static let listen = ImageAsset(name: "listen")
    internal static let makeAWord = ImageAsset(name: "make_a_word")
    internal static let memorize = ImageAsset(name: "memorize")
    internal static let new = ImageAsset(name: "new")
    internal static let numbers = ImageAsset(name: "numbers")
    internal static let picture = ImageAsset(name: "picture")
    internal static let subscribe = ImageAsset(name: "subscribe")
  }
  internal enum New {
    internal enum Avatars {
      internal static let avatar0 = ImageAsset(name: "avatar_0")
      internal static let avatar1 = ImageAsset(name: "avatar_1")
      internal static let avatar10 = ImageAsset(name: "avatar_10")
      internal static let avatar11 = ImageAsset(name: "avatar_11")
      internal static let avatar12 = ImageAsset(name: "avatar_12")
      internal static let avatar13 = ImageAsset(name: "avatar_13")
      internal static let avatar14 = ImageAsset(name: "avatar_14")
      internal static let avatar15 = ImageAsset(name: "avatar_15")
      internal static let avatar16 = ImageAsset(name: "avatar_16")
      internal static let avatar17 = ImageAsset(name: "avatar_17")
      internal static let avatar18 = ImageAsset(name: "avatar_18")
      internal static let avatar2 = ImageAsset(name: "avatar_2")
      internal static let avatar3 = ImageAsset(name: "avatar_3")
      internal static let avatar4 = ImageAsset(name: "avatar_4")
      internal static let avatar5 = ImageAsset(name: "avatar_5")
      internal static let avatar6 = ImageAsset(name: "avatar_6")
      internal static let avatar7 = ImageAsset(name: "avatar_7")
      internal static let avatar8 = ImageAsset(name: "avatar_8")
      internal static let avatar9 = ImageAsset(name: "avatar_9")
    }
    internal enum Backgrounds {
      internal static let alphabetBg = ImageAsset(name: "alphabet_bg")
      internal static let appleTree = ImageAsset(name: "apple_tree")
      internal static let avatarsBg = ImageAsset(name: "avatars_bg")
      internal static let homeBg = ImageAsset(name: "home_bg")
      internal static let profileBg = ImageAsset(name: "profile_bg")
      internal static let profileButtonBg = ImageAsset(name: "profile_button_bg")
      internal static let settingsBg = ImageAsset(name: "settings_bg")
      internal static let subscriptionBg = ImageAsset(name: "subscription_bg")
    }
    internal enum Buttons {
      internal static let closeBtn = ImageAsset(name: "close_btn")
      internal static let editBtn = ImageAsset(name: "edit_btn")
      internal static let settingsBtn = ImageAsset(name: "settings_btn")
      internal static let subscriptionImg = ImageAsset(name: "subscription_img")
    }
    internal enum Home {
      internal static let gameBtnAlphabet = ImageAsset(name: "game_btn_alphabet")
      internal static let gameBtnCanvas = ImageAsset(name: "game_btn_canvas")
      internal static let gameBtnCatch = ImageAsset(name: "game_btn_catch")
      internal static let gameBtnListen = ImageAsset(name: "game_btn_listen")
      internal static let gameBtnMemorize = ImageAsset(name: "game_btn_memorize")
      internal static let gameBtnNumbers = ImageAsset(name: "game_btn_numbers")
      internal static let gameBtnPictures = ImageAsset(name: "game_btn_pictures")
      internal static let gameBtnWord = ImageAsset(name: "game_btn_word")
      internal static let helloCloud = ImageAsset(name: "hello_cloud")
    }
    internal enum Icons {
      internal static let coinIcon = ImageAsset(name: "coin_icon")
      internal static let musicIcon = ImageAsset(name: "music_icon")
      internal static let soundIcon = ImageAsset(name: "sound_icon")
    }
    internal enum Letters {
      internal static let a = ImageAsset(name: "a")
      internal static let aGray = ImageAsset(name: "a_gray")
      internal static let b = ImageAsset(name: "b")
      internal static let bGray = ImageAsset(name: "b_gray")
      internal static let c = ImageAsset(name: "c")
      internal static let cGray = ImageAsset(name: "c_gray")
      internal static let d = ImageAsset(name: "d")
      internal static let dGray = ImageAsset(name: "d_gray")
      internal static let e = ImageAsset(name: "e")
      internal static let eGray = ImageAsset(name: "e_gray")
      internal static let f = ImageAsset(name: "f")
      internal static let fGray = ImageAsset(name: "f_gray")
      internal static let g = ImageAsset(name: "g")
      internal static let gGray = ImageAsset(name: "g_gray")
      internal static let h = ImageAsset(name: "h")
      internal static let hGray = ImageAsset(name: "h_gray")
      internal static let i = ImageAsset(name: "i")
      internal static let iGray = ImageAsset(name: "i_gray")
      internal static let j = ImageAsset(name: "j")
      internal static let jGray = ImageAsset(name: "j_gray")
      internal static let k = ImageAsset(name: "k")
      internal static let kGray = ImageAsset(name: "k_gray")
      internal static let l = ImageAsset(name: "l")
      internal static let lGray = ImageAsset(name: "l_gray")
      internal static let m = ImageAsset(name: "m")
      internal static let mGray = ImageAsset(name: "m_gray")
      internal static let n = ImageAsset(name: "n")
      internal static let nGray = ImageAsset(name: "n_gray")
      internal static let o = ImageAsset(name: "o")
      internal static let oGray = ImageAsset(name: "o_gray")
      internal static let p = ImageAsset(name: "p")
      internal static let pGray = ImageAsset(name: "p_gray")
      internal static let q = ImageAsset(name: "q")
      internal static let qGray = ImageAsset(name: "q_gray")
      internal static let r = ImageAsset(name: "r")
      internal static let rGray = ImageAsset(name: "r_gray")
      internal static let s = ImageAsset(name: "s")
      internal static let sGray = ImageAsset(name: "s_gray")
      internal static let t = ImageAsset(name: "t")
      internal static let tGray = ImageAsset(name: "t_gray")
      internal static let u = ImageAsset(name: "u")
      internal static let uGray = ImageAsset(name: "u_gray")
      internal static let v = ImageAsset(name: "v")
      internal static let vGray = ImageAsset(name: "v_gray")
      internal static let w = ImageAsset(name: "w")
      internal static let wGray = ImageAsset(name: "w_gray")
      internal static let x = ImageAsset(name: "x")
      internal static let xGray = ImageAsset(name: "x_gray")
      internal static let y = ImageAsset(name: "y")
      internal static let yGray = ImageAsset(name: "y_gray")
      internal static let z = ImageAsset(name: "z")
      internal static let zGray = ImageAsset(name: "z_gray")
    }
    internal enum Profile {
      internal static let achievementsIcon = ImageAsset(name: "achievements_icon")
      internal static let avatarsIcon = ImageAsset(name: "avatars_icon")
      internal static let getAvatarsIcon = ImageAsset(name: "get_avatars_icon")
    }
  }
  internal enum Numbers {
    internal static let _0 = ImageAsset(name: "0")
    internal static let _1 = ImageAsset(name: "1")
    internal static let _2 = ImageAsset(name: "2")
    internal static let _3 = ImageAsset(name: "3")
    internal static let _4 = ImageAsset(name: "4")
    internal static let _5 = ImageAsset(name: "5")
    internal static let _6 = ImageAsset(name: "6")
    internal static let _7 = ImageAsset(name: "7")
    internal static let _8 = ImageAsset(name: "8")
    internal static let _9 = ImageAsset(name: "9")
  }
  internal enum Onboarding {
    internal static let onboardingBg = ImageAsset(name: "onboarding_bg")
    internal static let onboardingCat1 = ImageAsset(name: "onboarding_cat_1")
    internal static let onboardingCat2 = ImageAsset(name: "onboarding_cat_2")
    internal static let onboardingCat3 = ImageAsset(name: "onboarding_cat_3")
    internal static let onboardingNameInputDefault = ImageAsset(name: "onboarding_name_input_default")
    internal static let onboardingTile = ImageAsset(name: "onboarding_tile")
  }
  internal enum Splash {
    internal static let splash = ImageAsset(name: "Splash")
  }
  internal enum Subscription {
    internal static let check = ImageAsset(name: "check")
    internal static let subscriptionBackground = ImageAsset(name: "subscription_background")
  }
  internal enum Words {
    internal static let ant = ImageAsset(name: "ant")
    internal static let apple = ImageAsset(name: "apple")
    internal static let banana = ImageAsset(name: "banana")
    internal static let book = ImageAsset(name: "book")
    internal static let cat = ImageAsset(name: "cat")
    internal static let cherry = ImageAsset(name: "cherry")
    internal static let dog = ImageAsset(name: "dog")
    internal static let duck = ImageAsset(name: "duck")
    internal static let eagle = ImageAsset(name: "eagle")
    internal static let elephant = ImageAsset(name: "elephant")
    internal static let fish = ImageAsset(name: "fish")
    internal static let frog = ImageAsset(name: "frog")
    internal static let giraffe = ImageAsset(name: "giraffe")
    internal static let grape = ImageAsset(name: "grape")
    internal static let hippo = ImageAsset(name: "hippo")
    internal static let horse = ImageAsset(name: "horse")
    internal static let iron = ImageAsset(name: "iron")
    internal static let island = ImageAsset(name: "island")
    internal static let jeans = ImageAsset(name: "jeans")
    internal static let juice = ImageAsset(name: "juice")
    internal static let king = ImageAsset(name: "king")
    internal static let koala = ImageAsset(name: "koala")
    internal static let lemon = ImageAsset(name: "lemon")
    internal static let lion = ImageAsset(name: "lion")
    internal static let monkey = ImageAsset(name: "monkey")
    internal static let mouse = ImageAsset(name: "mouse")
    internal static let napkin = ImageAsset(name: "napkin")
    internal static let noodle = ImageAsset(name: "noodle")
    internal static let octopus = ImageAsset(name: "octopus")
    internal static let orange = ImageAsset(name: "orange")
    internal static let penguin = ImageAsset(name: "penguin")
    internal static let pizza = ImageAsset(name: "pizza")
    internal static let queen = ImageAsset(name: "queen")
    internal static let rabbit = ImageAsset(name: "rabbit")
    internal static let rhino = ImageAsset(name: "rhino")
    internal static let ship = ImageAsset(name: "ship")
    internal static let snail = ImageAsset(name: "snail")
    internal static let tiger = ImageAsset(name: "tiger")
    internal static let tomato = ImageAsset(name: "tomato")
    internal static let umbrella = ImageAsset(name: "umbrella")
    internal static let unicorn = ImageAsset(name: "unicorn")
    internal static let van = ImageAsset(name: "van")
    internal static let volcano = ImageAsset(name: "volcano")
    internal static let window = ImageAsset(name: "window")
    internal static let wolf = ImageAsset(name: "wolf")
    internal static let xerox = ImageAsset(name: "xerox")
    internal static let yogurt = ImageAsset(name: "yogurt")
    internal static let zebra = ImageAsset(name: "zebra")
    internal static let zipper = ImageAsset(name: "zipper")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Image {
  init(asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: ImageAsset, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

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
