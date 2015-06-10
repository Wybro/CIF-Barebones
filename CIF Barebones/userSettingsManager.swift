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
    var zipCode: String = ""
    var serviceHourAmount: String = "0"
    
    func setLocationSettings(value: String) {
        self.locationSettingsType = value
    }
    
    func setZipCodeValue(value: String) {
        self.zipCode = value
    }
    
    func setServiceHour(value: String) {
        self.serviceHourAmount = value
        // Change hours for hours graphics
        maxAmount = value.toInt()!
    }
    
    func getLocationSettings() -> String {
        return self.locationSettingsType
    }
    
    func getZipCodeValue() -> String {
        return self.zipCode
    }
    
    func getServiceHourAmount() -> String {
        return self.serviceHourAmount
    }
    
    func clearSettings() {
        self.locationSettingsType = ""
        self.zipCode = ""
        self.serviceHourAmount = "0"
    }
}
