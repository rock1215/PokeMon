//
//  PokeMonDetail.swift
//  PokeMon
//
//  Created by Yansong Wang on 2022/3/22.
//

import UIKit

class PokeMonDetail: NSObject {
    let height: Int?
    let weight: Int?
    let id: Int?
    let name: String?
    let exp: Int?
    var abilities = ""
    var forms = ""
    var gameIndices = ""
    var held_items = ""
    var moves = ""
    var species = ""
    var sprites = ""
    var stats = ""
    var types = ""
    
    override init() {
        self.height = 0
        self.weight = 0
        self.id = 0
        self.name = ""
        self.exp = 0
    }
    
    init(_ data: [String: Any]) {
        if let height = data["height"] as? Int {
            self.height = height
        } else {
            self.height = 0
        }
        
        if let weight = data["weight"] as? Int {
            self.weight = weight
        } else {
            self.weight = 0
        }
        
        if let name = data["name"] as? String {
            self.name = name
        } else {
            self.name = ""
        }
        
        if let id = data["id"] as? Int {
            self.id = id
        } else {
            self.id = 0
        }
        
        if let exp = data["base_experience"] as? Int {
            self.exp = exp
        } else {
            self.exp = 0
        }
        
        if let abilities = data["abilities"] as? [[String: Any]] {
            self.abilities = abilities.jsonString() ?? ""
        } else {
            self.abilities = ""
        }
        
        if let forms = data["forms"] as? [[String: Any]] {
            self.forms = forms.jsonString() ?? ""
        } else {
            self.forms = ""
        }
        
        if let gameIndices = data["game_indices"] as? [[String: Any]] {
            self.gameIndices = gameIndices.jsonString() ?? ""
        } else {
            self.gameIndices = ""
        }
        
        if let held_items = data["held_items"] as? [[String: Any]] {
            self.held_items = held_items.jsonString() ?? ""
        } else {
            self.held_items = ""
        }
        
        if let moves = data["moves"] as? [[String: Any]] {
            self.moves = moves.jsonString() ?? ""
        } else {
            self.moves = ""
        }
        
        if let species = data["species"] as? [[String: Any]] {
            self.species = species.jsonString() ?? ""
        } else {
            self.species = ""
        }
        
        if let sprites = data["sprites"] as? [[String: Any]] {
            self.sprites = sprites.jsonString() ?? ""
        } else {
            self.sprites = ""
        }
        
        if let stats = data["stats"] as? [[String: Any]] {
            self.stats = stats.jsonString() ?? ""
        } else {
            self.stats = ""
        }
        
        if let types = data["types"] as? [[String: Any]] {
            self.types = types.jsonString() ?? ""
        } else {
            self.types = ""
        }
    }
    
    init(_ data: PokeMonDetailData) {
        self.height = data.height
        self.weight = data.weight
        self.id = data.poke_id
        self.name = data.name
        self.exp = data.exp
        self.abilities = data.abilities
        self.forms = data.forms
        self.gameIndices = data.gameIndices
        self.held_items = data.held_items
        self.moves = data.moves
        self.species = data.species
        self.sprites = data.sprites
        self.types = data.types
        self.stats = data.stats
    }
    
    func getAbilites() -> [String] {
        guard let abilityArray = self.abilities.arrValue() else {
            return []
        }
        
        var results: [String] = []
        
        for ability in abilityArray {
            if let data = ability["ability"] as? [String: Any], let ab_name = data["name"] as? String {
                results.append(ab_name)
            }
        }
        
        return results
    }
    
    func getForms() -> [String] {
        guard let formsArray = self.forms.arrValue() else {
            return []
        }
        
        var results: [String] = []
        
        for form in formsArray {
            if let ab_name = form["name"] as? String {
                results.append(ab_name)
            }
        }
        
        return results
    }
    
    func getGameIndices() -> [String] {
        guard let gameIndexArray = self.gameIndices.arrValue() else {
            return []
        }
        
        var results: [String] = []
        
        for gameIndex in gameIndexArray {
            if let data = gameIndex["version"] as? [String: Any], let ab_name = data["name"] as? String {
                results.append(ab_name)
            }
        }
        
        return results
    }
    
    func getHeldItems() -> [String] {
        guard let heldItemArray = self.held_items.arrValue() else {
            return []
        }
        
        var results: [String] = []
        
        for item in heldItemArray {
            if let data = item["item"] as? [String: Any], let ab_name = data["name"] as? String {
                results.append(ab_name)
            }
        }
        
        return results
    }
    
    func getMoves() -> [String] {
        guard let moveArray = self.moves.arrValue() else {
            return []
        }
        
        var results: [String] = []
        
        for move in moveArray {
            if let data = move["move"] as? [String: Any], let ab_name = data["name"] as? String {
                results.append(ab_name)
            }
        }
        
        return results
    }
    
    func getSpecies() -> [String] {
        guard let specDic = self.species.dicValue() else {
            return []
        }
        
        var results: [String] = []
        
        if let ab_name = specDic["name"] as? String {
            results.append(ab_name)
        }
        
        return results
    }
    
    func getSprites() -> [String] {
//        guard let spriteDic = self.sprites.dicValue() else {
//            return []
//        }
//
//        var results: [String] = []
//
//        if let ab_name = spriteDic["name"] as? String {
//            results.append(ab_name)
//        }
        // Test Sprites
        return ["Spider"]
    }
    
    func getStats() -> [String] {
        guard let statArray = self.stats.arrValue() else {
            return []
        }
        
        var results: [String] = []
        
        for stat in statArray {
            if let data = stat["stat"] as? [String: Any], let ab_name = data["name"] as? String {
                results.append(ab_name)
            }
        }
        
        return results
    }
    
    func getTypes() -> [String] {
        guard let typeArray = self.types.arrValue() else {
            return []
        }
        
        var results: [String] = []
        
        for type in typeArray {
            if let data = type["type"] as? [String: Any], let ab_name = data["name"] as? String {
                results.append(ab_name)
            }
        }
        
        return results
    }
}
