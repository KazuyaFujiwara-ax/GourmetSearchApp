//
//  ShopData.swift
//  GourmetSearchApp
//
//  Created by AXLT0220-AP on 2022/05/15.
//

struct GourmetSearchResult: Codable {
    let results: Results
}

struct Results: Codable {
    let shop: [ShopData]
}

struct ShopData: Codable {
    let name: String
    let address: String
    let access: String
    let course: String
    let freeDrink: String
    let freeFood: String
    let privateRoom: String
    let horigotatsu: String
    let tatami: String
    let card: String
    let nonSmoking: String
    
    
    struct GenreInfo: Codable {
        private enum GenreCodingKeys: String, CodingKey {
            case name
        }
        
        var name: String
    }
    
    var genre: GenreInfo
    
    struct PhotoInfo: Codable {
        struct PhotoPcInfo: Codable {
            private enum PhotoPcCodingKeys: String, CodingKey {
                case l = "l"
                case m = "m"
            }
            
            var l: String
            var m: String
        }
        
        private enum PhotoCodingKeys: String, CodingKey {
            case pc = "pc"
        }
        
        var pc: PhotoPcInfo
    }
    
    var photo: PhotoInfo
    
    private enum CodingKeys: String, CodingKey {
        case name
        case address
        case access
        case course
        case freeDrink = "free_drink"
        case freeFood = "free_food"
        case privateRoom = "private_room"
        case horigotatsu
        case tatami
        case card
        case nonSmoking = "non_smoking"
        case genre
        case photo
    }
}
