//
//  ComicsListViewModel.swift
//  
//
//  Created by Marivaldo Sena on 01/01/21.
//

import XCTest
@testable import hero_es

// MARK: - ComicsListViewModelTests: XCTestCase
class ComicsListViewModelTests: XCTestCase {
    var modelsArray: [ComicModel] = []
    var viewModel: ComicsListViewModel? = nil
    var controller: ComicsListViewController? = nil
    var service: ComicServiceProtocol = MockComicService()

    override func setUp() {
        viewModel = ComicsListViewModel()
        viewModel?.service = service
    }

    override func tearDown() {
        modelsArray = []
        viewModel = nil
        controller = nil
    }

    func testLoadItems() {
        var arrayCount = modelsArray.count
        var fromViewModel = viewModel?.getNumberOfItems() ?? 0
        XCTAssertEqual(
            arrayCount,
            fromViewModel,
            "There are a mismatch between number of items in array and viewModel."
        )
        
        modelsArray = viewModel?.getAllItems() ?? []
        
        arrayCount = modelsArray.count
        fromViewModel = viewModel?.getNumberOfItems() ?? 0
        
        XCTAssertEqual(
            arrayCount,
            fromViewModel,
            "There are a mismatch between number of items in array and viewModel."
        )
    }
    
    func testGetItemAt() {
        modelsArray = viewModel?.getAllItems() ?? []
        let fromModel = modelsArray[2].name
        let fromViewModel = viewModel?.getItem(at: 2)?.name ?? ""
        
        XCTAssertEqual(fromModel, fromViewModel, "There is something wrong with get item test.")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

// MARK: - MockComicService: ComicServiceProtocol
class MockComicService: ComicServiceProtocol {
    func loadAllItems(completion: @escaping ComicServiceFinishHandlerType) {
        let modelsArray: [ComicModel] = [
            ComicModel(
                id: 82967,
                name: "Marvel Previews (2017)",
                resourceURI : "http://gateway.marvel.com/v1/public/comics/82967",
                description : "",
                modified : Date(timeIntervalSince1970: TimeInterval(602778932.0)),
                upc: "75960608839302811",
                pageCount : 112,
                thumbnailString : "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg",
                relatedHeroes: []
            ),
            ComicModel(
                id : 82965,
                name : "Marvel Previews (2017)",
                resourceURI : "http://gateway.marvel.com/v1/public/comics/82965",
                description : "",
                modified: Date(timeIntervalSince1970: TimeInterval(588114687.0)),
                upc : "75960608839302611",
                pageCount : 152,
                thumbnailString : "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg",
                relatedHeroes: []
            ),
            ComicModel(
                id : 82970,
                name : "Marvel Previews (2017)",
                resourceURI : "http://gateway.marvel.com/v1/public/comics/82970",
                description : "",
                modified: Date(timeIntervalSince1970: TimeInterval(602778932.0)),
                upc : "75960608839303111",
                pageCount : 112,
                thumbnailString : "http://i.annihil.us/u/prod/marvel/i/mg/c/80/5e3d7536c8ada.jpg",
                relatedHeroes :[]
            ),
            ComicModel(
                id : 1220,
                name : "Amazing Spider-Man 500 Covers Slipcase - Book II (Trade Paperback)",
                resourceURI : "http://gateway.marvel.com/v1/public/comics/1220",
                description : "",
                modified : nil,
                upc : "",
                pageCount : 0,
                thumbnailString : "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg",
                relatedHeroes : []
            ),
            ComicModel(
                id : 1003,
                name : "Sentry, the (Trade Paperback)",
                resourceURI : "http://gateway.marvel.com/v1/public/comics/1003",
                description : "On the edge of alcoholism and a failed marriage, Bob Reynolds wakes up to discover his true nature. A forgotten hero, he must unravel the conspiracy to erase his memory from mankind before an evil entity returns.",
                modified : nil,
                upc : "",
                pageCount : 240,
                thumbnailString : "http://i.annihil.us/u/prod/marvel/i/mg/f/c0/4bc66d78f1bee.jpg",
                relatedHeroes : []
            )
        ]
        
        completion(modelsArray, nil)
    }
}
