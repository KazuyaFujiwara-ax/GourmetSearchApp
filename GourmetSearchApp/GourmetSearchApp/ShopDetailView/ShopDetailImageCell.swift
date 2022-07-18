//
//  ShopDetailImageCell.swift
//  
//
//  Created by AXLT0220-AP on 2022/05/14.
//

import UIKit

class ShopDetailImageCell: UITableViewCell {
    
    @IBOutlet private weak var shopImageView: UIImageView!

    private var imageCache = NSCache<AnyObject, UIImage>()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // 店舗画像を設定する
    func setImage(imageUrl: String) {
        if let cacheImage = imageCache.object(forKey: imageUrl as AnyObject) {
            self.shopImageView.image = cacheImage
        } else {
            guard let url = URL(string: imageUrl) else {
                return
            }
            url.getImage { image in
                DispatchQueue.main.async {
                    self.shopImageView.image = image
                }
            }
        }
    }
}
