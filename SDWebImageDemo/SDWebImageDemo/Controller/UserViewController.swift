//
//  UserViewController.swift
//  SDWebImageDemo
//
//  Created by Deep Patel on 02/06/21.
//

import UIKit
import SwiftyJSON
import SDWebImage

class UserViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var arrData = [JsonModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonParsing()
    }

    func jsonParsing(){
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
        URLSession.shared.dataTask(with: url!) { (data, response, error)
            in
            guard let data = data else { return }
            do{
                let json = try JSON(data : data)
                let results = json
                for arr in results.arrayValue{
                    //print(arr["title"])
                    self.arrData.append(JsonModel(json: arr))
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                print(self.arrData)
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource{
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return arrData.count
   }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
    cell.lblTitle.text = arrData[indexPath.row].title
    cell.img.sd_setImage(with: URL(string: arrData[indexPath.row].url), completed: nil)
    
    return cell
   }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
