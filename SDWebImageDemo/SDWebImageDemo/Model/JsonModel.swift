//
//  JsonModel.swift
//  SDWebImageDemo
//
//  Created by Deep Patel on 02/06/21.
//

import Foundation
import SwiftyJSON

struct JsonModel {
    var title : String = ""
    var url : String = ""
    
    init(){
        
    }
    
    init(json:JSON){
        title = json["title"].stringValue
        url = json["url"].stringValue
    }
}
