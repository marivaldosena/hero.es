//
//  ComicsListViewModel.swift
//  
//
//  Created by Marivaldo Sena on 01/01/21.
//

import XCTest
@testable import hero_es

// MARK: - ComicsListViewModelTests: XCTestCase
class ComicsListViewModel_Tests: XCTestCase {
    var modelsArray: [ComicModel] = []
    var viewModel: ComicsListViewModel? = nil
    var controller: ComicsListViewController? = nil
    var service = MockComicService()
    
    override func setUp() {
        viewModel = ComicsListViewModel(with: service)
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
        
        modelsArray = viewModel?.getItems() ?? []
        
        arrayCount = modelsArray.count
        fromViewModel = viewModel?.getNumberOfItems() ?? 0
        
        XCTAssertEqual(
            arrayCount,
            fromViewModel,
            "There are a mismatch between number of items in array and viewModel."
        )
    }
    
    func testGetItemAt() {
        modelsArray = viewModel?.getItems() ?? []
        let fromModel = modelsArray[2].name
        let fromViewModel = viewModel?.getItem(at: 2)?.name ?? ""
        
        XCTAssertEqual(fromModel, fromViewModel, "There is something wrong with get item test.")
    }
}
