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
        case getMe = "api/user/me/"
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
        guard let url = URL(string: baseUrl + Endpoint.getMe.rawValue) else {return}
        guard let token = UserData.authToken else {return}
        let session = URLSession.shared
        //now create the Request object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "GET" //set http method as GET
        
        //HTTP Headers
        request.addValue("Token \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        //create dataTask using the session object to send data to the server
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
}

// MARK: Private methods
private extension NetworkManager {
    
}
