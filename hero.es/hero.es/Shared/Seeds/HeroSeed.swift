//
//  Seed.swift
//  hero.es
//
//  Created by Marivaldo Sena on 22/10/20.
//

import Foundation

struct HeroSeed: SeedProtocol {
    typealias Item = Hero
    private static var collection: [Item] = [
        Hero(id: 1011334, name: "3-D Man", resourceURI: "http://gateway.marvel.com/v1/public/characters/1011334", imageName: "HeroImage", description: "", numberOfComics: 12),
        Hero(id: 1017100, name: "A-Bomb (HAS)", resourceURI: "http://gateway.marvel.com/v1/public/characters/1017100", imageName: "HeroImage", description: "Rick Jones has been Hulk's best bud since day one, but now he's more than a friend...he's a teammate! Transformed by a Gamma energy explosion, A-Bomb's thick, armored skin is just as strong and powerful as it is blue. And when he curls into action, he uses it like a giant bowling ball of destruction! ", numberOfComics: 3),
        Hero(id: 1009144, name: "A.I.M.", resourceURI: "http://gateway.marvel.com/v1/public/characters/1009144", imageName: "HeroImage", description: "AIM is a terrorist organization bent on destroying the world.", numberOfComics: 49),
        Hero(id: 1010699, name: "Aaron Stack", resourceURI: "http://gateway.marvel.com/v1/public/characters/1010699", imageName: "HeroImage", description: "", numberOfComics: 14),
        Hero(id: 1009146, name: "Abomination (Emil Blonsky)", resourceURI: "http://gateway.marvel.com/v1/public/characters/1009146", imageName: "HeroImage", description: "Formerly known as Emil Blonsky, a spy of Soviet Yugoslavian origin working for the KGB, the Abomination gained his powers after receiving a dose of gamma radiation similar to that which transformed Bruce Banner into the incredible Hulk.", numberOfComics: 53),
        Hero(id: 1016823, name: "Abomination (Ultimate)", resourceURI: "http://gateway.marvel.com/v1/public/characters/1016823", imageName: "HeroImage", description: "", numberOfComics: 2),
        Hero(id: 1009148, name: "Absorbing Man", resourceURI: "http://gateway.marvel.com/v1/public/characters/1009148", imageName: "HeroImage", description: "", numberOfComics: 91),
        Hero(id: 1009149, name: "Abyss", resourceURI: "http://gateway.marvel.com/v1/public/characters/1009149", imageName: "HeroImage", description: "", numberOfComics: 8),
        Hero(id: 1010903, name: "Abyss (Age of Apocalypse)", resourceURI: "http://gateway.marvel.com/v1/public/characters/1010903", imageName: "HeroImage", description: "", numberOfComics: 3),
        Hero(id: 1011266, name: "Adam Destine", resourceURI: "http://gateway.marvel.com/v1/public/characters/1011266", imageName: "HeroImage", description: "", numberOfComics: 0),
        Hero(id: 1010354, name: "Adam Warlock", resourceURI: "http://gateway.marvel.com/v1/public/characters/1010354", imageName: "HeroImage", description: "Adam Warlock is an artificially created human who was born in a cocoon at a scientific complex called The Beehive.", numberOfComics: 188),
        Hero(id: 1010846, name: "Aegis (Trey Rollins)", resourceURI: "http://gateway.marvel.com/v1/public/characters/1010846", imageName: "HeroImage", description: "", numberOfComics: 0),
        Hero(id: 1011297, name: "Agent Brand", resourceURI: "http://gateway.marvel.com/v1/public/characters/1011297", imageName: "HeroImage", description: "", numberOfComics: 17),
        Hero(id: 1011031, name: "Agent X (Nijo)", resourceURI: "http://gateway.marvel.com/v1/public/characters/1011031", imageName: "HeroImage", description: "Originally a partner of the mind-altering assassin Black Swan, Nijo spied on Deadpool as part of the Swan's plan to exact revenge for Deadpool falsely taking credit for the Swan's assassination of the Four Winds crime family, which included Nijo's brother.", numberOfComics: 18),
        Hero(id: 1009150, name: "Agent Zero", resourceURI: "http://gateway.marvel.com/v1/public/characters/1009150", imageName: "HeroImage", description: "", numberOfComics: 28),
        Hero(id: 1011198, name: "Agents of Atlas", resourceURI: "http://gateway.marvel.com/v1/public/characters/1011198", imageName: "HeroImage", description: "", numberOfComics: 44),
        Hero(id: 1011175, name: "Aginar", resourceURI: "http://gateway.marvel.com/v1/public/characters/1011175", imageName: "HeroImage", description: "", numberOfComics: 0),
        Hero(id: 1011136, name: "Air-Walker (Gabriel Lan)", resourceURI: "http://gateway.marvel.com/v1/public/characters/1011136", imageName: "HeroImage", description: "", numberOfComics: 4),
        Hero(id: 1011176, name: "Ajak", resourceURI: "http://gateway.marvel.com/v1/public/characters/1011176", imageName: "HeroImage", description: "", numberOfComics: 4),
        Hero(id: 1010870, name: "Ajaxis", resourceURI: "http://gateway.marvel.com/v1/public/characters/1010870", imageName: "HeroImage", description: "", numberOfComics: 0),
    ]
    
    static func seed() -> [Hero] {
        return collection
    }
}
