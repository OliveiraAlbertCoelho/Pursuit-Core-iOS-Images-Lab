//
//  UserInitialViewController.swift
//  imagesHandlingLab
//
//  Created by albert coelho oliveira on 9/6/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import UIKit

class UserInitialViewController: UIViewController {
    @IBOutlet weak var userTable: UITableView!
    @IBOutlet weak var userSearch: UISearchBar!
    
    var user = [User](){
        didSet {
            userTable.reloadData()
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        userTable.delegate = self
        userTable.dataSource = self
        loadData()
        userSearch.delegate = self
    }
    
    var userSearchTerm: String? {
        didSet {
            self.userTable.reloadData()
        }
    }
    var filteredPersonArr: [User]  {
        guard let userSearchTerm = userSearchTerm else {
            return user
        }
        guard userSearchTerm != "" else {
            return user
        }
        
        return user.filter({ (user) -> Bool in
            user.name.first.lowercased().contains(userSearchTerm.lowercased())
        })
    }
    
    private func loadData() {
        UserBase.getUser{(result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let userOnline):
                    self.user = userOnline
                }
            }
        }
        
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let jokeDetailVC = segue.destination as? userDetailViewController else {
//            fatalError("Unexpected segue")
//        }
//        guard let selectedIndexPath = tableView.indexPathForSelectedRow
//            else { fatalError("No row selected") }
//        jokeDetailVC.userInfo = filteredPersonArr[selectedIndexPath.row]
//    }
    
}

extension UserInitialViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPersonArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTable.dequeueReusableCell(withIdentifier: "userCell") as? UserCellTableViewCell
        
//        ImageHelper.shared.fetchImage(urlString: filteredPersonArr[indexPath.row].picture.thumbnail) { (result) in
//            DispatchQueue.main.async {
//                switch result {
//                case .failure(let error):
//                    print(error)
//                case .success(let image):
//                cell?.userImage.image = image
//                }
//            }
//        }
        let selected = user[indexPath.row]
        cell?.age.text = "Age: \(selected.dob.age.description)"
        cell?.userName.text = selected.name.first
        cell?.phone.text = selected.cell
        return cell!
    }
}
extension UserInitialViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.userSearchTerm = searchText
    }
}


