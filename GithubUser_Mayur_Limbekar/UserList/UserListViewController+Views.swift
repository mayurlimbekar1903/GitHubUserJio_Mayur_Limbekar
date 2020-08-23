//
//  UserListViewController+Views.swift
//  GithubUser_Mayur_Limbekar
//
//  Created by Admin on 23/08/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

extension UserListViewController {
    //Mark:- Create Search for serching user and add into top navigation bar
    func createSearchBar(){
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = "Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    //Mark:- Create Table view and add into views
    func createUserTable() {
        errorLabel.text = "There is some error"
        errorLabel.numberOfLines = 0
        errorLabel.lineBreakMode = .byWordWrapping
        errorLabel.isHidden = true
        errorLabel.font = UIFont.boldSystemFont(ofSize: 14)
        
        view.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(12)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-12)
            make.centerY.equalTo(self.view.snp.centerY)
        }
        
        view.addSubview(userListTable)
        userListTable.register(UserListTableViewCell.self, forCellReuseIdentifier: "cell")
        userListTable.delegate = self
        userListTable.dataSource = self
        userListTable.tableFooterView = UIView()
        userListTable.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
