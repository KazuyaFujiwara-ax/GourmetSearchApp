//
//  Array.swift
//  GourmetSearchApp
//
//  Created by AXLT0220-AP on 2022/07/14.
//

extension Array {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
