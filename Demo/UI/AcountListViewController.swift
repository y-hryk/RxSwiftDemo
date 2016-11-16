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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "アカウント一覧"
        self.view.backgroundColor = UIColor.white
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        // アカウント一覧を取得する
        self.viewModel.requestTwitterAcount {
            self.tableView.reloadData()
        }
        
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
        
        
        let sequesnceFormArray = [1,2]
        
    }
}
