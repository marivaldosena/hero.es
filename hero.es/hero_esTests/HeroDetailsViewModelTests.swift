//
//  HeroDetailsViewModelTests.swift
//  hero_esTests
//
//  Created by Marivaldo Sena on 27/12/20.
//

import XCTest
@testable import hero_es

class HeroDetailsViewModelTests: XCTestCase {
    var viewModel: HeroDetailsViewModel? = nil
    let modelsArray = [
        HeroModel(
            id: 1011334,
            name: "3-D Man",
            description: "",
            modified: "2020-12-26T16:38:08.6-03:00",
            thumbnail: ThumbnailModel(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", ext: "jpg"),
            resourceURI: "http://gateway.marvel.com/v1/public/characters/1011334",
            numberOfComics: 3,
            relatedComics: [
                RelatedComicModel(
                    id: 21366,
                    name: "Avengers: The Initiative (2007) #14",
                    resourceURI: "http://gateway.marvel.com/v1/public/comics/21366"
                ),
                RelatedComicModel(
                    id: 24571,
                    name: "Avengers: The Initiative (2007) #14 (SPOTLIGHT VARIANT)",
                    resourceURI: "http://gateway.marvel.com/v1/public/comics/24571"
                ),
                RelatedComicModel(
                    id: 21546,
                    name: "Avengers: The Initiative (2007) #15",
                    resourceURI: "http://gateway.marvel.com/v1/public/comics/21546"
                )
            ]
        ),
        HeroModel(
            id: 1017100,
            name: "A-Bomb (HAS)",
            description: "Rick Jones has been Hulk\'s best bud since day one, but now he\'s more than a friend...he\'s a teammate! Transformed by a Gamma energy explosion, A-Bomb\'s thick, armored skin is just as strong and powerful as it is blue. And when he curls into action, he uses it like a giant bowling ball of destruction! ",
            modified: "2020-12-26T16:38:08.6-03:00",
            thumbnail: ThumbnailModel(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", ext: "jpg"),
            resourceURI: "http://gateway.marvel.com/v1/public/characters/1017100",
            numberOfComics: 1,
            relatedComics: [
                RelatedComicModel(
                    id: 40632,
                    name: "Hulk (2008) #53",
                    resourceURI: "http://gateway.marvel.com/v1/public/comics/40632"
                )
            ]
        ),
        HeroModel(
            id: 1009144,
            name: "A.I.M.",
            description: "AIM is a terrorist organization bent on destroying the world.",
            modified: "2020-12-26T16:38:08.6-03:00",
            thumbnail: ThumbnailModel(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec", ext: "jpg"),
            resourceURI: "http://gateway.marvel.com/v1/public/characters/1009144",
            numberOfComics: 2,
            relatedComics: [
                RelatedComicModel(
                    id: 36763,
                    name: "Ant-Man & the Wasp (2010) #3",
                    resourceURI: "http://gateway.marvel.com/v1/public/comics/36763"
                ),
                RelatedComicModel(
                    id: 17553,
                    name: "Avengers (1998) #67",
                    resourceURI: "http://gateway.marvel.com/v1/public/comics/17553"
                )
            ]
        ),
        HeroModel(
            id: 1010699,
            name: "Aaron Stack",
            description: "",
            modified: "2020-12-26T16:38:08.7-03:00",
            thumbnail: ThumbnailModel(path: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available", ext: "jpg"),
            resourceURI: "http://gateway.marvel.com/v1/public/characters/1010699",
            numberOfComics: 1,
            relatedComics: [
                RelatedComicModel(
                    id: 40776,
                    name: "Dark Avengers (2012) #177",
                    resourceURI: "http://gateway.marvel.com/v1/public/comics/40776"
                )
            ]
        ),
        HeroModel(
            id: 1009146,
            name: "Abomination (Emil Blonsky)",
            description: "Formerly known as Emil Blonsky, a spy of Soviet Yugoslavian origin working for the KGB, the Abomination gained his powers after receiving a dose of gamma radiation similar to that which transformed Bruce Banner into the incredible Hulk.",
            modified: "2020-12-26T16:38:08.7-03:00",
            thumbnail: ThumbnailModel(path: "http://i.annihil.us/u/prod/marvel/i/mg/9/50/4ce18691cbf04", ext: "jpg"),
            resourceURI: "http://gateway.marvel.com/v1/public/characters/1009146",
            numberOfComics: 0,
            relatedComics: []
        )
    ]
    
    var model: HeroModel? = nil
    var i = 0
    
    override func setUp() {
        super.setUp()
        
        while i < modelsArray.count - 1 {
            model = modelsArray[i]
            viewModel = HeroDetailsViewModel(with: model)
            i += 1
        }
    }

    override func tearDown() {
        model = nil
        viewModel = nil
    }

    func testHeroName() {
        XCTAssertEqual(model?.name, viewModel?.getName(), "Model and ViewModel.getName() don't match.")
    }
    
    func testHeroDescription() {
        XCTAssertEqual(model?.description, viewModel?.getDescription(false), "Model and ViewModel.getDescription() don't match.")
    }
    
    func testNumberOfRelatedComics() {
        let fromModel = model?.numberOfComics
        let fromViewModel = viewModel?.getNumberOfComics()
        
        XCTAssertEqual(fromModel, model?.relatedComics.count, "Model.numberOfComics and relatedComics are divergent.")
        XCTAssertEqual(fromModel, fromViewModel, "There is a mismatch between Model.numberOfComics and viewModel.getNumberOfComics()")
    }
    
    func testHeroRelatedComics() {
        let comicNameFromModel = model?.relatedComics[0].name
        let comicNameFromViewModel = viewModel?.getRelatedComics()[0].name

        XCTAssertEqual(comicNameFromModel, comicNameFromViewModel, "There are a dissonance between model.relatedComics and viewModel.getRelatedComics()")
    }

    func testImageUrl() {
        XCTAssertEqual(model?.thumbnail.url, viewModel?.getImageUrl(), "Image Url from model and viewModel are divergent.")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
