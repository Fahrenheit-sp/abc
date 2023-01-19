//
//  InterstitialPresenter.swift
//  ABC
//
//  Created by Игорь Майсюк on 8.09.21.
//

import GoogleMobileAds

protocol InterstitialPresenterDelegate: AnyObject {
    func presenterDidLoadAd(_ presenter: InterstitialPresenter)
    func presenterDidFailToPresentAd(_ presenter: InterstitialPresenter, from controller: UIViewController?, isStartingAd: Bool)
    func presenterDidDisplayAd(_ presenter: InterstitialPresenter, from controller: UIViewController?)
    func presenterWillDismissAd(_ presenter: InterstitialPresenter, from controller: UIViewController?, isStartingAd: Bool)
    func presenterDidDismissAd(_ presenter: InterstitialPresenter, from controller: UIViewController?)
}

final class InterstitialPresenter: NSObject {

    private var interstitial: GADInterstitialAd?
    private var isStartingAd = true
    private weak var controller: UIViewController?

    weak var delegate: InterstitialPresenterDelegate?

    func loadAd() {
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: Constants.googleInterstitialId,
                               request: request) { [weak self] ad, error in
            guard error == nil else { return print(String(describing: error?.localizedDescription)) }
            self?.interstitial = ad
            self?.interstitial?.fullScreenContentDelegate = self
            self.map { $0.delegate?.presenterDidLoadAd($0) }
        }
    }

    func presentAd(from controller: UIViewController, isStartingAd: Bool) {
        self.controller = controller
        self.isStartingAd = isStartingAd
        guard let ad = interstitial else {
            delegate?.presenterDidFailToPresentAd(self, from: controller, isStartingAd: isStartingAd)
            loadAd()
            return
        }
        do {
            try ad.canPresent(fromRootViewController: controller)
            ad.present(fromRootViewController: controller)
        } catch {
            delegate?.presenterDidFailToPresentAd(self, from: controller, isStartingAd: isStartingAd)
            loadAd()
        }
    }
}

extension InterstitialPresenter: GADFullScreenContentDelegate {
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        delegate?.presenterDidDisplayAd(self, from: controller)
    }

    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        delegate?.presenterDidFailToPresentAd(self, from: controller, isStartingAd: isStartingAd)
        loadAd()
    }

    func adWillDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        delegate?.presenterWillDismissAd(self, from: controller, isStartingAd: isStartingAd)
    }

    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        delegate?.presenterDidDismissAd(self, from: controller)
        loadAd()
    }
}
