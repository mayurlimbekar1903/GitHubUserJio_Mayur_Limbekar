//
//  UserDetailsModel.swift
//  GithubUser_Mayur_Limbekar
//
//  Created by Admin on 21/08/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - UserDetailsModel
class UserDetailsModel: Object,Codable {
    @objc dynamic var login: String?
    @objc dynamic var id: Int = 0
    @objc dynamic var nodeID: String?
    @objc dynamic var avatarURL: String?
    @objc dynamic var gravatarID: String?
    @objc dynamic var url, htmlURL, followersURL: String?
    @objc dynamic var followingURL, gistsURL, starredURL: String?
    @objc dynamic var subscriptionsURL, organizationsURL, reposURL: String?
    @objc dynamic var eventsURL: String?
    @objc dynamic var receivedEventsURL: String?
    @objc dynamic var type: String?
    @objc dynamic var name, company, blog, location: String?
    @objc dynamic var email: String?
    @objc dynamic var bio: String?
    @objc dynamic var twitterUsername: String?
    @objc dynamic var publicRepos:Int = 0
    @objc dynamic var publicGists:Int = 0
    @objc dynamic var followers:Int = 0
    @objc dynamic var following: Int = 0
    @objc dynamic var createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case name, company, blog, location, email, bio
        case twitterUsername = "twitter_username"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers, following
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    //One to many relation ship is maintained here
    let followerList = List<FollowersModel>()
    //Primary ke to avoid duplicate records 
    override class func primaryKey() -> String? {
        return "id"
    }
}

// MARK: - Followers Model
class FollowersModel:Object,Codable {
    @objc dynamic var login: String?
    @objc dynamic var id: Int = 0
    @objc dynamic var nodeID: String?
    @objc dynamic var avatarURL: String?
    @objc dynamic var gravatarID: String?
    @objc dynamic var url, htmlURL, followersURL: String?
    @objc dynamic var followingURL, gistsURL, starredURL: String?
    @objc dynamic var subscriptionsURL, organizationsURL, reposURL: String?
    @objc dynamic var eventsURL: String?
    @objc dynamic var receivedEventsURL: String?
    @objc dynamic var type: String?
    @objc dynamic var siteAdmin: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
    }
}
