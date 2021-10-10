// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal enum Games {
    internal static let questionMark = ImageAsset(name: "question_mark")
    internal static let starEmpty = ImageAsset(name: "star_empty")
    internal static let starFilled = ImageAsset(name: "star_filled")
  }
  internal enum Icons {
    internal static let close = ImageAsset(name: "close")
    internal static let recycleBin = ImageAsset(name: "recycle_bin")
  }
  internal enum Letters {
    internal static let a = ImageAsset(name: "a")
    internal static let b = ImageAsset(name: "b")
    internal static let c = ImageAsset(name: "c")
    internal static let d = ImageAsset(name: "d")
    internal static let e = ImageAsset(name: "e")
    internal static let f = ImageAsset(name: "f")
    internal static let g = ImageAsset(name: "g")
    internal static let h = ImageAsset(name: "h")
    internal static let i = ImageAsset(name: "i")
    internal static let j = ImageAsset(name: "j")
    internal static let k = ImageAsset(name: "k")
    internal static let l = ImageAsset(name: "l")
    internal static let m = ImageAsset(name: "m")
    internal static let n = ImageAsset(name: "n")
    internal static let o = ImageAsset(name: "o")
    internal static let p = ImageAsset(name: "p")
    internal static let q = ImageAsset(name: "q")
    internal static let r = ImageAsset(name: "r")
    internal static let s = ImageAsset(name: "s")
    internal static let t = ImageAsset(name: "t")
    internal static let u = ImageAsset(name: "u")
    internal static let v = ImageAsset(name: "v")
    internal static let w = ImageAsset(name: "w")
    internal static let x = ImageAsset(name: "x")
    internal static let y = ImageAsset(name: "y")
    internal static let z = ImageAsset(name: "z")
  }
  internal enum Listen {
    internal static let playButton = ImageAsset(name: "play_button")
  }
  internal enum Menu {
    internal static let abc = ImageAsset(name: "abc")
    internal static let alphabet = ImageAsset(name: "alphabet")
    internal static let background = ImageAsset(name: "background")
    internal static let canvas = ImageAsset(name: "canvas")
    internal static let listen = ImageAsset(name: "listen")
    internal static let makeAWord = ImageAsset(name: "make_a_word")
    internal static let memorize = ImageAsset(name: "memorize")
    internal static let numbers = ImageAsset(name: "numbers")
    internal static let subscribe = ImageAsset(name: "subscribe")
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
  internal enum Subscription {
    internal static let check = ImageAsset(name: "check")
    internal static let subscriptionBackground = ImageAsset(name: "subscription_background")
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
}

internal extension ImageAsset.Image {
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
