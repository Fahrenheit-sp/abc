import AppsFlyerLib
import Firebase
import GoogleMobileAds
import Purchases
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var currentFlow: Flow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppsFlyerLib.shared().appsFlyerDevKey = Constants.appsFlyerId
        AppsFlyerLib.shared().appleAppID = Constants.appStoreId
        AppsFlyerLib.shared().start()

        FirebaseApp.configure()
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [kGADSimulatorID]

        Purchases.configure(withAPIKey: Constants.revenueCatId)

        RevenueCatProductsFetcher.shared.fetchProducts()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = LoadingViewController()
        window?.makeKeyAndVisible()

        setupFlow(animated: false)

        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateUser), name: .userUpdated, object: nil)

        return true
    }

    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        AppsFlyerLib.shared().handlePushNotification(userInfo)
    }

    func open(_ url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        AppsFlyerLib.shared().handleOpen(url, sourceApplication: sourceApplication, withAnnotation: annotation)
        return true
    }

    func open(_ url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        AppsFlyerLib.shared().handleOpen(url, options: options)
        return true
    }

    func continueActivity(_ activity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
       AppsFlyerLib.shared().continue(activity, restorationHandler: nil)
       return true
    }

    // MARK: - Flow methods

    private func setupFlow(animated: Bool) {
        let user = UserDataManager().getUser()
        let flow: Flow = user.isSubscribed ? SubscribedFlow() : FreeFlow()
        changeFlow(to: flow, animated: animated)
    }

    private func changeFlow(to flow: Flow, animated: Bool = true) {
        guard currentFlow?.description != flow.description else { return }
        currentFlow = flow
        currentFlow?.start(from: window, animated: animated)
    }

    @objc private func didUpdateUser() {
        setupFlow(animated: true)
    }

}
