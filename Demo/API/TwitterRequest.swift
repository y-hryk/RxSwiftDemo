
//
//  TwitterRequest.swift
//  Demo
//
//  Created by yamaguchi on 2016/11/30.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit
import Accounts
import Social
import RxSwift
import RxCocoa

struct TwitterRequest {

    func requestTwitterAcounts() -> Observable<[ACAccount]> {
        return Observable.create { observer in
            
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
                
                //                guard let acounts = accountStore.accounts(with: accountType) as? [ACAccount] else {
                //                    // アカウントがないよ。登録してください エラー
                //                    return
                //                }
                let acounts = accountStore.accounts(with: accountType) as! [ACAccount]
                if acounts.isEmpty {
                    // アカウントがないよ。登録してください エラー
                    return
                }
                
                DispatchQueue.main.sync() { () -> Void in
                    observer.onNext(acounts)
                }
            }
            return Disposables.create([])
        }
    }

}

