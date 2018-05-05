//
//  course.swift
//  check
//
//  Created by Nandita Mohan on 4/27/18.
//  Copyright © 2018 Nandita Mohan. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class Course{
    var name: String
    var tasks: [Task]
    var category: String
    
    init(name: String){
        self.name = name
        self.tasks = [] //pull from last saved (database)
        self.category = "default"
    }
    
    init(from json: JSON) {
        self.name = json["name"].stringValue
        self.tasks = []
        self.category = json["category"].stringValue
    }
    
    func addTask(nom: String, desc : String, tim: String, prio: String){
        let task = Task(name: nom, description: desc, time: tim, course_name: prio)
        tasks.append(task)
    }
    
    func deleteTask(nom: String){
        if let i = tasks.index(where: {$0.name == nom}){
            tasks.remove(at: i)
        }
    }

    
}
