//
//  URL+getImage.swift
//  GourmetSearchApp
//
//  Created by AXLT0220-AP on 2022/07/14.
//

import UIKit

extension URL {
    func getImage(completion: @escaping (UIImage) -> Void) {
        let request = URLRequest(url: self)
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
            completion(image)
        }
        task.resume()
    }
}
