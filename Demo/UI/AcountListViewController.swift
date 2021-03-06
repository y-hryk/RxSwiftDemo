//
//  AcountListViewController.swift
//  Demo
//
//  Created by yamaguchi on 2016/10/31.
//  Copyright © 2016年 h.yamaguchi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AcountListViewController: UITableViewController {
    
    var disposeBag = DisposeBag()
    
    var viewModel = AcountViewModel()
    let scrollEndComing = Variable(false)

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "アカウント一覧"
        self.view.backgroundColor = UIColor.white
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        // アカウント一覧を取得する
//        self.viewModel.requestTwitterAcount {
//            self.tableView.reloadData()
//        }
        
        self.viewModel.requestTwitterAcounts().subscribe(onNext: { (acounts) in
            print(acounts)
        }).addDisposableTo(self.disposeBag)
        
        
        self.viewModel.requestTwitterAcounts()
        .map { self.viewModel.requestTwitterAllAcountInfo(acounts: $0) }
        .subscribe(onNext: {
            print($0)
        }).addDisposableTo(self.disposeBag)
        
        // TableView Cell Bind
        self.viewModel.acounts.asDriver().drive(tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
        
        cell.textLabel?.text = "\(element.username!)"
            
        }.addDisposableTo(self.disposeBag)
        
        // TableView Tap Event
        self.tableView.rx
            .itemSelected
            .subscribe(onNext: { indexPath in
                self.tableView.deselectRow(at: indexPath, animated: true)
                
            })
            .addDisposableTo(self.disposeBag)
        
        
        self.scrollEndComing.asObservable()
        .subscribe(onNext: {
            print($0)
        }).addDisposableTo(disposeBag)
        
        
        self.tableView
            .rx.contentOffset
            .asObservable()
            .map { [unowned self] in
                print("")
                return $0.y + 300 >= self.tableView.contentSize.height - self.tableView.bounds.size.height
            }
            .bindTo(scrollEndComing)
            .addDisposableTo(disposeBag)
        
    }
}
