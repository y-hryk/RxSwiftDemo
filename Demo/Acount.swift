//
//  Acount.swift
//  Demo
//
//  Created by yamaguchi on 2016/10/31.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Accounts


struct Acount {
    
    var acount: ACAccount? = nil
    var userId = ""
    var userName = ""
    var iconURL = ""
    var followers_count = 0
    var friends_count = 0
    
    
    static func convertJSONObject(acAcounts: [ACAccount], json: Any) -> Acount {
        
        var acount = Acount()
        acount.userId = ""
        
        print(json)
        
        if let jsonArray = json as? [Any] {
            
            jsonArray.enumerated().forEach({ (offset: Int, element: Any) in
                
                if let dict = element as? [String: Any] {
                    
                    // ユーザーID
                    if let userId = dict["id"] as? String {
                        print(userId)
                    }
                    // ユーザー名
                    if let userName = dict["screen_name"] as? String {
                        print(userName)
                    }
                    // iconURL
                    if let iconURL = dict["profile_image_url_https"] as? String {
                        print(iconURL)
                    }
                    // フォロワー数
                    if let followers_count = dict["followers_count"] as? Int {
                        print(followers_count)
                    }
                    // フォロー数
                    if let friends_count = dict["friends_count"] as? Int {
                        print(friends_count)
                    }
                }

            })
        }
        
        return acount
    }
}
