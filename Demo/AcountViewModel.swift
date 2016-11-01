//
//  AcountViewModel.swift
//  Demo
//
//  Created by yamaguchi on 2016/10/31.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit
import Accounts
import RxSwift
import RxCocoa

public class AcountViewModel: NSObject {

//    var datas = [ACAccount]()
//    var acounts: Observable<[Timeline]>
    
    var acounts = Variable<[ACAccount]>([])
    
    func requestTwitterAcount(completion: (() -> Void)?) {
        
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        accountStore.requestAccessToAccounts(with: accountType,
                                             options: nil)
        { (granted, error) in
            
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
            
            self.acounts.value = acounts
            
            DispatchQueue.main.sync() { () -> Void in
                completion?()
            }

//            acounts?.forEach({ (acount) in
//                print(">> \(acount.username!)")
//                print(">> \(acount.identifier!)")
//            })
        }
    }
}
