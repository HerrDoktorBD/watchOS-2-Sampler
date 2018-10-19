//
//  FPSTrialInterfaceController.swift
//  watchOS2Sampler
//
//  Created by Shuichi Tsutsumi on 1/7/16.
//  Copyright © 2016 Shuichi Tsutsumi. All rights reserved.
//

import WatchKit
import Foundation

class FPSTrialInterfaceController: WKInterfaceController {

    @IBOutlet weak var image: WKInterfaceImage!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        print("awakeWithContext")
    }

    override func willActivate() {
        super.willActivate()
        
        btn3Tapped()
    }

    override func didDeactivate() {
        super.didDeactivate()
        
        image.stopAnimating()
    }

    private func startAnimating(fps: Int) {
        
        image.stopAnimating()
        
        var images: [UIImage] = []

        for i in 1...fps {
            let index = 36 * i / fps
            let fileName = String(format: "progress-%d", index);
            let image = UIImage(named: fileName)
            images.append(image!)
        }

        let animatedImage = UIImage.animatedImage(
            with: images,
            duration: 1.0)
        
        image.setImage(animatedImage)
        image.startAnimating()
    }

    // =========================================================================
    // MARK: - Actions
    @IBAction func btn1Tapped() {
        startAnimating(fps: 36)
    }

    @IBAction func btn2Tapped() {
        startAnimating(fps: 24)
    }

    @IBAction func btn3Tapped() {
        startAnimating(fps: 12)
    }
}
