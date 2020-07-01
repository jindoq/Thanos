//
//  PaveCtr.swift
//  PAVE
//
//  Created by Duy Tu Tran on 3/18/20.
//  Copyright © 2020 Discovery Loft. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds

open class ThanosCtr: UIViewController {
    var isEnableAdmod = false {
        didSet {
            if isEnableAdmod {
                bannerId = ""
                interstitalId = ""
            } else {
                // TEST
                bannerId = "ca-app-pub-3940256099942544/2934735716"
                interstitalId = "ca-app-pub-3940256099942544/4411468910"
            }
        }
    }
    
    private var bannerId = ""
    private var interstitalId = ""

    var bannerView: GADBannerView!
    var interstitial: GADInterstitial!
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        isEnableAdmod = true
        interstitial = createAndLoadInterstitial()
    }
    
    public func showAdmodInterstital() {
        if interstitial.isReady {
            let requestAd = UserDefaults.standard.integer(forKey: "Request_Ad")
            if requestAd == 0 {
                interstitial.present(fromRootViewController: self)
                UserDefaults.standard.set(requestAd + 1, forKey: "Request_Ad")
            } else if requestAd >= 5 {
                UserDefaults.standard.set(0, forKey: "Request_Ad")
            } else {
                UserDefaults.standard.set(requestAd + 1, forKey: "Request_Ad")
            }
        } else {
            print("Ad wasn't ready")
        }
    }
    
    public func showAdmodBanner() {
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        bannerView.adUnitID = bannerId
        bannerView.rootViewController = self
        let request = GADRequest()
        bannerView.load(request)
        bannerView.delegate = self
        addBannerViewToView(bannerView)
    }
    
    private func createAndLoadInterstitial() -> GADInterstitial {
        interstitial = GADInterstitial(adUnitID: interstitalId)
        interstitial.delegate = self
        let request = GADRequest()
        interstitial.load(request)
        return interstitial
    }
    
    private func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.bringSubviewToFront(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
}

extension ThanosCtr: GADBannerViewDelegate{
    /// Tells the delegate an ad request loaded an ad.
    public func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
        bannerView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            bannerView.alpha = 1
        })
    }
    
    /// Tells the delegate an ad request failed.
    public func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    public func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    public func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    public func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    public func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
}

extension ThanosCtr: GADInterstitialDelegate {
    
    /// Tells the delegate an ad request succeeded.
    public func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("interstitialDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    public func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that an interstitial will be presented.
    public func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        print("interstitialWillPresentScreen")
    }
    
    /// Tells the delegate the interstitial is to be animated off the screen.
    public func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        print("interstitialWillDismissScreen")
    }
    
    /// Tells the delegate the interstitial had been animated off the screen.
    public func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
        print("interstitialDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app
    public func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        print("interstitialWillLeaveApplication")
    }
}

extension UIViewController {
    open func present(_ vc: UIViewController) {
        vc.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    open func push(_ vc: UIViewController) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
