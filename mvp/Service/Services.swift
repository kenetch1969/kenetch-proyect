//
//  Services.swift
//  mvp
//
//  Created by Juan Gerardo Cruz on 11/27/18.
//  Copyright © 2018 Juan Gerardo Cruz. All rights reserved.
//

import Foundation

class Services {
    
    func getCountry(with name: String, callBack: @escaping ([Country]) -> Void ){
        callBack(readAndParseObjectsFromJSONFile(with: name ) as! [Country])
    }
    
    func getCountryUrl (name:String, completionHandler: @escaping ([Country]?, Error?) -> Void) {
        readAndParseObjectsFromJSONUrl(countryName: name) { country, error in
            completionHandler(country,error)
        }
    }
    
    func readAndParseObjectsFromJSONFile(with name: String) -> Decodable? {
        guard let path = Bundle.main.path(forResource: name, ofType: "json") else { return nil }
        do {
            let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe) as Data
            do {
                let decodedObject = try JSONDecoder().decode([Country].self, from: jsonData)
                return decodedObject
            } catch let error {
                print("Error occurred while trying to convert JSON data into Swift types \(error.localizedDescription)")
            }
        } catch let error {
            print("Error occurred while trying to read contents of file \(name) with error \(error.localizedDescription)")
        }
        /// Simply return a nil value when unpleasant situation is encountered.
        return nil
    }
    
    // add userCompletionHandler and remove ' -> Country?' to make it a void function
    func readAndParseObjectsFromJSONUrl(countryName: String, userCompletionHandler: @escaping ([Country]?, Error?) -> Void) {
        var urlContry:String
        
        if countryName == "all" {
            urlContry = "https://restcountries.eu/rest/v2/all"
        }else{
            urlContry = "https://restcountries.eu/rest/v2/name/\(countryName)"
        }
        
        let url = URL(string: urlContry)!
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            
            guard let data = data else { return }
            do {
                // parse json data and return it
                let decoder = JSONDecoder()
                //decoder.keyDecodingStrategy = .convertFromSnakeCase
                let jsonDict = try decoder.decode([Country].self, from: data)
                //if let userData = jsonDict["data"] {
                //    userCompletionHandler(userData, nil)
                //}
                userCompletionHandler(jsonDict,nil)
            } catch let parseErr {
                print("JSON Parsing Error", parseErr)
                userCompletionHandler(nil, parseErr)
            }
        })
        
        task.resume()
        // function will end here and return
        // then after receiving HTTP response, the completionHandler will be called
    }
    
    //MARK: — Utilizando [Any], [String:Any]
    
    func ReadJsonArrayData0 (file:String) -> [Any] {
        var jsonResult: Any?
        if let path = Bundle.main.path(forResource: file, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                
                return jsonResult as![Any]
            } catch {
                // handle error
            }
        }
        return [Any]()
    }
    
    func ReadJsonDictData0 () -> [String: Any] {
        var jsonResult: Any?
        if let path = Bundle.main.path(forResource: "data0", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                
                return jsonResult as! [String : Any]
            } catch {
                // handle error
            }
        }
        return [String : Any]()
    }
    
    //MARK: — Utilizando Codable
    
    func fetchResultsFromApi() {
        struct MyGitHub: Codable {
            
            let name: String?
            let location: String?
            let followers: Int?
            let avatarUrl: URL?
            let repos: Int?
            
            private enum CodingKeys: String, CodingKey {
                case name
                case location
                case followers
                case repos = "public_repos"
                case avatarUrl = "avatar_url"
                
            }
        }
        guard let gitUrl = URL(string: "https://api.github.com/users/kobeumut") else { return }
        URLSession.shared.dataTask(with: gitUrl) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let gitData = try decoder.decode(MyGitHub.self, from: data)
                print(gitData.name ?? "Empty Name")
                
            } catch let err {
                print("Err", err)
            }
            }.resume()
    }
    
    // add userCompletionHandler and remove ' -> User?' to make it a void function
    func fetchUser(userID: Int, userCompletionHandler: @escaping (User?, Error?) -> Void) {
        let url = URL(string: "https://reqres.in/api/users/\(userID)")!
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            
            guard let data = data else { return }
            do {
                // parse json data and return it
                let decoder = JSONDecoder()
                let jsonDict = try decoder.decode(User.self, from: data)
                userCompletionHandler(jsonDict,nil)
            } catch let parseErr {
                print("JSON Parsing Error", parseErr)
                userCompletionHandler(nil, parseErr)
            }
        })
        
        task.resume()
        // function will end here and return
        // then after receiving HTTP response, the completionHandler will be called
    }
    
//    fetchUser(userID: 2, userCompletionHandler: { user, error in
//
//    if let user = user {
//    print("user first name is : \(user.firstName!)")
//    self.nameLabel.text = user.firstName
//    }
//    })
    


    
}
