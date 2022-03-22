//
//  PokeMonHandler.swift
//  PokeMon
//
//  Created by Yansong Wang on 2022/3/22.
//

import Alamofire

class PokeMonHandler: NSObject {
    class func getList(url: String, _ success: @escaping (_ results: [PokeMon], _ count: Int) -> Void, _ failure: @escaping (_ errorMessage: String?) -> Void) {
        if Utils.checkCached() {
            Utils.saveCheckPoint()
            CachedURLs.deleteAll()
        } else {
            print(UserDefault.integer(forKey: KEY_COUNT_CALL))
            if !Utils.checkAPIAvailable() {
                failure("Api calls Max Count")
                return
            }
            
            if CachedURLs.check(url: url) && Utils.getTotalCount() > 0 {
                let results = PokeMonData.get(url: url)
                
                if results.count > 0 {
                    success(results, Utils.getTotalCount())
                    return
                }
            }
        }
        
        AF.request(url).response { response in
            switch(response.result) {
            case .success(let value):
                if let data = value {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            Utils.countUpApiCalls()
                            var pokemons: [PokeMon] = []
                            
                            if let results = json["results"] as? [[String: Any]] {
                                PokeMonData.delete(url: url)
                                for result in results {
                                    let pokemon = PokeMon(result)
                                    
                                    PokeMonData.add(pokeMon: pokemon, url: url)
                                    pokemons.append(pokemon)
                                }
                                
                                CachedURLs.add(url: url)
                            }
                            
                            var count = 0
                            
                            if let total = json["count"] as? Int {
                                count = total
                            }
                            
                            Utils.setTotalCount(count: count)
                            
                            success(pokemons, count)
                        } else {
                            failure("Json Data Error")
                        }
                    } catch {
                        failure("Json Parse Error")
                    }
                    
                } else {
                    failure("Empty Data")
                }
                break
            case .failure(_):
                failure("Error Response")
                break
            }
        }
    }
    
    class func getDetail(url: String, _ success: @escaping (_ result: PokeMonDetail) -> Void, _ failure: @escaping (_ errorMessage: String?) -> Void) {
        if Utils.checkCached() {
            Utils.saveCheckPoint()
            CachedURLs.deleteAll()
        } else {
            print(UserDefault.integer(forKey: KEY_COUNT_CALL))
            if !Utils.checkAPIAvailable() {
                failure("Api calls Max Count")
                return
            }
            
            if CachedURLs.check(url: url) {                
                if let detail = PokeMonDetailData.get(url) {
                    success(detail)
                    return
                }
            }
        }
        
        AF.request(url).response { response in
            switch(response.result) {
            case .success(let value):
                if let data = value {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            Utils.countUpApiCalls()
                            
                            let pokeMonDetail = PokeMonDetail(json)
                            
                            PokeMonDetailData.add(pokeMonDetail, url: url)
                            CachedURLs.add(url: url)
                            
                            success(pokeMonDetail)
                        } else {
                            failure("Json Data Error")
                        }
                    } catch {
                        failure("Json Parse Error")
                    }
                    
                } else {
                    failure("Empty Data")
                }
                break
            case .failure(_):
                failure("Error Response")
                break
            }
        }
    }
}
