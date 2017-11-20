//
//  NetworkProvider.swift
//  SwitchTvEvaluation
//
//  Created by Aaron Bonham on 20/11/17.
//  Copyright © 2017 Aaron Bonham. All rights reserved.
//

import Foundation
import Alamofire

extension Notification.Name {
    static let feedRefreshSuccessful = Notification.Name("feedRefreshSuccessful")
    static let feedFetchSuccessful = Notification.Name("feedReFetchSuccessful")
    static let requestFeedRefresh = Notification.Name("requestFeedRefresh")
    static let feedRefreshFailed = Notification.Name("feedRefreshFailed")
}

enum NetworkProdiverKey: String {
    case newData = "newData"
}

class NetworkProvider {
    static let sharedInstance = NetworkProvider()
    let apiUrl = "https://pastebin.com/raw/8LiEHfwU"
    
    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshFeed), name: .requestFeedRefresh, object: nil)
    }
    
    @objc func refreshFeed() {
        Alamofire.request(apiUrl).response { response in
            guard let data = response.data else {
                NotificationCenter.default.post(name: .feedRefreshFailed, object: response.error)
                return
            }
            NotificationCenter.default.post(name: .feedFetchSuccessful, object: nil, userInfo: [NetworkProdiverKey.newData: data])
        }
    }
}
