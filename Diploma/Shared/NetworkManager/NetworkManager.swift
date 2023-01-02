//
//  NetworkManager.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2021-05-26.
//

import Foundation

class NetworkManager {
    
    let baseUrl: String = "http://ec2-13-56-254-152.us-west-1.compute.amazonaws.com/"
    
    enum Endpoint: String {
        case me = "api/user/me/"
        case postings = "api/posting/postings/"
    }
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private static let sharedInstance: NetworkManager = {
        let instanse = NetworkManager()
        return instanse
    }()
    
    static func shared() -> NetworkManager {
        return sharedInstance
    }
}

// MARK: Public methods
extension NetworkManager {
    func getMe(completion: @escaping ((UserProfile?, Error?) -> Void)) {
        guard var request = self.getRequestWithToken(for: Endpoint.me.rawValue) else {return}
        request.httpMethod = "GET" //set http method as GET
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
                return
            }
            do {
                //create json object from data
                let json = try self.decoder.decode(UserProfile.self, from: data)
                completion(json, nil)
            } catch let error {
                completion(nil, error)
            }
        })
        task.resume()
    }
    
    func updateUser(email: String?, password: String?, name: String?, completion: @escaping ((UserProfile?, Error?) -> Void)) {
        guard var request = self.getRequestWithToken(for: Endpoint.me.rawValue) else {return}
        request.httpMethod = "PATCH" //set http method as PATCH
        var parameters: [String: String] = [:]
        if let email = email {
            parameters["email"] = email
        }
        if let password = password {
            parameters["password"] = password
        }
        if let name = name {
            parameters["name"] = name
        }
        guard let postData = (try? JSONSerialization.data(withJSONObject: parameters, options: [])) else {return}
        request.httpBody = postData
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
                return
            }
            do {
                //create json object from data
                let json = try self.decoder.decode(UserProfile.self, from: data)
                completion(json, nil)
            } catch let error {
                completion(nil, error)
            }
        })
        task.resume()
    }
    
    func createPosting(posting: Posting, completion: @escaping ((Posting?, Error?) -> Void)) {
        guard var request = self.getRequestWithToken(for: Endpoint.postings.rawValue) else {return}
        request.httpMethod = "POST"
        guard let postData = try? encoder.encode(posting) else {return}
        request.httpBody = postData
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
                return
            }
            
            //create json object from data
            do {
               // process data
                let json = try self.decoder.decode(Posting.self, from: data)
                completion(json, nil)
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        })
        task.resume()
    }
    
    func getPostings(completion: @escaping (([Posting]?, Error?) -> Void)) {
        guard var request = self.getRequestWithToken(for: Endpoint.postings.rawValue) else {return}
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
                return
            }
            do {
               // process data
                let json = try self.decoder.decode([Posting].self, from: data)
                completion(json, nil)
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        })
        task.resume()
    }
    
    func deletePosting(id: Int, completion: @escaping ((Error?) -> Void)) -> Void {
        guard var request = self.getRequestWithToken(for: Endpoint.postings.rawValue + "\(id)/") else {return}
        request.httpMethod = "DELETE"
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                completion(error)
                return
            }
            completion(nil)
        })
        task.resume()
    }
    
    func updatePosting(id: Int, posting: Posting, completion: @escaping ((Posting?, Error?) -> Void)) {
        guard var request = self.getRequestWithToken(for: Endpoint.postings.rawValue + "\(id)/") else {return}
        request.httpMethod = "PUT"
        guard let postData = try? encoder.encode(posting) else {return}
        request.httpBody = postData
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
                return
            }
            
            //create json object from data
            do {
               // process data
                let json = try self.decoder.decode(Posting.self, from: data)
                completion(json, nil)
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        })
        task.resume()
    }
}

// MARK: Private methods
private extension NetworkManager {
    func getRequestWithToken(for endpoint: String) -> URLRequest? {
        guard let url = URL(string: baseUrl + endpoint) else {return nil}
        guard let token = UserData.authToken else {return nil}
        //now create the Request object using the url object
        var request = URLRequest(url: url)
        //HTTP Headers
        request.addValue("Token \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        //create dataTask using the session object to send data to the server
        return request
    }
}
