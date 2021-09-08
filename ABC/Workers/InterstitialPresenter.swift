//
//  InterstitialPresenter.swift
//  ABC
//
//  Created by Игорь Майсюк on 8.09.21.
//

import GoogleMobileAds

protocol InterstitialPresenterDelegate: AnyObject {
    func presenterDidLoadAd(_ presenter: InterstitialPresenter)
    func presenterDidFailToPresentAd(_ presenter: InterstitialPresenter)
    func presenterDidDisplayAd(_ presenter: InterstitialPresenter)
    func presenterWillDismissAd(_ presenter: InterstitialPresenter)
    func presenterDidDismissAd(_ presenter: InterstitialPresenter)
}

final class InterstitialPresenter: NSObject {

    private var interstitial: GADInterstitialAd?

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

    func presentAd(from controller: UIViewController) {
        guard let ad = interstitial else { delegate?.presenterDidFailToPresentAd(self); return }
        do {
            try ad.canPresent(fromRootViewController: controller)
            ad.present(fromRootViewController: controller)
        } catch {
            print("Can not present ad: \(error.localizedDescription)")
        }
    }
}

extension InterstitialPresenter: GADFullScreenContentDelegate {
    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        delegate?.presenterDidDisplayAd(self)
    }

    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        delegate?.presenterDidFailToPresentAd(self)
    }

    func adWillDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        delegate?.presenterWillDismissAd(self)
    }

    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        delegate?.presenterDidDismissAd(self)
        loadAd()
    }
}
