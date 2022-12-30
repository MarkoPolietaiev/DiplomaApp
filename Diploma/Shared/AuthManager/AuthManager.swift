//
//  AuthManager.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2022-12-29.
//

import Foundation

class AuthManager {
    
    private let baseUrl: String = "http://ec2-13-56-254-152.us-west-1.compute.amazonaws.com/"
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    enum Endpoint: String {
        case register = "api/user/create/"
        case signIn = "api/user/token/"
    }
}

// MARK: Public functions
extension AuthManager {
    func register(email: String, password: String, name: String, completion: @escaping ((RegisterResponseModel?, Error?) -> Void)) {
        guard let url = URL(string: baseUrl + Endpoint.register.rawValue) else {return}
        let requestModel = RegisterRequestModel(email: email, password: password, name: name)
        let session = URLSession.shared
        //now create the Request object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        do {
            request.httpBody = try encoder.encode(requestModel)
        } catch let error {
            completion(nil, error)
        }
        //HTTP Headers
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
                let json = try self.decoder.decode(RegisterResponseModel.self, from: data)
                completion(json, nil)
            } catch let error {
                completion(nil, error)
            }
        })
        task.resume()
    }
    
    func signIn(email: String, password: String, completion: @escaping ((SignInResponseModel?, Error?) -> Void)) {
        guard let url = URL(string: baseUrl + Endpoint.signIn.rawValue) else {return}
        let requestModel = SignInRequestModel(email: email, password: password)
        let session = URLSession.shared
        //now create the Request object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        do {
            request.httpBody = try encoder.encode(requestModel)
        } catch let error {
            completion(nil, error)
        }
        //HTTP Headers
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
                let json = try self.decoder.decode(SignInResponseModel.self, from: data)
                completion(json, nil)
            } catch let error {
                completion(nil, error)
            }
        })
        task.resume()
    }
}
