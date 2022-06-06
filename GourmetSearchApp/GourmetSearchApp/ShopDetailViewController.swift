//
//  ShopDetailViewController.swift
//  GourmetSearchApp
//
//  Created by AXLT0220-AP on 2022/05/30.
//

import UIKit

class ShopDetailViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    var shopData: ShopData!
    var shopInfoArray = [ShopInfo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TableViewの設定
        tableView.delegate = self
        tableView.dataSource = self
        
        // ShopDetailInfoCell用の店舗データ作成
        makeShopInfoArray(shopData: shopData)
        
        // TableViewCellの登録（店舗一覧セル）
        let imageNib = UINib(nibName: "ShopDetailImageCell", bundle: nil)
        tableView.register(imageNib, forCellReuseIdentifier: "ShopDetailImageCell")
        let infoNib = UINib(nibName: "ShopDetailInfoCell", bundle: nil)
        tableView.register(infoNib, forCellReuseIdentifier: "ShopDetailInfoCell")
    }
    
    private func makeShopInfoArray(shopData: ShopData) {
        shopInfoArray.removeAll()
        shopInfoArray.append(ShopInfo(title: "ジャンル", description: shopData.genre.name))
        shopInfoArray.append(ShopInfo(title: "交通アクセス", description: shopData.access))
        shopInfoArray.append(ShopInfo(title: "住所", description: shopData.address))
        shopInfoArray.append(ShopInfo(title: "コース", description: shopData.course))
        shopInfoArray.append(ShopInfo(title: "飲み放題", description: shopData.freeDrink))
        shopInfoArray.append(ShopInfo(title: "食べ放題", description: shopData.freeFood))
        shopInfoArray.append(ShopInfo(title: "個室", description: shopData.privateRoom))
        shopInfoArray.append(ShopInfo(title: "掘りごたつ", description: shopData.horigotatsu))
        shopInfoArray.append(ShopInfo(title: "座敷", description: shopData.tatami))
        shopInfoArray.append(ShopInfo(title: "カード可", description: shopData.card))
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
        return shopInfoArray.count + 1
    }
    
    // WIP
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            guard let imageCell = tableView.dequeueReusableCell(withIdentifier: "ShopDetailImageCell", for: indexPath) as? ShopDetailImageCell else { return UITableViewCell() }
            imageCell.setImage(imageUrl: shopData.photo.pc.l)
            
            return imageCell
        } else {
            guard let infoCell = tableView.dequeueReusableCell(withIdentifier: "ShopDetailInfoCell", for: indexPath) as? ShopDetailInfoCell else { return UITableViewCell() }
            infoCell.setCellData(shopInfo: shopInfoArray[indexPath.row - 1])
            
            return infoCell
        }
    }
}
