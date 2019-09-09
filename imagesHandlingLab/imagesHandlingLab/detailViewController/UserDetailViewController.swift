//
//  UserDetailViewController.swift
//  imagesHandlingLab
//
//  Created by albert coelho oliveira on 9/6/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    var user: User?
    
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var email: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setImageUp()
        loadUp()
    }
    func setImageUp(){
        ImageHelper.shared.fetchImage(urlString: (user?.picture.large)!) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    self.image.image = image
                }
            }
        }
        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
    }
    func loadUp() {
        name.text = user?.name.FullName
        address.text = user?.location.address
        email.text = user?.phone
        age.text = user?.dob.age.description
        
        
    }
}
