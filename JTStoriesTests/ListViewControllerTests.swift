//
//  ListViewControllerTests.swift
//  JTStoriesTests
//
//  Created by Jeff Tabios on 31/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import XCTest
@testable import JTStories

class ListViewControllerTests: XCTestCase {
    var sut: ListViewController!
    let api = MockAPI()
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: Bundle.main)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        sut = navigationController.topViewController as? ListViewController
        
        UIApplication.shared.keyWindow!.rootViewController = sut
        
        let _ = navigationController.view
        let _ = sut.view
        
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testSUT_HasSearchBar() {
        XCTAssertNotNil(sut.searchBar)
    }

    func testSUT_ShouldSetSearchBarDelegate() {

        XCTAssertNotNil(self.sut.searchBar.delegate)
    }

    func testSUT_ConformsToSearchBarDelegateProtocol() {

        XCTAssert(sut.conforms(to: UISearchBarDelegate.self))
        XCTAssertTrue(self.sut.responds(to: #selector(sut.searchBarTextDidBeginEditing(_:))))

    }
    
    
    func test_searchBarTap_DoesNotShowEmptyTermsList(){
        sut.searchBar.becomeFirstResponder()
        sut.searchBar.text = "jump"
        sut.searchBarTextDidBeginEditing(sut.searchBar)
        
        XCTAssertEqual(sut.terms.count, 0)
        XCTAssertEqual(sut.tableTermsView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(sut.tableTermsView.isHidden, true)
    }
    
    func test_searchBarTap_ThenCancel_HidesTermsList(){
        sut.searchBar.becomeFirstResponder()
        sut.searchBar.text = "jump"
        sut.searchBarTextDidBeginEditing(sut.searchBar)
        
        XCTAssertEqual(sut.terms.count, 0)
        XCTAssertEqual(sut.tableTermsView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(sut.tableTermsView.isHidden, true)
        
        sut.searchBarCancelButtonClicked(sut.searchBar)
        XCTAssertEqual(sut.tableTermsView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(sut.tableTermsView.isHidden, true)
    }
    
    func test_searchButtonTap_ThenQueryAppendsToTermsList(){
        sut.searchBar.becomeFirstResponder()
        sut.searchBar.text = "jump"
        sut.searchBarTextDidBeginEditing(sut.searchBar)
        sut.searchBarSearchButtonClicked(sut.searchBar)
        
        XCTAssertEqual(sut.terms.count, 1)
        
    }
    
    
    func test_searchBarTap_ShowsTermsList(){
        sut.searchBar.becomeFirstResponder()
        sut.terms.append("jump")
        sut.searchBarTextDidBeginEditing(sut.searchBar)
        
        XCTAssertEqual(sut.tableTermsView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(sut.tableTermsView.isHidden, false)
    }
    
    func test_search_ShowsList(){
        sut.searchBar.becomeFirstResponder()
        sut.searchBar.text = "jump"
        sut.searchBarTextDidBeginEditing(sut.searchBar)
        
        XCTAssertEqual(sut.terms.count, 0)
        XCTAssertEqual(sut.tableTermsView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(sut.tableTermsView.isHidden, true)
    }
    
    //Table List
    
    func test_startAndLoadListItems() {
        loadData()
        let indexPath = IndexPath(row: 0, section: 0)
        let tableCell = sut.tableListView.cellForRow(at: indexPath) as! ListCell
        XCTAssertEqual(tableCell.heading.text, "Singapore Seizes Ivory From Nearly 300 Elephants in Record Haul")
    }
    
    
    
    //HELPERS:
    func loadData(){
        let expectation = self.expectation(description: "LoadTest")
        
        api.request(endPoint: StoryAPI.getStories(page: 1,q:""),
                    completion: { [weak self] (result:Result<Stories,APIServiceError>) in
                        switch result{
                        case .success(let stories):
                            self?.sut.vm.lastPageLoaded += 1
                            self?.sut.vm.storyViewModels += stories.response.docs.map{StoryViewModel(story: $0)}
                        case .failure:
                            break
                        }
                        expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        sut.tableListView.reloadData()
    }
}
