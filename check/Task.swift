//
//  Task.swift
//  check
//
//  Created by Nandita Mohan on 4/27/18.
//  Copyright © 2018 Nandita Mohan. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class Task {
    
    var name : String
    var description : String
    var time : String
    var course_name : String
    
    init(name : String, description : String, time: String, course_name: String){
        self.name = name
        self.description = description
        self.time = time
        self.course_name = course_name
    }
    
    init(from json: JSON) {
        self.name = json["name"].stringValue
        self.description = json["description"].stringValue
        self.time = json["due_date"].stringValue
        self.course_name = json["course_name"].stringValue
    }
    
}
