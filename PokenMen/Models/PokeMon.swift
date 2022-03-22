//
//  PokeMon.swift
//  PokenMon
//
//  Created by Yansong Wang on 2022/3/22.
//

import UIKit

class PokeMon: NSObject {
    let name: String?
    let url: String?
    var id: String?
    
    override init() {
        self.name = ""
        self.url = ""
    }
    
    init(name: String) {
        self.name = name
        self.url = ""
    }
    
    init(url: String) {
        self.url = url
        self.name = ""
    }
    
    init(_ data: [String: Any]) {
        if let name = data["name"] as? String {
            self.name = name
        } else {
            self.name = ""
        }
        
        if let url = data["url"] as? String {
            self.url = url
        } else {
            self.url = ""
        }
    }
    
    init(_ data: PokeMonData) {
        self.name = data.name
        self.url = data.url
    }
    
    func getImageURL() -> URL? {
        if let id = id, id != "" {
            return URL(string: API_IMAGE + "\(id).png")
        }
        
        guard let url = url else {
            return nil
        }
        
        var components = url.components(separatedBy: "/")
        
        var id = ""
        
        while(id == "") {
            id = components[components.count - 1]
            
            components.remove(at: components.count - 1)
        }
        
        if id != "" {
            self.id = id
            return URL(string: API_IMAGE + "\(id).png")
        }
        
        return nil
    }
}
