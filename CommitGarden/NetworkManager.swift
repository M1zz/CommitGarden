//
//  NetworkManager.swift
//  CommitGarden
//
//  Created by hyunho lee on 6/22/23.
//

import Foundation
import NotificationCenter

protocol MyURLSessionDataDelegate: class {
    func myUrlSession(_ session: URLSession, didReceive data: Data)
    
    func myUrlSession(_ session: URLSession, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void)
    
    func myUrlSession(_ session: URLSession, didCompleteWithError error: Error?)
}

class MyNetworkManager {
    weak var delegate: MyURLSessionDataDelegate!
    private var isSuccuess: Bool = false

    func dataTask(with url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //print("completed data : \(String(data: data!, encoding: .utf8))")
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode),
                  let mimeType = response.mimeType,
                  mimeType == "text/html" else {
                NotificationCenter.default.post(name: Notification.Name("Receive"),
                                                object: nil,
                                                userInfo: ["reseponseResult":self.isSuccuess])
                return
            }
            
            self.isSuccuess = true
            NotificationCenter.default.post(name: Notification.Name("Receive"), object: data, userInfo: ["reseponseResult":self.isSuccuess])
        }.resume()

    }
}
