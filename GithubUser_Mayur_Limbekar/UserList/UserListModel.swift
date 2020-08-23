//
//  UserListModel.swift
//  GithubUser_Mayur_Limbekar
//
//  Created by Admin on 20/08/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import RealmSwift


// MARK: - UserListModel
struct UserListModel: Decodable {
    var totalCount: Int?
    var items: [Item]
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}

// MARK: - Item Model
class Item: Object,Codable {
    @objc dynamic var login: String?
    @objc dynamic var id: Int = 0
    @objc dynamic var avatarURL: String?
    @objc dynamic var type: String?
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
        case type
    }
    //Primary ke to avoid duplicate records 
    override class func primaryKey() -> String? {
        return "id"
    }
}

