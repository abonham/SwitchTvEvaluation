//
//  SwitchTvEvaluationTests.swift
//  SwitchTvEvaluationTests
//
//  Created by Aaron Bonham on 20/11/17.
//  Copyright © 2017 Aaron Bonham. All rights reserved.
//

import XCTest
@testable import SwitchTvEvaluation

class SwitchTvEvaluationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testWellFormedJsonFeed() {
        let json = try! Data(contentsOf: Bundle(for: SwitchTvEvaluationTests.self).url(forResource: "testWellFormedFeed", withExtension: "json")!)
        let feedArray = try! JSONDecoder().decode(Array<ContentCategory>.self, from: json)
        let sut = ContentFeed(categories: feedArray)
        assert(sut.categories.count == 3)
        assert(sut.categories[0].items?.count == 12)
        assert(sut.categories[0].items![0].title == "Wonder Woman")
    }
    
    func testItemMissingData() {
        let json = try! Data(contentsOf: Bundle(for: SwitchTvEvaluationTests.self).url(forResource: "testMalformedItem", withExtension: "json")!)
        let sut = try! JSONDecoder().decode(ContentItem.self, from: json)
        assert(sut.title == "Wonder Woman")
        assert(sut.year == nil)
    }
}
