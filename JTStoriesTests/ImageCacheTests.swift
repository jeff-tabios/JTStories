//
//  ImageCacheTests.swift
//  JTStoriesTests
//
//  Created by Jeff Tabios on 01/08/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import XCTest
import UIKit
@testable import JTStories

class ImageCacheTests: XCTestCase {

    var sut = UIImageView()
    let imagePath = AppConstants.imgUrl +  "images/2019/04/01/world/01singapore-1/merlin_152920632_816eb94d-089d-4fe5-be33-d05de16f88f9-articleLarge.jpg"
    
    func test_startAndLoadPlaceholder(){
        let url = URL(string: imagePath + "wrong")
        sut.load(url: url, placeholder: UIImage(named: "noposter"))
        XCTAssertEqual(sut.image, UIImage(named: "noposter"))
    }
    
    func test_loadAndCacheImage(){
        
        let url = URL(string: imagePath)
        let urlRequest = URLRequest(url: url!)
        var imageStatus: ImageCachingStatus = ImageCachingStatus.none
        URLCache.shared.removeCachedResponse(for:urlRequest)
        
        let expectation = self.expectation(description: "LoadImageTest")
        sut.load(url: url, placeholder: UIImage(named: "noposter")){ status in
            imageStatus = status
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(imageStatus, ImageCachingStatus.imageCached)
    }
    
    func test_loadAndCacheImage_thenReuseCache(){
        
        let url = URL(string: imagePath)
        let urlRequest = URLRequest(url: url!)
        var imageStatus: ImageCachingStatus = ImageCachingStatus.none
        URLCache.shared.removeCachedResponse(for:urlRequest)
        
        let expectation1 = self.expectation(description: "LoadImageTest")
        sut.load(url: url, placeholder: UIImage(named: "noposter")){ status in
            imageStatus = status
            expectation1.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        
        let expectation2 = self.expectation(description: "ReloadImageTest")
        sut.load(url: url, placeholder: UIImage(named: "noposter")){ status in
            imageStatus = status
            expectation2.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertEqual(imageStatus, ImageCachingStatus.cachedImageUsed)
    }

}
