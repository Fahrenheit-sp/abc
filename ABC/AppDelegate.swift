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

