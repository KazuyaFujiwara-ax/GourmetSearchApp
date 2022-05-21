//
//  ShopData.swift
//  GourmetSearchApp
//
//  Created by AXLT0220-AP on 2022/05/15.
//

class ShopData: Codable {
    var name: String = ""
    
    class ImageInfo: Codable {
        private enum CodingKeys: String, CodingKey {
            case photo = "shop.photo.pc.m"
        }
        
        var photo: String?
    }
    
    var imageInfo: ImageInfo = ImageInfo()
    
}
