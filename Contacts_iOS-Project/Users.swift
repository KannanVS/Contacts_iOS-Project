//
//  Users.swift
//  Contacts_iOS-Project
//
//  Created by Kakashi on 17/07/2019.
//  Copyright © 2019 Kannan. All rights reserved.
//

import Foundation

struct UserBase: Codable {
    let results: [RandomUser]
}

struct RandomUser: Codable{
    let name: UserName
    let email: String
    let picture: Pictures
    let phone: String
    let cell: String
    let location: loc
}

struct UserName: Codable{
    let title: String
    let first: String
    let last: String
}

struct Pictures: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}


struct loc: Codable {
    let street: String
    let city: String
}
