//
//  ShopDetailInfomationCell.swift
//  
//
//  Created by AXLT0220-AP on 2022/05/14.
//

import UIKit

class ShopDetailInfoCell: UITableViewCell {
    
    @IBOutlet private weak var shopInfoTitleLabel: UILabel!
    @IBOutlet private weak var shopInfoDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // セルのラベルを設定する
    func setCellData(title: String, description: String) {
        self.shopInfoTitleLabel.text = title
        self.shopInfoDescriptionLabel.text = description
        self.shopInfoDescriptionLabel.sizeToFit()
    }
}
