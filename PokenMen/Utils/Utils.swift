//
//  Utils.swift
//  PokenMon
//
//  Created by Yansong Wang on 2022/3/22.
//

import UIKit
import AlamofireImage
import Alamofire
import RealmSwift

class Utils: NSObject {
    class func setTimeout(_ delay: TimeInterval, block:@escaping () -> Void) {
        Timer.scheduledTimer(timeInterval: delay, target: BlockOperation(block: block), selector: #selector(Operation.main), userInfo: nil, repeats: false)
    }
    
    static func Realmshared() -> Realm {
        do {
            let realm = try Realm()
            return realm
        } catch _ as NSError {
            // uncomment and handle new properties here
            let configuration = Realm.Configuration(
                schemaVersion: 1,
                migrationBlock: { _, _ in
                })
            
            Realm.Configuration.defaultConfiguration = configuration
            return try! Realm()
        }
    }
    
    class func checkCached() -> Bool {
        let date = Date()
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        let dateString = dateFormatter.string(from: date)
        
        return dateString != UserDefault.string(forKey: KEY_API_DATE)
    }
    
    class func saveCheckPoint() {
        let date = Date()
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        let dateString = dateFormatter.string(from: date)
        UserDefault.set(dateString, forKey: KEY_API_DATE)
        
        UserDefault.set(0, forKey: KEY_COUNT_CALL)
    }
    
    class func checkAPIAvailable() -> Bool {
        return UserDefault.integer(forKey: KEY_COUNT_CALL) <= 300
    }
    
    class func countUpApiCalls() {
        UserDefault.set(UserDefault.integer(forKey: KEY_COUNT_CALL) + 1, forKey: KEY_COUNT_CALL)
    }
    
    class func setTotalCount(count: Int) {
        UserDefault.set(count, forKey: KEY_TOTAL_COUNT)
    }
    
    class func getTotalCount() -> Int {
        return UserDefault.integer(forKey: KEY_TOTAL_COUNT)
    }
}

extension UIView {
    func removeAllSubViews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
}

extension UIImageView {
    public func setImage(url: URL?, duration: TimeInterval) {
        let appDelegate:AppDelegate  = UIApplication.shared.delegate as! AppDelegate
        let imageCache = appDelegate.imageCache
        let urlStr = url!.absoluteString
        if let cachedImage = imageCache.image(withIdentifier: urlStr){
            self.image = cachedImage
        } else {
            AF.request(url!).responseImage(completionHandler: { (response) in
                if case .success(let image) = response.result {
                    self.alpha = 0
                    self.image = image
                    imageCache.add(self.image!, withIdentifier: urlStr)
                    UIView.animate(withDuration: duration, animations: {
                        self.alpha = 1
                    })
                }
            })
        }
    }
}

extension String {
    func dicValue() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    return json
                }
            } catch {
                return nil
            }
        }
        return nil
    }
    func arrValue() -> [[String: Any]]? {
        if let data = self.data(using: .utf8) {
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    return json
                }
            } catch {
                return nil
            }
        }
        return nil
    }
}

extension Dictionary {
    func jsonString() -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
            
            return String(data: jsonData, encoding: .utf8)
        } catch {
            return nil
        }
    }
}

extension Array {
    func jsonString() -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
            
            return String(data: jsonData, encoding: .utf8)
        } catch {
            return nil
        }
    }
}
