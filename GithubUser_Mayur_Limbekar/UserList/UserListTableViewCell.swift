//
//  UserListTableViewCell.swift
//  GithubUser_Mayur_Limbekar
//
//  Created by Admin on 20/08/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class UserListTableViewCell: UITableViewCell {
    // Mark:- Instance of View
    let userImage:UIImageView = UIImageView()
    let userName:UILabel = UILabel()
    
    //Mark:- Declaration of single user model class instance and attach data to cell
    var userItem:Item?  {
        didSet {
            userName.text = userItem?.login            
            if let url = userItem?.avatarURL,let imageUrl = URL(string: url) {
                userImage.kf.indicatorType = .activity
                userImage.kf.setImage(with: imageUrl,placeholder:UIImage(named: "person"))
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        //Mark:- Add constraints to image view and user name
        addSubview(userImage)
        userImage.snp.makeConstraints { (make) in
            make.height.equalTo(60)
            make.width.equalTo(60)
            make.left.equalTo(self.snp.left).offset(8)
            make.centerY.equalTo(self.snp.centerY)
        }
        addSubview(userName)
        userName.snp.makeConstraints { (make) in
            make.left.equalTo(userImage.snp.right).offset(8)
            make.right.equalTo(self.snp.right).offset(8)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        //Create circular image and add border to it.
        userImage.layer.masksToBounds = true
        userImage.layer.cornerRadius = 30
        userImage.layer.borderWidth = 2
        userImage.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
