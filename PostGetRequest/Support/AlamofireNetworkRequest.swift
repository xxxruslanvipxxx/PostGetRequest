//
//  AlamofireNetworkRequest.swift
//  PostGetRequest
//
//  Created by Руслан Забиран on 12.02.24.
//

import Foundation
import Alamofire

class AlamofireNetworkRequest {
    
    static func sendRequest(withUrl urlString: String, completion: @escaping ([Course]) -> ()) {
        
        guard let url = URL(string: urlString) else {return}
        
        AF.request(url)
            .validate()
            .responseDecodable(of: [Course].self) { response in
            switch response.result {
            case .success(let res):
                completion(res)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
//        AF.request(url).responseJSON { response in
//            
//            guard let statusCode = response.response?.statusCode else { return }
//            
//            print("STATUS CODE: ", statusCode)
//            
//            if (200..<300).contains(statusCode) {
//                let value = response.value
//                print("VALUE: ", value ?? "nil")
//            } else {
//                let error = response.error
//                print("ERROR: ", error ?? "nil")
//            }
//            
//        }
    }
    
    static func downloadImage(_ url: String, completion: @escaping (Data) -> Void) {
        
        AF.request(url)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    completion(data)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        
    }
    
}
