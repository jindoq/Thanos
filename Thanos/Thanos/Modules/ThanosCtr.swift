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
            } else {
                // TEST
                bannerId = "ca-app-pub-3940256099942544/2934735716"
            }
        }
    }

    private var bannerId = ""
    var bannerView: GADBannerView!

    override open func viewDidLoad() {
        super.viewDidLoad()
        isEnableAdmod = false
        view.backgroundColor = .white
        
        if let views = navigationController?.viewControllers, views.count >= 2 {
            setupAds()
        }
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let banner = bannerView {
            banner.isHidden = IAPProducts.store.isProductPurchased(IAPProducts.removeAds)
        }
    }

    public func showAdmodBanner() {
        guard !IAPProducts.store.isProductPurchased(IAPProducts.removeAds) else {
            return
        }
        
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        bannerView.adUnitID = bannerId
        bannerView.rootViewController = self
        let request = GADRequest()
        bannerView.load(request)
        bannerView.delegate = self
        addBannerViewToView(bannerView)
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

    open func setupAds() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_back", in: Bundle(for: ThanosCtr.self), compatibleWith: nil), style: .done, target: self, action: #selector(showAds))
    }

    @objc open func showAds() {
        AdsManager.ads.showAdmodInterstital(vc: self) {
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    open func setupSetting() {
        let shopBtn = UIBarButtonItem(image: UIImage(named: "ic_shop", in: Bundle(for: ThanosCtr.self), compatibleWith: nil), style: .done, target: self, action: #selector(shoppingAction))
        let settingBtn = UIBarButtonItem(image: UIImage(named: "ic_setting", in: Bundle(for: ThanosCtr.self), compatibleWith: nil), style: .done, target: self, action: #selector(settingAction))
        navigationItem.rightBarButtonItem = shopBtn
        navigationItem.leftBarButtonItem = settingBtn
    }

    @objc open func shoppingAction() {
        let vc = IAPCtr()
        push(vc)
    }
    
    @objc open func settingAction() {
        let vc = SettingCtr()
        push(vc)
    }
}

extension ThanosCtr {
    open func present(_ vc: UIViewController) {
        vc.modalPresentationStyle = .fullScreen
        AdsManager.ads.showAdmodInterstital(vc: self) {
            DispatchQueue.main.async {
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    open func push(_ vc: UIViewController) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        AdsManager.ads.showAdmodInterstital(vc: self) {
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

public struct AdsManager {
    public static let ads = AdsInterstitial()
}

public class AdsInterstitial: NSObject, GADInterstitialDelegate {
    private var intervalTime: TimeInterval = 60
    private var lastTime: TimeInterval?

    private var callback: (() -> Void)?
    private var interstitalId = ""
    private var interstitial: GADInterstitial!
    private var showing = true
    
    public func start(enable: Bool) {
        if enable {
            interstitalId = ""
        } else {
            // TEST
            interstitalId = "ca-app-pub-3940256099942544/4411468910"
        }
        
        interstitial = createAndLoadInterstitial()
    }
    
    public func showAdmodInterstital(vc: UIViewController, completed: @escaping () -> Void) {
        guard !IAPProducts.store.isProductPurchased(IAPProducts.removeAds) else {
            completed()
            return
        }
        
        guard showing else {
            completed()
            return
        }
        
        if lastTime == nil {
            if interstitial.isReady {
                lastTime = Date().timeIntervalSince1970
                interstitial.present(fromRootViewController: vc)
                callback = completed
            } else {
                completed()
            }
            return
        }
        
        guard let time = lastTime else {
            completed()
            return
        }
        
        guard time + intervalTime <= Date().timeIntervalSince1970 else {
            completed()
            return
        }
    
        lastTime = Date().timeIntervalSince1970
        
        if interstitial.isReady {
            interstitial.present(fromRootViewController: vc)
            callback = completed
        } else {
            completed()
        }
    }
    
    public func createAndLoadInterstitial() -> GADInterstitial {
        interstitial = GADInterstitial(adUnitID: interstitalId)
        interstitial.delegate = self
        let request = GADRequest()
        interstitial.load(request)
        return interstitial
    }
    
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
        callback?()
        interstitial = createAndLoadInterstitial()
        print("interstitialDidDismissScreen")
    }

    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    public func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        showing = false
        print("interstitialWillLeaveApplication")
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
