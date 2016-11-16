//
//  AcountViewModel.swift
//  Demo
//
//  Created by yamaguchi on 2016/10/31.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit
import Accounts
import Social
import RxSwift
import RxCocoa

public class AcountViewModel: NSObject {

//    var datas = [ACAccount]()
//    var acounts: Observable<[Timeline]>
    
    var acounts = Variable<[ACAccount]>([])
    
    
//    var userId: Observable<String>
//    var userName: Observable<String>
//    
//    var iconURL: Observable<String>
//    var followers_count: Observable<Int>
//    var following: Observable<Int>
    
    
    func requestTwitterAcount(completion: (() -> Void)?) {
        
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        accountStore.requestAccessToAccounts(with: accountType,
                                             options: nil)
        { [weak self] (granted, error) in
//            guard let `self` = self else { // OK!
//                return
//            }
            
            // エラー処理
            if error != nil {
                // そのままアラート出せばおk
                return
            }
            
            // 認証エラー
            if !granted {
                // アラート表示 設定画面に飛ばしてあげよう
                return
            }
            
            guard let acounts = accountStore.accounts(with: accountType) as? [ACAccount] else {
                // アカウントがないよ。登録してください エラー
                return
            }
            
            acounts.forEach({ (acAcount) in
//                var acount = Acount()

            })
            
            self?.acounts.value = acounts
            
            DispatchQueue.main.sync() { () -> Void in
//                self?.requestTwitterAcountInfo(acount: (self?.acounts.value.first!)!)
                self?.requestTwitterAllAcountInfo(acounts: acounts)
                completion?()
            }
        }
    }
    
    fileprivate func requestTwitterAcountInfo(acount: ACAccount) {
        
        let url = URL(string: "https://api.twitter.com/1.1/users/show.json")
        let params = ["screen_name": (acount.username)!]
        
        let request = SLRequest(forServiceType: SLServiceTypeTwitter,
                                requestMethod: .GET,
                                url: url, parameters: params)
        
        request?.account = acount
        request?.perform(handler: { (responseData, urlResponse, error) in
            
            if error != nil {
                print("error is \(error)")
                return
            }
            
            if let result = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments) {
                print("requestTwitterAcountInfo: \(result)")
            }
            
        })
    }
    
    fileprivate func requestTwitterAllAcountInfo(acounts: [ACAccount]) {
        
        // アカウントが取得できていなければエラー
        if acounts.isEmpty { return }
        
        var users = [String]()
        
        acounts.forEach { (acount) in
            users.append(acount.username)
        }
        let usersStr = users.joined(separator: ",")
        
        print(usersStr)
        
        let url = URL(string: "https://api.twitter.com/1.1/users/lookup.json")
        let params = ["screen_name": usersStr]
        let request = SLRequest(forServiceType: SLServiceTypeTwitter,
                                requestMethod: .GET,
                                url: url, parameters: params)
        
        request?.account = acounts.first
        request?.perform(handler: { (responseData, urlResponse, error) in
            
            if error != nil {
                print("error is \(error)")
                return
            }
            
            if let result = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments) {
//                print("requestTwitterAllAcountInfo: \(result)")
                
                var models = Acount.convertJSONObject(acAcounts: acounts, json: result)
                
            }
            
        })

    }
    
}
