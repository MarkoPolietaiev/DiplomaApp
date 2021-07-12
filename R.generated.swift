//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 4 storyboards.
  struct storyboard {
    /// Storyboard `Auth`.
    static let auth = _R.storyboard.auth()
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    /// Storyboard `Profile`.
    static let profile = _R.storyboard.profile()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Auth", bundle: ...)`
    static func auth(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.auth)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Profile", bundle: ...)`
    static func profile(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.profile)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 3 colors.
  struct color {
    /// Color `AccentColor`.
    static let accentColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentColor")
    /// Color `buttonColor`.
    static let buttonColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "buttonColor")
    /// Color `titleColor`.
    static let titleColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "titleColor")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "buttonColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func buttonColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.buttonColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "titleColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func titleColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.titleColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "buttonColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func buttonColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.buttonColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "titleColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func titleColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.titleColor.name)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.file` struct is generated, and contains static references to 3 files.
  struct file {
    /// Resource file `en.lproj`.
    static let enLproj = Rswift.FileResource(bundle: R.hostingBundle, name: "en", pathExtension: "lproj")
    /// Resource file `pl.lproj`.
    static let plLproj = Rswift.FileResource(bundle: R.hostingBundle, name: "pl", pathExtension: "lproj")
    /// Resource file `ru.lproj`.
    static let ruLproj = Rswift.FileResource(bundle: R.hostingBundle, name: "ru", pathExtension: "lproj")

    /// `bundle.url(forResource: "en", withExtension: "lproj")`
    static func enLproj(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.enLproj
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "pl", withExtension: "lproj")`
    static func plLproj(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.plLproj
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "ru", withExtension: "lproj")`
    static func ruLproj(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.ruLproj
      return fileResource.bundle.url(forResource: fileResource)
    }

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 3 images.
  struct image {
    /// Image `logInImage`.
    static let logInImage = Rswift.ImageResource(bundle: R.hostingBundle, name: "logInImage")
    /// Image `signUpImage`.
    static let signUpImage = Rswift.ImageResource(bundle: R.hostingBundle, name: "signUpImage")
    /// Image `welcomeImage`.
    static let welcomeImage = Rswift.ImageResource(bundle: R.hostingBundle, name: "welcomeImage")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "logInImage", bundle: ..., traitCollection: ...)`
    static func logInImage(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.logInImage, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "signUpImage", bundle: ..., traitCollection: ...)`
    static func signUpImage(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.signUpImage, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "welcomeImage", bundle: ..., traitCollection: ...)`
    static func welcomeImage(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.welcomeImage, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.info` struct is generated, and contains static references to 1 properties.
  struct info {
    struct uiApplicationSceneManifest {
      static let _key = "UIApplicationSceneManifest"
      static let uiApplicationSupportsMultipleScenes = false

      struct uiSceneConfigurations {
        static let _key = "UISceneConfigurations"

        struct uiWindowSceneSessionRoleApplication {
          struct defaultConfiguration {
            static let _key = "Default Configuration"
            static let uiSceneConfigurationName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneConfigurationName") ?? "Default Configuration"
            static let uiSceneDelegateClassName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneDelegateClassName") ?? "$(PRODUCT_MODULE_NAME).SceneDelegate"
            static let uiSceneStoryboardFile = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneStoryboardFile") ?? "Main"

            fileprivate init() {}
          }

          fileprivate init() {}
        }

        fileprivate init() {}
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  /// This `R.nib` struct is generated, and contains static references to 1 nibs.
  struct nib {
    /// Nib `DescriptionView`.
    static let descriptionView = _R.nib._DescriptionView()

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "DescriptionView", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.descriptionView) instead")
    static func descriptionView(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.descriptionView)
    }
    #endif

    static func descriptionView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
      return R.nib.descriptionView.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct nib {
    struct _DescriptionView: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "DescriptionView"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }
  #endif

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try auth.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try main.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try profile.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct auth: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController

      let bundle = R.hostingBundle
      let descriptionViewController = StoryboardViewControllerResource<DescriptionViewController>(identifier: "DescriptionViewController")
      let firstViewController = StoryboardViewControllerResource<FirstViewController>(identifier: "FirstViewController")
      let name = "Auth"
      let signInViewController = StoryboardViewControllerResource<SignInViewController>(identifier: "SignInViewController")
      let signUpViewController = StoryboardViewControllerResource<SignUpViewController>(identifier: "SignUpViewController")

      func descriptionViewController(_: Void = ()) -> DescriptionViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: descriptionViewController)
      }

      func firstViewController(_: Void = ()) -> FirstViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: firstViewController)
      }

      func signInViewController(_: Void = ()) -> SignInViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: signInViewController)
      }

      func signUpViewController(_: Void = ()) -> SignUpViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: signUpViewController)
      }

      static func validate() throws {
        if #available(iOS 13.0, *) { if UIKit.UIImage(systemName: "chevron.left") == nil { throw Rswift.ValidationError(description: "[R.swift] System image named 'chevron.left' is used in storyboard 'Auth', but couldn't be loaded.") } }
        if UIKit.UIImage(named: "logInImage", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'logInImage' is used in storyboard 'Auth', but couldn't be loaded.") }
        if UIKit.UIImage(named: "signUpImage", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'signUpImage' is used in storyboard 'Auth', but couldn't be loaded.") }
        if UIKit.UIImage(named: "welcomeImage", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'welcomeImage' is used in storyboard 'Auth', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
          if UIKit.UIColor(named: "Color", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'Color' is used in storyboard 'Auth', but couldn't be loaded.") }
          if UIKit.UIColor(named: "buttonColor", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'buttonColor' is used in storyboard 'Auth', but couldn't be loaded.") }
          if UIKit.UIColor(named: "titleColor", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Color named 'titleColor' is used in storyboard 'Auth', but couldn't be loaded.") }
        }
        if _R.storyboard.auth().descriptionViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'descriptionViewController' could not be loaded from storyboard 'Auth' as 'DescriptionViewController'.") }
        if _R.storyboard.auth().firstViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'firstViewController' could not be loaded from storyboard 'Auth' as 'FirstViewController'.") }
        if _R.storyboard.auth().signInViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'signInViewController' could not be loaded from storyboard 'Auth' as 'SignInViewController'.") }
        if _R.storyboard.auth().signUpViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'signUpViewController' could not be loaded from storyboard 'Auth' as 'SignUpViewController'.") }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct main: Rswift.StoryboardResourceType, Rswift.Validatable {
      let actionsViewController = StoryboardViewControllerResource<ActionsViewController>(identifier: "ActionsViewController")
      let bundle = R.hostingBundle
      let feedViewController = StoryboardViewControllerResource<FeedViewController>(identifier: "FeedViewController")
      let name = "Main"
      let searchViewController = StoryboardViewControllerResource<SearchViewController>(identifier: "SearchViewController")
      let tabBarViewController = StoryboardViewControllerResource<TabBarViewController>(identifier: "TabBarViewController")

      func actionsViewController(_: Void = ()) -> ActionsViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: actionsViewController)
      }

      func feedViewController(_: Void = ()) -> FeedViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: feedViewController)
      }

      func searchViewController(_: Void = ()) -> SearchViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: searchViewController)
      }

      func tabBarViewController(_: Void = ()) -> TabBarViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: tabBarViewController)
      }

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.main().actionsViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'actionsViewController' could not be loaded from storyboard 'Main' as 'ActionsViewController'.") }
        if _R.storyboard.main().feedViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'feedViewController' could not be loaded from storyboard 'Main' as 'FeedViewController'.") }
        if _R.storyboard.main().searchViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'searchViewController' could not be loaded from storyboard 'Main' as 'SearchViewController'.") }
        if _R.storyboard.main().tabBarViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'tabBarViewController' could not be loaded from storyboard 'Main' as 'TabBarViewController'.") }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct profile: Rswift.StoryboardResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "Profile"
      let profileViewController = StoryboardViewControllerResource<ProfileViewController>(identifier: "ProfileViewController")

      func profileViewController(_: Void = ()) -> ProfileViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: profileViewController)
      }

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.profile().profileViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'profileViewController' could not be loaded from storyboard 'Profile' as 'ProfileViewController'.") }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
