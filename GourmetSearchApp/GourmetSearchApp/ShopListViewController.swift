//
//  ShopListViewController.swift
//  
//
//  Created by AXLT0220-AP on 2022/04/27.
//

import UIKit

class ShopListViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    private var shopDataArray = [ShopData]()
    private let entryUrl: String = "http://webservice.recruit.co.jp/hotpepper/gourmet/v1/"
    private let parameter = ["key": apiKey, "large_area": "Z011", "count": "50", "format": "json"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NavigationBarのタイトル設定
        self.navigationItem.title = "東京都の店舗一覧"
        
        // TableViewの設定
        tableView.delegate = self
        tableView.dataSource = self
        
        // TableViewCellの登録（店舗一覧セル）
        let nib = UINib(nibName: "ShopListCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ShopListCell")
        
        shopDataArray.removeAll()
        request(requestUrl: createRequestUrl(parameter: parameter))
    }
    
    // WIP: リクエスト関連は別ファイルに移管する予定
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
        let requestUrl = entryUrl + "?" + parameterString
        return requestUrl
    }
    
    // リクエスト
    private func request(requestUrl: String) {
        guard let url = URL(string: requestUrl) else {
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
                    self.dismiss(animated: true, completion: nil)
                }
                let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { action in
                    print("test cancel")
                    self.dismiss(animated: true, completion: nil)
                }
                alert.addAction(okAction)
                alert.addAction(cancelAction)
                
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(GourmetSearchResult.self, from: data)
                self.shopDataArray.append(contentsOf: results.results.shop)
            } catch let error {
                print("## error: \(error)")
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
}

extension ShopListViewController: UITableViewDelegate {
    // 画面遷移
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let shopDetailViewController = ShopDetailViewController()
        shopDetailViewController.navigationItem.title = shopDataArray[indexPath.row].name
        self.navigationController?.pushViewController(shopDetailViewController, animated: true)
    }
}

extension ShopListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShopListCell", for: indexPath) as? ShopListCell else { return UITableViewCell() }
        cell.setCellData(shopData: shopDataArray[indexPath.row])
        return cell
    }
}
