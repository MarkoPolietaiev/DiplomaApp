//
//  NetworkManager.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2021-05-26.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let baseURL: String = "http://localhost:8080"
    static var authToken: String?
    
}

// MARK: Public methods
extension NetworkManager {
    func signIn(email: String, password: String) {
        let headers = HTTPHeaders(["Email": email, "Password": password])
        AF.request(NetworkManager.baseURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers, interceptor: nil, requestModifier: nil).validate().responseJSON { response in
            switch response.result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let value):
                print(value)
            }
        }
    }
    
    func signUp(email: String, password: String) {
        
    }
}

// MARK: Private methods
private extension NetworkManager {
    
}

// MARK: Singleton shared instance
extension NetworkManager {
    private static let sharedInstance: NetworkManager = {
        let instanse = NetworkManager()
        return instanse
    }()
    
    static func shared() -> NetworkManager {
        return sharedInstance
    }
}
