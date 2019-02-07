//
//  ViewController.swift
//  PeanutLabs-iOS
//
//  Created by WinkowskiKonrad on 02/01/2019.
//  Copyright (c) 2019 WinkowskiKonrad. All rights reserved.
//

import UIKit
import PeanutLabs_iOS

class ViewController: UIViewController {

    private let peanutLabsManager = PeanutLabsManager.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onOpenRewardsCenter(_ sender: Any) {
        
        peanutLabsManager.presentRewardsCenter(on: self, with: self)
        
    }
    
}

extension ViewController: PeanutLabsManagerDelegate {
    
    func rewardsCenterDidOpen() {
        print("\(#function)")
        
    }
    
    func rewardsCenterDidClose() {
        print("\(#function)")
        
    }
    
    func peanutLabsManager(faliedWith error: PeanutLabsErrors) {
        print("\(#function)")
        
    }
    
    
}

