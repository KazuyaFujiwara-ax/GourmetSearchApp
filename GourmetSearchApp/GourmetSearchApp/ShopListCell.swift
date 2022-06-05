//
//  ShopListCell.swift
//  
//
//  Created by AXLT0220-AP on 2022/05/09.
//

import UIKit

class ShopListCell: UITableViewCell {
    
    @IBOutlet private weak var shopImageView: UIImageView!
    @IBOutlet private weak var shopNameLabel: UILabel!
    @IBOutlet private weak var shopGenreLabel: UILabel!
    @IBOutlet private weak var shopAddressLabel: UILabel!
    @IBOutlet private weak var shopInfoLabel: UILabel!
    
    private var imageCache = NSCache<AnyObject, UIImage>()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        shopImageView.image = nil
    }
    
    // 店舗の個室有無・カード利用可否・禁煙有無のラベルを作成する
    private func makeShopInfoLabel(privateRoom: String, card: String, nonSmoking: String) -> String {
        var result = ""
        
        // 個室がある場合は「あり」を表示
        if(privateRoom.prefix(2) == "あり") {
            result += "あり,"
        }
        // カードが利用可の場合は「カード利用可」を表示
        if(card == "利用可") {
            result += "カード利用可,"
        }
        // 禁煙情報は常に表示
        result += nonSmoking
        
        return result
    }
    
    func setCellData(shopData: ShopData) {
        // 店の各ラベルを設定する
        self.shopNameLabel.text = shopData.name
        self.shopGenreLabel.text = shopData.genre.name
        self.shopAddressLabel.text = shopData.address
        self.shopInfoLabel.text = makeShopInfoLabel(privateRoom: shopData.privateRoom, card: shopData.card, nonSmoking: shopData.nonSmoking)
        self.shopInfoLabel.sizeToFit()
        
        // 店の画像を設定する
        let shopPhotoUrl = shopData.photo.pc.m
        if let cacheImage = imageCache.object(forKey: shopPhotoUrl as AnyObject) {
            self.shopImageView.image = cacheImage
            return
        }
        guard let url = URL(string: shopPhotoUrl) else {
            return
        }
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            guard let image = UIImage(data: data) else {
                return
            }
            self.imageCache.setObject(image, forKey: shopPhotoUrl as AnyObject)
            DispatchQueue.main.async {
                self.shopImageView.image = image
            }
        }
        task.resume()
    }
}
