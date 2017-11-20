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

extension PreviewImage {
    func imageUrl(for orientation: ContentOrientation) -> URL? {
        switch orientation {
        case .landscape:
            if let urlString = landscape {
                return URL(string: urlString)
            }
        case .portrait:
            if let urlString = portrait {
                return URL(string: urlString)
            }
        }
        return nil
    }
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
