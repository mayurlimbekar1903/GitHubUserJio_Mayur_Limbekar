//
//  DetailsViewController.swift
//  GithubUser_Mayur_Limbekar
//
//  Created by Admin on 21/08/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import RealmSwift
import Reachability
class DetailsViewController: UIViewController,ReachabilityObserverDelegate {
    // Mark:- Instance of View
    let followersTable = UITableView(frame: .zero, style: UITableView.Style.grouped)
    //Mark:- Declaration of variable and Constant
    var selectedUser = Item()
    var userDetail = UserDetailsModel()
    var followersArray = [FollowersModel]()
    let dispatchgroup = DispatchGroup()
    let realm = try! Realm()
    //Mark:- View life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        try? addReachabilityObserver()
        self.view.backgroundColor = UIColor.white
        self.createView()
    }
    
    deinit {
        removeReachabilityObserver()
    }
    
    //    Mark:- Internet Rechability Checking
    func reachabilityChanged(_ isReachable: Bool) {
        print("Details isReachable",isReachable)
        if isReachable {
            dispatchgroup.enter()
            self.getDetailsOfUser(selectedUser.login!)
            dispatchgroup.enter()
            self.getFollowersOfUser(selectedUser.login!)
            dispatchgroup.notify(queue: .main) {
                self.followersTable.reloadData() {
                    self.saveData()
                }
            }
        } else {
            self.getData()
        }
    }
}

//Mark:- UITableView Delegate method
extension DetailsViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        followersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FollowerTableViewCell = followersTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FollowerTableViewCell
        cell.userItem = followersArray[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return createHeaderView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
//Mark- get details of user along with followers data when network is reachable
extension DetailsViewController {
    func getDetailsOfUser(_ user:String) {
        let dataUrl = "\(UrlData.shared.baseurl)users/\(user)"
        guard let percentUrl = dataUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let manager = Alamofire.Session.default
        manager.request(percentUrl, method:.get).responseJSON(completionHandler:{ response in
            switch response.result {
            case .success:
                
                guard response.response?.statusCode == 200 else {
                    debugPrint(response.result)
                    return
                }
                
                guard let data = response.data else { return }
                
                do {
                    self.userDetail = try JSONDecoder().decode(UserDetailsModel.self, from: data)
                    self.dispatchgroup.leave()
                } catch let err {
                    debugPrint(err)
                }
                break
            case .failure( _) :
                self.displayAlert(title: "Alert", message: "Something went wrong")
            }
        })
    }
    
    func getFollowersOfUser(_ user:String) {
        let dataUrl = "\(UrlData.shared.baseurl)users/\(user)/followers"
        guard let percentUrl = dataUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let manager = Alamofire.Session.default
        manager.request(percentUrl, method:.get).responseJSON(completionHandler:{ response in
            switch response.result {
            case .success:
                
                guard response.response?.statusCode == 200 else {
                    debugPrint(response.result)
                    return
                }
                
                guard let data = response.data else { return }
                
                do {
                    self.followersArray = try JSONDecoder().decode([FollowersModel].self, from: data)
                    print("follwers",self.followersArray)
                    self.dispatchgroup.leave()
                } catch let err {
                    debugPrint(err)
                }
                break
                
                
            case .failure( _) :
                self.displayAlert(title: "Alert", message: "Something went wrong")
            }
        })
    }
}

//    Mark:-Local database save and retrive data operations
extension DetailsViewController {
    func saveData () {
        let realm = try! Realm()
        try! realm.write {
            realm.add(userDetail, update: Realm.UpdatePolicy.modified)
        }
        saveFollowers(userDetail)
    }
    
    func saveFollowers(_ userDetails:UserDetailsModel) {
        for follower in followersArray {
            try! realm.write {
                userDetails.followerList.append(follower)
            }
        }
    }
    
    func getData() {
        let resultss = realm.objects(UserDetailsModel.self).filter{$0.id == self.selectedUser.id}
        if resultss.count > 0 {
            if let object = resultss.last {
                self.userDetail = object
                let followerlist = Array(object.followerList)
                self.followersArray = followerlist
                DispatchQueue.main.async {
                    self.followersTable.reloadData()
                }
            }
        }
    }
}
