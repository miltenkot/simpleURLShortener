//
//  urlShortenerRequestTest.swift
//  new_redy4s
//
//  Created by Bartek Lanczyk on 15.01.2017.
//  Copyright © 2017 miltenkot. All rights reserved.
//

import XCTest
@testable import new_redy4s
class urlShortenerRequestTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    let sampleURL = URL(string: "https://developers.google.com/")!
    
    func testAPIURLBuilding() {
        let request = URLShortenerRequest(APIKey: "foo", URL: sampleURL)
        XCTAssertEqual(request.targetAPIURL, URL(string: "https://www.googleapis.com/urlshortener/v1/url?key=foo"))
    }
    
    func testKeyEscaping() {
        let request = URLShortenerRequest(APIKey: "foo=bar", URL: sampleURL)
        XCTAssertEqual(request.targetAPIURL, URL(string: "https://www.googleapis.com/urlshortener/v1/url?key=foo%3Dbar"))
    }
    
    func testURLRequestBuilding() {
        let request = URLShortenerRequest(APIKey: "foo", URL: sampleURL)
        let body = String(data: request.URLRequest.httpBody!, encoding: String.Encoding.utf8)
        XCTAssertEqual(body, "{\"longUrl\":\"https:\\/\\/developers.google.com\\/\"}")
        XCTAssertEqual(request.URLRequest.httpMethod, "POST")
        XCTAssertEqual(request.URLRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    func testResponseParsing() {
        let request = URLShortenerRequest(APIKey: "foo", URL: sampleURL)
        let sampleResponse = "{\"kind\": \"urlshortener#url\", \"id\": \"http://goo.gl/fbsS\", \"longUrl\": \"http://www.google.com/\" }"
        let sampleResponseData = sampleResponse.data(using: String.Encoding.utf8)!
        XCTAssertEqual(request.parseResponseData(sampleResponseData), URL(string: "http://goo.gl/fbsS")!)
    }
    
}
