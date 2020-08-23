//
//  UrlData.swift
//  GithubUser_Mayur_Limbekar
//
//  Created by Admin on 23/08/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation


class UrlData{
    static let shared = UrlData()
    private init(){}
    
    let baseurl = "https://api.github.com/"
}
