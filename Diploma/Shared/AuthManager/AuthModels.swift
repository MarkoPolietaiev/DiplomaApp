//
//  AuthModels.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2022-12-29.
//

import Foundation

struct RegisterRequestModel: Encodable {
    var email: String
    var password: String
    var name: String
}

struct RegisterResponseModel: Decodable {
    var email: String
    var name: String
}

struct SignInRequestModel: Encodable {
    var email: String
    var password: String
}

struct SignInResponseModel: Decodable {
    var token: String
}
