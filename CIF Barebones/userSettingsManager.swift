//
//  userSettingsManager.swift
//  CIF Barebones
//
//  Created by Connor Wybranowski on 6/5/15.
//  Copyright (c) 2015 Wybro. All rights reserved.
//

import UIKit
import Parse

// Global scope code
var settingsMgr: UserSettingsManager = UserSettingsManager()

class UserSettingsManager: NSObject {
    var locationSettingsType: String = ""
    var serviceHourAmount: String = "0"
    
    func setLocationSettings(value: String) {
        self.locationSettingsType = value
    }
    
    func setServiceHour(value: String) {
        self.serviceHourAmount = value
    }
    
    func getLocationSettings() -> String {
        return self.locationSettingsType
    }
    
    func getServiceHourAmount() -> String {
        return self.serviceHourAmount
    }
    
    func clearSettings() {
        self.locationSettingsType = ""
        self.serviceHourAmount = "0"
    }
}
