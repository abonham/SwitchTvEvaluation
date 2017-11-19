//
//  Model.swift
//  SwitchTvEvaluation
//
//  Created by Aaron Bonham on 20/11/17.
//  Copyright © 2017 Aaron Bonham. All rights reserved.
//

import Foundation

struct PreviewImage: Codable {
    var portrait: String?
    var landscape: String?
}

struct ContentItem: Codable {
    var title: String?
    var year: Int?
    var description: String?
    var images: PreviewImage?
}

struct ContentCategory: Codable {
    var category: String?
    var items: [ContentItem]?
}

struct ContentFeed: Codable {
    var categories = [ContentCategory]()
}
