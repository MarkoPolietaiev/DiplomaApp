//
//  NetworkManager.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2021-05-26.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let baseURL: String = "http://ec2-13-56-254-152.us-west-1.compute.amazonaws.com/"
    
    enum Endpoint: String {
        case createPostin = ""
    }
    
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
    
}

// MARK: Private methods
private extension NetworkManager {
    
}
