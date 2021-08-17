import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let router = MainMenuRouter(parameters: .init(items: [.alphabet, .numbers, .games, .canvas]))

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = router.makeController()
        window?.makeKeyAndVisible()

//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.window?.resignKey()
//            self.window = nil
//        }
        return true
    }

}

