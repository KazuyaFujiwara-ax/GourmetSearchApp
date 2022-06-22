//
//  ShopListViewController.swift
//  
//
//  Created by AXLT0220-AP on 2022/04/27.
//

import UIKit

class ShopListViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    private var shopDataArray = [ShopData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NavigationBarのタイトル設定
        self.navigationItem.title = "東京都の店舗一覧"
        
        // TableViewの設定
        tableView.delegate = self
        tableView.dataSource = self
        
        // TableViewCellの登録（店舗一覧セル）
        let nib = UINib(nibName: "ShopListCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ShopListCell")
        
        shopDataArray.removeAll()
        GourmetSearchApi.request(vc: self) {shopDataArray in
            DispatchQueue.main.async {
                self.shopDataArray = shopDataArray
                self.tableView.reloadData()
            }
        }
    }
}

extension ShopListViewController: UITableViewDelegate {
    // 画面遷移
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let shopDetailViewController = ShopDetailViewController()
        let shopData = shopDataArray[indexPath.row]
        shopDetailViewController.navigationItem.title = shopData.name
        shopDetailViewController.shopData = shopData
        self.navigationController?.pushViewController(shopDetailViewController, animated: true)
    }
}

extension ShopListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShopListCell", for: indexPath) as? ShopListCell else { return UITableViewCell() }
        cell.setCellData(shopData: shopDataArray[indexPath.row])
        return cell
    }
}
