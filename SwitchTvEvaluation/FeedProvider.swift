//
//  FeedProvider.swift
//  SwitchTvEvaluation
//
//  Created by Aaron Bonham on 20/11/17.
//  Copyright © 2017 Aaron Bonham. All rights reserved.
//

import Foundation

class FeedProvider {
    static let sharedInstance = FeedProvider()
    
    private var jsonData: Data? {
        didSet {

            // Using the Array<ContentCategory> decoder since the JSON array doesn't have a
            // name to use with CodingKeys of ContentFeed
            if let feedArray = try? JSONDecoder().decode(Array<ContentCategory>.self, from: jsonData!) {
                
                // Feed currently has movies first, if featured should be first, api needs display order
                // or could use sortedBy() on the array
                self.feed = ContentFeed(categories: feedArray)
                NotificationCenter.default.post(name: .feedRefreshSuccessful, object: nil)
            }
        }
    }
    
    private(set) var feed = ContentFeed()
    
    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleDataRefresh), name: .feedFetchSuccessful, object: nil)
        NotificationCenter.default.post(name: .requestFeedRefresh, object: nil)
    }
    
    @objc func handleDataRefresh(notification: Notification) {
        if let data = notification.userInfo?[NetworkProdiverKey.newData] as? Data {
            jsonData = data
        }
    }
}
