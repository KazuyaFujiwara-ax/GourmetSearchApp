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
    
    /* WIP
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
    
    // グルメサーチAPIリクエスト
    func request() {
        guard let url = URL(string: createRequestUrl(parameter: parameter)) else {
            return
        }
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            guard error == nil else {
                let alert = UIAlertController(title: "通信エラー", message: "通信に失敗しました。\n再度取得しますか？", preferredStyle: .alert)
                
                // WIP: アラートアクションの設定をする
                let okAction = UIAlertAction(title: "OK", style: .default) { action in
                    print("test yes")
                    alert.dismiss(animated: true, completion: nil)
                }
                let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { action in
                    print("test cancel")
                    alert.dismiss(animated: true, completion: nil)
                }
                alert.addAction(okAction)
                alert.addAction(cancelAction)
                
                DispatchQueue.main.async {
                    UIViewController().present(alert, animated: true, completion: nil)
                }
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(GourmetSearchResult.self, from: data)
                shopDataArray.append(contentsOf: results.results.shop)
            } catch let error {
                print("## error: \(error)")
            }
            
            //DispatchQueue.main.async {
            //    self.tableView.reloadData()
            //}
        }
        task.resume()
    }
    */
}
