//
//  Auth.swift
//  Swifty-Companion
//
//  Created by Colin Schmitt on 24/01/2021.
//

import UIKit
import Alamofire
import SwiftyJSON

class Auth: NSObject {
    var token = String()
    let baseUrl : URL = URL(string: "https://api.intra.42.fr/v2/")!
    let url = "https://api.intra.42.fr/oauth/token"
    let config = [
        "grant_type": "client_credentials",
        "client_id":"0a15c6f04f5a7a00b1e115c634d1aceab19c6281105fbd6c31cc4c4fd3b13a45",
        "client_secret": "ff3e6291e03505f87bc0de632f5c6c9b8fed95c7df90049e60bfd8700ea259e6"
    ]
    
    func getToken(){
        let verify = UserDefaults.standard.object(forKey: token)
        if verify == nil {
            AF.request(url,method: .post,parameters: config).validate().responseJSON{
                response in
                switch response.result{
                case .success:
                    if let value = response.data {
                        let json = JSON(value)
                        self.token = json["access_token"].stringValue
                        UserDefaults.standard.set(self.token,forKey: "token")
                        print("self.token",self.token)
                        self.checkToken()
                    }
                    
                case .failure(let error):
                    print("failure",error)
                    
                }
                
            }
        }else {
            self.token = verify as! String
            print("Token : ",self.token)
            checkToken()
        }
        
    }
    
    private func checkToken(){
        
        let url = URL(string: "https://api.intra.42.fr/oauth/token/info")
        let bearer = "Bearer \(self.token)"
        var request = URLRequest(url:  url!)
        request.httpMethod = "GET"
        request.setValue(bearer, forHTTPHeaderField: "Authorization")
        AF.request(request).validate().responseJSON{
            response in
            
            switch response.result{
            case .success:
                if let data =  response.data {
                    let json = JSON(data)
//                    self.checkUser("coschmit"){
//                        completion in
//                        print(completion)
//                    }
                }
            case .failure:
                print("Error: Trying to get a new token...")
                UserDefaults.standard.removeObject(forKey: "token")
                self.getToken()
            }
            
        }
        
    }
    
    func checkUser(_ user: String,completion: @escaping (JSON?) -> Void){
        let url = baseUrl.appendingPathComponent("/users/\(user)")
        let bearer = "Bearer \(self.token)"
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(bearer,forHTTPHeaderField: "Authorization")
        AF.request(request).validate().responseJSON{
            response in
            switch response.result {
            case .success:
                if let data = response.data {
                    let json = JSON(data)
                    print("success checkUser")
                    completion(json)
                }
            case .failure(let error):
                print("err",error)
                completion(nil)
            }
        }
    }
    
}
