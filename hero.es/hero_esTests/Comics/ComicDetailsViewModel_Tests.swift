//
//  ComicDetailsViewModel_Tests.swift
//  hero_esTests
//
//  Created by Marivaldo Sena on 05/01/21.
//

import XCTest
@testable import hero_es

class ComicDetailsViewModel_Tests: XCTestCase {
    let model = ComicModel(
        id: 82970,
        name: "Marvel Previews (2017)",
        resourceURI: "http://gateway.marvel.com/v1/public/comics/82970",
        description: "",
        modified: Date(timeIntervalSince1970: TimeInterval(602778932)),
        upc: "75960608839303111",
        pageCount: 112,
        thumbnailString: "http://i.annihil.us/u/prod/marvel/i/mg/c/80/5e3d7536c8ada.jpg",
        numberOfHeroes: 0,
        relatedHeroes: []
    )
    
    var viewModel: ComicDetailsViewModel? = nil
    var controller: ComicDetailsViewController? = nil

    override func setUp() {
        viewModel = ComicDetailsViewModel(with: model)
        controller = ComicDetailsViewController.getController(
            viewModel ?? ComicDetailsViewModel(with: model)
        )
    }

    override func tearDown() {
        viewModel = nil
        controller = nil
    }

    func testGetUpc()  {
        let fromModel = model.upc
        let fromViewModel = viewModel?.getUpc() ?? "viewModel"
        XCTAssertEqual(fromModel,fromViewModel , "Something went wrong with viewModel.getUpc().")
    }
    
    func testGetName() {
        let fromModel = model.name
        let fromViewModel = viewModel?.getName() ?? "viewModel"
        XCTAssertEqual(fromModel, fromViewModel, "Something went wrong with viewModel.getName().")
    }
    
    func testGetPageCount() {
        let fromModel = model.pageCount
        let fromViewModel = viewModel?.getPageCount() ?? 0
        XCTAssertEqual(fromModel, fromViewModel, "Something went wrong with viewModel.getPageCount().")
    }
    
    func testGetImageUrlString() {
        let fromModel = model.thumbnailString
        let fromViewModel = viewModel?.getImageUrlString() ?? "viewModel"
        XCTAssertEqual(fromModel, fromViewModel, "Something went wrong with viewModel.getImageUrlString().")
    }

    func testPerformanceExample()  {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
