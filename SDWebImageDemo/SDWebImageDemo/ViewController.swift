//
//  ViewController.swift
//  SDWebImageDemo
//
//  Created by Deep Patel on 01/06/21.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var TextUrl: UITextField!
    @IBOutlet weak var image: UIImageView!
    
    @IBAction func Downloadbtn(_ sender: UIButton) {
        self.downloadImageFromUrl()
    }
    //let urlString = "https://iosacademy.io/assets/images/brand/header.png"
    let urlString = "https://homepages.cae.wisc.edu/~ece533/images/airplane.png"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        //image.sd_setImage(with: URL(string: urlString), completed: nil)
       // image.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, context: nil)
       // fetchImage()
        self.TextUrl.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
//mark :- normal urlSession for image from url
//    private func fetchImage(){
//        guard let  url =  URL(string: urlString) else {
//            return
//        }
//        let getDataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
//            guard let data = data, error == nil else {
//                return
//            }
//
//            DispatchQueue.main.async {
//                let dataimage = UIImage(data: data)
//                self.image.image = dataimage
//            }
//        }
//        getDataTask.resume()
//    }

}

extension ViewController {
    func downloadImageFromUrl(){
        guard let imageUrl = TextUrl.text else {
            return
        }
        print(imageUrl)
        
        self.image.load(imageFrom: imageUrl.trimmingCharacters(in: .whitespaces))
    }
}

extension UIImageView {
    
    func load(imageFrom imageUrl:String, localImage:String = "placeholder") {
        
        let placeHolder = UIImage(named: localImage)
        
        guard let imageURL = URL(string: imageUrl) else {
            self.image = placeHolder
            return
        }
        sd_setImage(with: imageURL) { (downloadedImage, error, cacheType, url) in
            self.image = downloadedImage
        }
    }
}

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
