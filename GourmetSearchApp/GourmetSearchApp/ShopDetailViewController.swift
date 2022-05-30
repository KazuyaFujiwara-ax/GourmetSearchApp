//
//  ShopDetailViewController.swift
//  GourmetSearchApp
//
//  Created by AXLT0220-AP on 2022/05/30.
//

import UIKit

class ShopDetailViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TableViewの設定
        tableView.delegate = self
        tableView.dataSource = self
        
        // TableViewCellの登録（店舗一覧セル）
        let nib = UINib(nibName: "ShopDetailInfoCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ShopDetailInfoCell")
    }
}

extension ShopDetailViewController: UITableViewDelegate {
    // code
}

extension ShopDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // WIP
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    // WIP
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShopDetailInfoCell", for: indexPath) as? ShopDetailInfoCell else { return UITableViewCell() }
        cell.setCellData(title: "TEST", description: "descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription")
        return cell
    }
    
}
