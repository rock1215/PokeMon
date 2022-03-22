//
//  PokeMonDetailData.swift
//  PokeMon
//
//  Created by Yansong Wang on 2022/3/22.
//

import RealmSwift

class PokeMonDetailData: Object {
    @objc dynamic var id = -1
    @objc dynamic var height = 0
    @objc dynamic var weight = 0
    @objc dynamic var poke_id = 0
    @objc dynamic var name = ""
    @objc dynamic var exp = 0
    @objc dynamic var abilities = ""
    @objc dynamic var forms = ""
    @objc dynamic var gameIndices = ""
    @objc dynamic var held_items = ""
    @objc dynamic var moves = ""
    @objc dynamic var species = ""
    @objc dynamic var sprites = ""
    @objc dynamic var stats = ""
    @objc dynamic var types = ""
    @objc dynamic var cachedURL = ""
    
    override class func primaryKey() -> String? {
        "id"
    }
    
    func IncrementaID() -> Int{
        let realm = Utils.Realmshared()
        if let retNext = realm.objects(PokeMonDetailData.self).sorted(byKeyPath: "id").last?.id {
            return retNext + 1
        }else{
            return 1
        }
    }
    
    class func add(_ detail: PokeMonDetail, url: String) {
        let data = PokeMonDetailData()
        data.id = data.IncrementaID()
        data.height = detail.height ?? 0
        data.weight = detail.weight ?? 0
        data.poke_id = detail.id ?? 0
        data.name = detail.name ?? "unknown"
        data.exp = detail.exp ?? 0
        data.abilities = detail.abilities
        data.forms = detail.forms
        data.gameIndices = detail.gameIndices
        data.held_items = detail.held_items
        data.moves = detail.moves
        data.species = detail.species
        data.sprites = detail.sprites
        data.types = detail.types
        data.stats = detail.stats
        data.cachedURL = url
        
        let realm = Utils.Realmshared()
        let result = realm.objects(PokeMonDetailData.self).filter("poke_id = %d", data.poke_id)
        if result.count == 0 {
            try! realm.write {
                realm.add(data)
            }
        }
    }
    
    class func get(_ id: Int) -> PokeMonDetail? {
        let realm = Utils.Realmshared()
        let results = realm.objects(PokeMonDetailData.self).filter("poke_id = %d", id)
        
        if results.count > 0 {
            return PokeMonDetail(results[0])
        }
        
        return nil
    }
    
    class func get(_ url: String) -> PokeMonDetail? {
        let realm = Utils.Realmshared()
        let results = realm.objects(PokeMonDetailData.self).filter("cachedURL = %@", url)
        
        if results.count > 0 {
            return PokeMonDetail(results[0])
        }
        
        return nil
    }
}
