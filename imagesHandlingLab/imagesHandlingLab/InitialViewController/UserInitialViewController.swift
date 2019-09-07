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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  

}
extension UserInitialViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
