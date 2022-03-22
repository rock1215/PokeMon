//
//  PokeMonData.swift
//  PokeMon
//
//  Created by Yansong Wang on 2022/3/22.
//

import RealmSwift

class PokeMonData: Object {
    @objc dynamic var id = -1
    @objc dynamic var name = ""
    @objc dynamic var url = ""
    @objc dynamic var cachedURL = ""
    
    override class func primaryKey() -> String? {
        "id"
    }
    
    func IncrementaID() -> Int{
        let realm = Utils.Realmshared()
        if let retNext = realm.objects(PokeMonData.self).sorted(byKeyPath: "id").last?.id {
            return retNext + 1
        }else{
            return 1
        }
    }
    
    class func add(pokeMon: PokeMon, url: String) {
        let data = PokeMonData()
        data.id = data.IncrementaID()
        data.name = pokeMon.name ?? "unkown"
        data.url = pokeMon.url ?? API_HOME
        data.cachedURL = url
        
        let realm = Utils.Realmshared()
        let result = realm.objects(PokeMonData.self).filter("url = %@", data.url)
        if result.count == 0 {
            try! realm.write {
                realm.add(data)
            }
        }
    }
    
    class func get(url: String) -> [PokeMon] {
        var pokemons: [PokeMon] = []
        
        let realm = Utils.Realmshared()
        let results = realm.objects(PokeMonData.self).filter("cachedURL = %@", url)
        
        for result in results {
            pokemons.append(PokeMon(result))
        }
        
        return pokemons
    }
    
    class func delete(url: String) {
        let realm = Utils.Realmshared()
        
        let results = realm.objects(PokeMonData.self).filter("cachedURL = %@", url)
        
        try! realm.write {
            realm.delete(results)
        }
    }
}
