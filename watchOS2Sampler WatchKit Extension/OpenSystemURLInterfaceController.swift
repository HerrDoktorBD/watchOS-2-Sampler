//
//  OpenSystemURLInterfaceController.swift
//  watchOS2Sampler
//
//  Created by Shuichi Tsutsumi on 2015/06/13.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import WatchKit
import Foundation

class OpenSystemURLInterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        //super.awake(withContext: context)
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

    // =========================================================================
    // MARK: - Actions
    @IBAction func phoneBtnTapped() {
        let url = NSURL(string: "tel:")!
        WKExtension.shared().openSystemURL(url as URL)
    }

    @IBAction func smsBtnTapped() {
        let url = NSURL(string: "sms:")!
        WKExtension.shared().openSystemURL(url as URL)
    }
}
