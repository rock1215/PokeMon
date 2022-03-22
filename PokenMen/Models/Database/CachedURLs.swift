//
//  CachedURLs.swift
//  PokeMon
//
//  Created by Yansong Wang on 2022/3/22.
//

import RealmSwift

class CachedURLs: Object {
    @objc dynamic var id = -1    
    @objc dynamic var url = ""
    
    override class func primaryKey() -> String? {
        "id"
    }
    
    func IncrementaID() -> Int{
        let realm = Utils.Realmshared()
        if let retNext = realm.objects(CachedURLs.self).sorted(byKeyPath: "id").last?.id {
            return retNext + 1
        }else{
            return 1
        }
    }
    
    class func add(url: String) {
        let data = CachedURLs()
        
        data.id = data.IncrementaID()
        data.url = url
        
        let realm = Utils.Realmshared()
        let result = realm.objects(CachedURLs.self).filter("url = %@", url)
        if result.count == 0 {
            try! realm.write {
                realm.add(data)
            }
        }
    }
    
    class func check(url: String) -> Bool {
        let realm = Utils.Realmshared()
        
        let results = realm.objects(CachedURLs.self).filter("url = %@", url)
        print(results.count)
        
        return results.count > 0
    }
    
    class func deleteAll() {
        let realm = Utils.Realmshared()
        
        let results = realm.objects(CachedURLs.self)
        
        try! realm.write {
            realm.delete(results)
        }
    }
}
