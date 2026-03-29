import SwiftUI

@main
struct ABCApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var settings = Settings()
//    @StateObject private var purchaseService = InAppPurchaseService()
//    private let analytics = MainAnalyticsService(services: [FirebaseAnalytics(), AmplitudeAnalytics()])
//    private let persistence = PersistenceController.shared
    
    @State private var isSplashSeen = false
    @State private var isInitialPaywallSeen = false
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if !settings.isOnboardingSeen {
                    OnboardingView {
                        settings.isOnboardingSeen = true
                    }
                } else {
                    Color.yellow
                }
            }
            .preferredColorScheme(.light)
            .environmentObject(settings)
//            .environmentObject(purchaseService)
//            .environmentObject(analytics)
//            .onChange(of: purchaseService.expirationDate) { newValue in
//                settings.expirationDate = newValue
//            }
//            .onAppear {
//                purchaseService.fetchProducts(completion: {})
//                purchaseService.validatePurchase()
//                purchaseService.analytics = analytics
//            }
        }
    }
    
//    @ViewBuilder
//    private var mainView: some View {
//        if settings.isPremium || isInitialPaywallSeen || !settings.isOnboardingSeen {
//            MainView()
//        } else {
//            PaywallView(source: .initial) { isInitialPaywallSeen = true }
//        }
//    }
}
