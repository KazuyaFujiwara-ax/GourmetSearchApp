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
    let free_drink: String
    let free_food: String
    let private_room: String
    let horigotatsu: String
    let tatami: String
    let card: String
    let non_smoking: String
    
    var genreName: String {
        return genre.name
    }
    var photoSizeM: String {
        return photo.pc.m
    }
    var photoSizeL: String {
        return photo.pc.l
    }
    
    private let genre: Genre
    private struct Genre: Codable {
        let name: String
    }
    
    private let photo: Photo
    private struct Photo: Codable {
        let pc: PhotoPc
    }
    private struct PhotoPc: Codable {
        let l: String
        let m: String
    }
}
