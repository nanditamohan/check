//
//  Network.swift
//  check
//
//  Created by Nandita Mohan on 5/4/18.
//  Copyright © 2018 Nandita Mohan. All rights reserved.
//
import Foundation

import Alamofire
import SwiftyJSON

class Network {
    
    private static let endpoint = "https://itunes.apple.com/search"
    private static let getCourseEndpoint = "http://104.196.110.31/check/course"
    private static let getAllCoursesEndpt = "http://104.196.110.31/check/course/all"
    private static let getTasksEndpoint = "http://104.196.110.31/check/task"
    
    static func postTask(withName name: String, withDescription description: String, withDueDate dueDate: String, withCourseName course: String) {
        
        let parameters: Parameters = [
            "name" : name,
            "description" : description,
            "due_date" : dueDate,
            "course_name" : course
        ]
        
        Alamofire.request(getTasksEndpoint, method: .post,
                          parameters: parameters,
                          encoding: URLEncoding(destination: .queryString)).responseJSON { (response) in
                            switch response.result {
                            case .success(let json):
                                
                                let json = JSON(json)
                                
                            case .failure(let error):
                                print("[Network] Error:", error)
                            }
        }
    }
    
    
    static func getTasks(withCourse course: String, _ completion: @escaping ([Task]) -> Void) {
        
        let parameters: Parameters = [
            "course_name" : course
        ]
        
        
        Alamofire.request(getTasksEndpoint, parameters: parameters).validate().responseJSON { (response) in
            
            switch response.result {
                
            case .success(let json):
                
                let json = JSON(json)
                var tasks: [Task] = []
                
                for taskJSON in json["tasks"].arrayValue  {
                    tasks.append(Task(from: taskJSON))
                }
                
                completion(tasks)
                
            case .failure(let error):
                print("[Network] Error:", error)
                completion([])
                
            }
            
        }
    }
    
    
    static func getAllCourses(_ completion: @escaping ([Course]) -> Void) {
        
        Alamofire.request(getAllCoursesEndpt, method: .get).validate().responseJSON { (response) in
            
            switch response.result {
                
            case .success(let json):
                
                let json = JSON(json)
                var courses: [Course] = []
                
                for courseJSON in json["courses"].arrayValue  {
                    courses.append(Course(from: courseJSON))
                }
                
                completion(courses)
                
            case .failure(let error):
                print("[Network] Error:", error)
                completion([])
        }
        
    }
    }
    
    
    static func postCourse(withName name: String, withCategory category: String) {
        
        let parameters: Parameters = [
            "name" : name,
            "category" : category
        ]
        
        Alamofire.request(getCourseEndpoint, method: .post,
                          parameters: parameters,
                          encoding: URLEncoding(destination: .queryString)).responseJSON { (response) in
            switch response.result {
            case .success(let json):
                
                let json = JSON(json)
                
            case .failure(let error):
                print("[Network] Error:", error)
            }
        }
    }
    
    
    
    
    static func getBooks(withQuery query: String, _ completion: @escaping ([Ebook]) -> Void) {
        
        let parameters: Parameters = [
            "term" : query.replacingOccurrences(of: " ", with: "+"),
            "country" : "US",
            "media" : "ebook",
            "entity" : "ebook"
        ]

        Alamofire.request(endpoint, parameters: parameters).validate().responseJSON { (response) in
            
            switch response.result {
                
            case .success(let json):
                
                let json = JSON(json)
                var books: [Ebook] = []
                
                for bookJSON in json["results"].arrayValue  {
                    books.append(Ebook(from: bookJSON))
                }
                
                completion(books)
                
            case .failure(let error):
                print("[Network] Error:", error)
                completion([])
                
            }
            
        }
        
        
    }
    
    
    
    
}


