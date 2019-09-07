//
//  ViewController.swift
//  imagesHandlingLab
//
//  Created by albert coelho oliveira on 9/6/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var comic: Comic?{
        didSet {
            setUpImage()
        }
    }
    @IBOutlet weak var comicImage: UIImageView!
    @IBOutlet weak var stepperOut: UIStepper!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textOut: UITextField!
    @IBAction func randomButton(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            let randomNumb = Int.random(in: 1...2000)
            updateImage(number: randomNumb)
            stepperOut.value = Double(randomNumb)
        case 2:
            updateImage(number: nil)
            stepperOut.value = Double(2199)
        default:
            print("nothing")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        textOut.delegate = self
        setUpStepper()
    }
   
    func setUpStepper(){
        let random = Int.random(in: 1...2000)
        stepperOut.value = Double( random)
        updateImage(number: random )
    }
    @IBAction func stepper(_ sender: UIStepper) {
        updateImage(number: Int(sender.value))
    }
    private func setUpImage() {
        if let number = comic?.num.description{
            label.text = "Comic Number: \(number)"}
        ImageHelper.shared.fetchImage(urlString:comic!.img) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    self.comicImage.image = image
                }
            }
        }
    }
    private func updateImage(number: Int?){
        Comic.getComic(userNum: number){ (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let comics):
                DispatchQueue.main.async{
                    self.comic = comics
                }
            }
        }
    }
}
extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let userInput = Int((textField.text)!){
            updateImage(number: userInput)
            stepperOut.value = Double(userInput)
            return true
        }
        return false
    }
}
