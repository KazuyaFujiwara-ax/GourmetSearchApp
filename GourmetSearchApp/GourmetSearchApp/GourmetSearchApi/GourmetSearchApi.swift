//
//  RequestGourmetSearchApi.swift
//  GourmetSearchApp
//
//  Created by AXLT0220-AP on 2022/05/29.
//

import UIKit

class GourmetSearchApi {
    private let entryUrl = "http://webservice.recruit.co.jp/hotpepper/gourmet/v1/"
    private let parameter = ["key": apiKey, "large_area": "Z011", "count": "50", "format": "json"]
    
    // パラメータ文字列作成
    private func encodeParameter(key: String, value: String) -> String? {
        guard let escapedValue = value.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            return nil
        }
        return "\(key)=\(escapedValue)"
    }
    
    // リクエストURL作成
    private func createRequestUrl(parameter: [String: String]) -> String {
        var parameterString = ""
        for key in parameter.keys {
            guard let value = parameter[key] else {
                continue
            }
            if parameterString.lengthOfBytes(using: String.Encoding.utf8) > 0 {
                parameterString += "&"
            }
            guard let encodeValue = encodeParameter(key: key, value: value) else {
                continue
            }
            parameterString += encodeValue
        }
        return entryUrl + "?" + parameterString
    }
    
    // 通信失敗時のアラート
    private func showAlert(vc: ShopListViewController, completion: @escaping ([ShopData]) -> Void) {
        // アラートコントローラを作成
        let alert = UIAlertController(title: "通信エラー", message: "通信に失敗しました。\n再度取得しますか？", preferredStyle: .alert)
        
        // アラートアクションを設定（OKなら通信をリトライ、キャンセルなら何もしない）
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            self.request(vc: vc, completion: completion)
            vc.dismiss(animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { action in
            vc.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        // アラートを表示
        DispatchQueue.main.async {
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    // グルメサーチAPIリクエスト
    func request(vc: ShopListViewController, completion: @escaping ([ShopData]) -> Void) {
        guard let url = URL(string: self.createRequestUrl(parameter: parameter)) else {
            return
        }
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            guard error == nil else {
                self.showAlert(vc: vc, completion: completion)
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                var shopDataArray = [ShopData]()
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let results = try jsonDecoder.decode(GourmetSearchResult.self, from: data)
                shopDataArray.append(contentsOf: results.results.shop)
                completion(shopDataArray)
            } catch let error {
                print("## error: \(error)")
            }
        }
        task.resume()
    }
}
