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
    var datas = [Acount]()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "アカウント一覧"

        self.view.backgroundColor = UIColor.white
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

