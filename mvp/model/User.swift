//
//  User.swift
//  mvp
//
//  Created by Juan Gerardo Cruz on 11/27/18.
//  Copyright © 2018 Juan Gerardo Cruz. All rights reserved.
//

import Foundation

//{"data":{"id":1,"first_name":"George","last_name":"Bluth","avatar":"https://s3.amazonaws.com/uifaces/faces/twitter/calebogden/128.jpg"}}

struct Detail: Codable
{
    var id: Int?
    var firstname: String?
    var lastname: String?
    var avatar: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case firstname = "first_name"
        case lastname = "last_name"
        case avatar
        
    }
}

struct User: Codable{
    var detail:Detail?
    
    init(detail: Detail) {
        self.detail = detail
    }
    
    private enum CodingKeys: String, CodingKey {
        case detail = "data"
    }
    
}
