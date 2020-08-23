//
//  DetailsViewController+View.swift
//  GithubUser_Mayur_Limbekar
//
//  Created by Admin on 21/08/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit


extension DetailsViewController {
    //Mark:- Create Table View ad into main view and apply constraints
    func createView() {
        view.addSubview(followersTable)
        followersTable.delegate = self
        followersTable.dataSource = self
        followersTable.register(FollowerTableViewCell.self, forCellReuseIdentifier: "cell")
        
        followersTable.tableFooterView = UIView()
        followersTable.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    //Mark:- Create Custom header view to show details of user
    func createHeaderView() -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        
        let userImage = UIImageView()
        userImage.layer.cornerRadius = 30
        userImage.clipsToBounds = true
        userImage.layer.borderColor = UIColor.gray.cgColor
        userImage.layer.borderWidth = 3
        
        headerView.addSubview(userImage)
        userImage.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.top).offset(8)
            make.left.equalTo(headerView.snp.left).offset(8)
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
        
        let boldFont = UIFont.boldSystemFont(ofSize: 14)
        let systemFont = UIFont.systemFont(ofSize: 14)
        
        //Follower view
        let followerCountLbl = UILabel()
        followerCountLbl.getAttribtedLabel(alignment: .center, getFont: boldFont, lines: 1)
        
        let followerLbl = UILabel()
        followerLbl.getAttribtedLabel(alignment: .center, getFont: systemFont, lines: 1)
        
        let followerStack = UIStackView()
        followerStack.getStack(axis: .vertical, alignment: .fill, distribution: .fillEqually, spacing: 8)
        followerStack.insertArrangedSubview(followerCountLbl, at: 0)
        followerStack.insertArrangedSubview(followerLbl, at: 1)
        
        //following view
        let followingCountLbl = UILabel()
        followingCountLbl.getAttribtedLabel(alignment: .center, getFont: boldFont, lines: 1)
        
        let followingLbl = UILabel()
        followingLbl.getAttribtedLabel(alignment: .center, getFont: systemFont, lines: 1)
        
        let followingStack = UIStackView()
        followingStack.getStack(axis: .vertical, alignment: .fill, distribution: .fillEqually, spacing: 8)
        followingStack.insertArrangedSubview(followingCountLbl, at: 0)
        followingStack.insertArrangedSubview(followingLbl, at: 1)
        
        //repositories view
        let repositoriesCountLbl = UILabel()
        repositoriesCountLbl.getAttribtedLabel(alignment: .center, getFont: boldFont, lines: 1)
        
        let repositoriesLbl = UILabel()
        repositoriesLbl.getAttribtedLabel(alignment: .center, getFont: systemFont, lines: 1)
        
        let repositoriesStack = UIStackView()
        repositoriesStack.getStack(axis: .vertical, alignment: .fill, distribution: .fillEqually, spacing: 8)
        repositoriesStack.insertArrangedSubview(repositoriesCountLbl, at: 0)
        repositoriesStack.insertArrangedSubview(repositoriesLbl, at: 1)
        
        //followers,following,repository added into main stack view
        let mainStack = UIStackView()
        mainStack.getStack(axis: .horizontal, alignment: .fill, distribution: .fillEqually, spacing: 8)
        mainStack.insertArrangedSubview(followerStack, at: 0)
        mainStack.insertArrangedSubview(followingStack, at: 1)
        mainStack.insertArrangedSubview(repositoriesStack, at: 2)
        
        headerView.addSubview(mainStack)
        
        mainStack.snp.makeConstraints { (make) in
            make.left.equalTo(userImage.snp.right).offset(8)
            make.right.equalTo(headerView.snp.right).offset(-8)
            make.centerY.equalTo(userImage.snp.centerY)
        }
        
        //User name label and apply constraints
        let nameLbl = UILabel()
        nameLbl.getAttribtedLabel(alignment: .left, getFont: UIFont.boldSystemFont(ofSize: 16), lines: 1)
        headerView.addSubview(nameLbl)
        
        nameLbl.snp.makeConstraints { (make) in
            make.top.equalTo(userImage.snp.bottom).offset(6)
            make.left.equalTo(headerView.snp.left).offset(8)
            make.right.equalTo(headerView.snp.right).offset(-8)
        }
        
        //user login name label
        let useridLbl = UILabel()
        useridLbl.textColor = UIColor.gray
        useridLbl.getAttribtedLabel(alignment: .left, getFont: systemFont, lines: 1)
        headerView.addSubview(useridLbl)
        useridLbl.snp.makeConstraints { (make) in
            make.top.equalTo(nameLbl.snp.bottom).offset(6)
            make.left.equalTo(headerView.snp.left).offset(8)
            make.right.equalTo(headerView.snp.right).offset(-8)
        }
        
        //bio data label
        let bioLbl = UILabel()
        bioLbl.font = UIFont.systemFont(ofSize: 14)
        bioLbl.textColor = UIColor.darkGray
        bioLbl.numberOfLines = 0
        bioLbl.lineBreakMode = .byWordWrapping
        bioLbl.textAlignment = .left
        
        headerView.addSubview(bioLbl)
        
        bioLbl.snp.makeConstraints { (make) in
            make.top.equalTo(useridLbl.snp.bottom).offset(6)
            make.left.equalTo(headerView.snp.left).offset(8)
            make.right.equalTo(headerView.snp.right).offset(-8)
            //            make.bottom.equalTo(headerView.snp.bottom).offset(-12)
        }
        
        //organization details view
        let organizationImage = UIImageView()
        organizationImage.tintColor = .darkGray
        organizationImage.image = UIImage(systemName: "person.2.square.stack")
        organizationImage.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        let organizationLbl = UILabel()
        organizationLbl.getAttribtedLabel(alignment: .left, getFont: systemFont, lines: 1)
        
        let organizationStack = UIStackView()
        organizationStack.getStack(axis: .horizontal, alignment: .fill, distribution: .fill, spacing: 8)
        organizationStack.insertArrangedSubview(organizationImage, at: 0)
        organizationStack.insertArrangedSubview(organizationLbl, at: 1)
        
        //location details view
        let locationImage = UIImageView()
        locationImage.tintColor = .darkGray
        locationImage.image = UIImage(systemName: "mappin.and.ellipse")
        locationImage.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        let locationLbl = UILabel()
        locationLbl.getAttribtedLabel(alignment: .left, getFont: systemFont, lines: 1)
        let locationStack = UIStackView()
        locationStack.getStack(axis: .horizontal, alignment: .fill, distribution: .fill, spacing: 8)
        locationStack.insertArrangedSubview(locationImage, at: 0)
        locationStack.insertArrangedSubview(locationLbl, at: 1)
        
        //organization details,location details stack view
        let detailStackView = UIStackView()
        detailStackView.getStack(axis: .vertical, alignment: .fill, distribution: .fill, spacing: 6)
        detailStackView.insertArrangedSubview(organizationStack, at: 0)
        detailStackView.insertArrangedSubview(locationStack, at: 1)
        
        headerView.addSubview(detailStackView)
        detailStackView.snp.makeConstraints { (make) in
            make.top.equalTo(bioLbl.snp.bottom).offset(6)
            make.left.equalTo(headerView.snp.left).offset(8)
            make.right.equalTo(headerView.snp.right).offset(-8)
            //            make.bottom.equalTo(headerView.snp.bottom).offset(-6)
        }
        
        // User url link view and attach data to link
        let urlImage = UIImageView()
        urlImage.tintColor = .darkGray
        urlImage.image = UIImage(systemName: "globe")
        headerView.addSubview(urlImage)
        urlImage.snp.makeConstraints { (make) in
            
            make.left.equalTo(headerView.snp.left).offset(8)
            make.top.equalTo(detailStackView.snp.bottom).offset(6)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        let urlLabel = UILabel()
        urlLabel.textAlignment = .left
        headerView.addSubview(urlLabel)
        urlLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(urlImage.snp.right).offset(8)
            make.right.equalTo(headerView.snp.right).offset(-8)
            make.centerY.equalTo(urlImage.snp.centerY)
        }
        
        if !checkEmptyString(userDetail.htmlURL) {
            if let urlStr = userDetail.htmlURL {
                let attributedString = NSMutableAttributedString(string: urlStr, attributes:[NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14),NSAttributedString.Key.foregroundColor:UIColor.systemBlue,NSAttributedString.Key.link: URL(string: urlStr)!])
                urlLabel.attributedText = attributedString
            }
        } else {
            urlImage.isHidden = true
        }
        
        //Followers header view
        let followerView = UIView()
        followerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        headerView.addSubview(followerView)
        
        followerView.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.top.equalTo(urlLabel.snp.bottom).offset(6)
            make.left.equalTo(headerView.snp.left)
            make.right.equalTo(headerView.snp.right)
            make.bottom.equalTo(headerView.snp.bottom)
        }
        
        let follwerLbl = UILabel()
        follwerLbl.text = "Follower"
        follwerLbl.getAttribtedLabel(alignment: .left, getFont: UIFont.boldSystemFont(ofSize: 16), lines: 1)
        
        followerView.addSubview(follwerLbl)
        follwerLbl.snp.makeConstraints { (make) in
            make.left.equalTo(followerView.snp.left).offset(8)
            make.right.equalTo(followerView.snp.right).offset(-8)
            make.centerY.equalTo(followerView.snp.centerY)
        }
        
        //        MARK:-Attach data to headerView
        if let url = userDetail.avatarURL,let imageUrl = URL(string: url) {
            userImage.kf.indicatorType = .activity
            userImage.kf.setImage(with: imageUrl,placeholder: UIImage(named: "person"))
        }
        
        nameLbl.text = userDetail.name
        useridLbl.text = userDetail.login
        bioLbl.text = userDetail.bio
        
        followerLbl.text = "Followers"
        followerCountLbl.text = "\(userDetail.followers)"
        followingLbl.text = "Following"
        followingCountLbl.text = "\(userDetail.following)"
        repositoriesLbl.text = "Repositories"
        repositoriesCountLbl.text = "\(userDetail.publicRepos)"
        
        self.checkEmptyString(userDetail.company) ? (detailStackView.arrangedSubviews[0].isHidden = true) : (organizationLbl.text = userDetail.company)
        self.checkEmptyString(userDetail.location) ? (detailStackView.arrangedSubviews[1].isHidden = true) : (locationLbl.text = userDetail.location)
        
        return headerView
    }
}


