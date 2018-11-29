//
//  Athlete.swift
//  NircaTracker
//
//  Created by Ethan Febinger on 11/8/18.
//  Copyright © 2018 Ethan Febinger. All rights reserved.
//
import UIKit

class Athlete {
    
    //MARK: Properties
    
    var firstName: String
    var lastName: String
    var college: String
    var results: Array<Result>

    //MARK: Initialization
    
    init?(firstName: String, lastName: String, college: String, results: Array<Result>) {
        if(firstName.isEmpty || lastName.isEmpty){ return nil }
        
        self.firstName = firstName
        self.lastName = lastName
        self.college = college
        self.results = results
    }
    
}


