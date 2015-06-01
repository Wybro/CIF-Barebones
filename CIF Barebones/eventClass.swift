//
//  eventClass.swift
//  CIF Barebones
//
//  Created by Connor Wybranowski on 5/31/15.
//  Copyright (c) 2015 Wybro. All rights reserved.
//

import Foundation

class Event {
    var title: String
    var location: String
    var bio: String
    var requirements: String
    
    
    init(eventTitle: String, eventLocation: String, eventBio: String, eventReq: String){
        self.title = eventTitle
        self.location = eventLocation
        self.bio = eventBio
        self.requirements = eventReq
    }
    
    
    func getTitle() -> String {
        return self.title
    }
    
    func getLocation() -> String {
        return self.location
    }
    
    func getBio() -> String {
        return self.bio
    }
    
    func getRequirements() -> String {
        return self.requirements
    }
    
    
    
    
    
}