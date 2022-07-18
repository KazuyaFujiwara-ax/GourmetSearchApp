//
//  ShopDetailInfomationCell.swift
//  
//
//  Created by AXLT0220-AP on 2022/05/14.
//

import UIKit

// 店舗情報セル用
struct ShopInfo {
    let title: String
    let description: String
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}

class ShopDetailInfoCell: UITableViewCell {
    
    @IBOutlet private weak var shopInfoTitleLabel: UILabel!
    @IBOutlet private weak var shopInfoDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // セルのタイトル・説明ラベルを設定する
    func setCellData(shopInfo: ShopInfo) {
        self.shopInfoTitleLabel.text = shopInfo.title
        self.shopInfoDescriptionLabel.text = shopInfo.description
        self.shopInfoDescriptionLabel.sizeToFit()
    }
}
