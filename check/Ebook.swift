//
//  Ebook.swift
//  check
//
//  Created by Nandita Mohan on 5/4/18.
//  Copyright © 2018 Nandita Mohan. All rights reserved.
//

import Foundation

import SwiftyJSON

class Ebook: NSObject {
    
    let name: String
    let author: String
    
    let previewLink: URL?
    
    init(name: String, artist: String, previewLink: URL) {
        self.name = name
        self.author = artist
        self.previewLink = previewLink
    }
    
    init(from json: JSON) {
        self.name = json["trackName"].stringValue
        self.author = json["artistName"].stringValue
        self.previewLink = json["trackViewUrl"].url
    }
    
}


