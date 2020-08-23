//
//  UserListViewController.swift
//  GithubUser_Mayur_Limbekar
//
//  Created by Admin on 20/08/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Alamofire
import SnapKit
import RealmSwift
import Kingfisher

class UserListViewController: UIViewController,ReachabilityObserverDelegate {

    // Mark:- Instance of View
    let searchBar:UISearchBar = UISearchBar()
    let userListTable:UITableView = UITableView()
    let errorLabel = UILabel()
    
    //Mark:- Declaration of variable and Constant
    let semaphore = DispatchSemaphore(value: 1)
    private let realm = try! Realm()
    private var userItem:[Item] = [Item]()
    private var filteredData:[Item] = [Item]()
    
    private var isSearching = false
    private var isOnline = false
    
    //Mark:- View life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        try? addReachabilityObserver()
        
        self.view.backgroundColor = UIColor.white
        self.createSearchBar()
        self.createUserTable()
        self.getDataFroDataBase()
    }
    
    deinit {
        removeReachabilityObserver()
    }
    
    //    Mark:- Internet Rechability Checking
    func reachabilityChanged(_ isReachable: Bool) {
        print("isReachable",isReachable)
        if isReachable {
            isOnline = true
        } else {
            isOnline = false
            getDataFroDataBase()
        }
    }
    
    //Show Error view
    func showLabel(_ err:String,errOccur:Bool) {
        if errOccur {
            self.errorLabel.isHidden = false
            self.errorLabel.text = err
            self.userListTable.isHidden = true
        } else {
            self.errorLabel.isHidden = true
            self.userListTable.isHidden = false
        }
    }
}

//Mark:- UISearch bar delegate
extension UserListViewController:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String)
    {
        if (textSearched != "") && (isOnline == true){
            let dispatchQueue = DispatchQueue.global(qos: .utility)
            dispatchQueue.async {
                self.semaphore.wait()
                self.getData(textSearched)
                self.semaphore.signal()
            }
        } else {
            if (textSearched != "") {
                filteredData = userItem.filter(){nil != $0.login?.range(of: searchBar.text!, options: String.CompareOptions.caseInsensitive)}
            }
            self.reloadTable(isSaveInDB: false)
        }
    }
}

//Mark:- UITableView Delegate method
extension UserListViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  ((searchBar.text != "") || (searchBar.text == nil)) && (isOnline == false) {
            return filteredData.count
        } else {
            return userItem.count
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UserListTableViewCell = userListTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserListTableViewCell
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        if ((searchBar.text != "") || (searchBar.text == nil)) && (isOnline == false){
            cell.userItem = filteredData[indexPath.row]
        } else {
            cell.userItem = userItem[indexPath.row]
        }
    
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = DetailsViewController()
        if ((searchBar.text != "") || (searchBar.text == nil)) && (isOnline == false){
            detailView.selectedUser = filteredData[indexPath.row]
        } else {
            detailView.selectedUser = userItem[indexPath.row]
        }
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    
    func reloadTable(isSaveInDB:Bool) {
           DispatchQueue.main.async {
               if isSaveInDB {
                   self.userListTable.reloadData {
                       self.saveDataToDataBase()
                   }
               } else {
                   self.userListTable.reloadData()
               }
           }
       }
}

//Mark- get user list data when network is reachable
extension UserListViewController {
    func getData(_ searchString:String) {
        let dataUrl = "\(UrlData.shared.baseurl)search/users?q=\(searchString)&page=1"
        guard let percentUrl = dataUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let manager = Alamofire.Session.default
        manager.request(percentUrl, method:.get).responseJSON(completionHandler:{ response in
            switch response.result {
            case .success:
                guard response.response?.statusCode == 200 else {
                    debugPrint(response.result)
                    self.showLabel("API rate limit exceeded(But here's the good news: Authenticated requests get a higher rate limit. Check out the documentation for more details", errOccur: true)
                    return
                }
                
                guard let data = response.data else { return }
                self.showLabel("", errOccur: false)
                do {
                    let listArr = try JSONDecoder().decode(UserListModel.self, from: data)
                    self.userItem.removeAll()
                    self.userItem = listArr.items
                } catch let err {
                    debugPrint(err)
                }
                self.reloadTable(isSaveInDB: true)
                break
                
            case .failure( _) :
                self.displayAlert(title: "Alert", message: "Something went wrong")
            }
        })
    }
}

//    Mark:-Local database save and retrive data operations
extension UserListViewController {
    func getDataFroDataBase() {
        let resultss = realm.objects(Item.self)
        let secondArr = Array(resultss)
        self.userItem.removeAll()
        for i in secondArr {
            userItem.append(i)
        }
    }
    
    func saveDataToDataBase () {
        if userItem.count > 0 {
            try! realm.write {
                realm.add(userItem, update: Realm.UpdatePolicy.modified)
            }
        }
    }
}

