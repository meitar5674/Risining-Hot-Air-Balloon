//
//  GameViewController.swift
//  Rising Hot Air Balloon
//
//  Created by Meitar Basson on 15/07/2016.
//  Copyright (c) 2016 meitar. All rights reserved.
//

//
//  GameViewController.swift
//  Rising Baloon
//
//  Created by Meitar Basson on 07/07/2016.
//  Copyright (c) 2016 meitar. All rights reserved.
//

import UIKit
import SpriteKit
import GoogleMobileAds

class GameViewController: UIViewController, GADInterstitialDelegate{
    
    var interstitial: GADInterstitial!
    var intersitialRecievedAd = false
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interstitial = GADInterstitial()
        
        interstitial.delegate = self
        self.interstitial = createAndLoadAd()
        
        _ = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(GameViewController.checkIfAdIsToBeDisplayed(_:)), userInfo: nil, repeats: true)
        
        
        if let scene = HomeScene(fileNamed: "Game") {
            // Configure the view.
            let skView = self.view as! SKView
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            skView.presentScene(scene)
        }
        
        //
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameViewController.showInterstitial) , name:"showInterAdKey", object: nil);
        //
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    
    func checkIfAdIsToBeDisplayed(timer:NSTimer) {
        
        
        
        if defaults.boolForKey("adToBeShown") == true && intersitialRecievedAd == true {
            
            showInterstitial()
            defaults.setBool(false, forKey: "adToBeShown")
            intersitialRecievedAd = false
            
            
        } else {
            
            
        }
        
    }
    
    func interstitialDidReceiveAd(ad: GADInterstitial!) {
        
        
        intersitialRecievedAd = true
        
    }
    
    func createAndLoadAd() -> GADInterstitial {
        let ad = GADInterstitial(adUnitID: "ca-app-pub-9799415321725533/4207589203")
        ad.delegate = self
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        ad.loadRequest(request)
        return ad
    }
    
    func showInterstitial(){
        if self.interstitial.isReady {
            self.interstitial.presentFromRootViewController(self)
            self.interstitial = createAndLoadAd()
        }
    }
    
}
