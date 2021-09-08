import UIKit
import GoogleMobileAds

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GADMobileAds.sharedInstance().start(completionHandler: nil)

        let router = MainMenuRouter(parameters: .init(items: MainMenuItem.allCases))
        let adapter = MainMenuInterstitialRouterAdapter(adaptee: router)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = adapter.makeController()
        window?.makeKeyAndVisible()

//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.window?.resignKey()
//            self.window = nil
//        }
        return true
    }

}

