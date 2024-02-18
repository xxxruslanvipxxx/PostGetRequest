//
//  AlamofireNetworkRequest.swift
//  PostGetRequest
//
//  Created by Руслан Забиран on 12.02.24.
//

import Foundation
import Alamofire

class AlamofireNetworkRequest {
    
    static var onProgress: ((Float) -> Void)?
    static var completed: ((String) -> Void)?
    
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
    
    static func downloadImageWithProgress(_ url: String, completion: @escaping (Data) -> Void) {
        
        AF.request(url)
            .validate()
            .downloadProgress { progress in
                print("totalUnitCount: \(progress.totalUnitCount)")
                print("completedUnitCount: \(progress.completedUnitCount)")
                print("fractionCompleted: \(progress.fractionCompleted)")
                print("localizedDescription: \(progress.localizedDescription!)")
                print("-------------------------------------------")
                self.onProgress?(Float(progress.fractionCompleted))
                self.completed?(progress.localizedDescription)
            }.responseData { response in
                switch response.result {
                case .success(let data):
                    completion(data)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    //MARK: - Another response methods
    
    static func responseString(url: String) {
        // return string
        AF.request(url)
            .validate()
            .responseString { response in
            switch response.result {
            case .success(let string):
                print(string)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func response(url: String) {
        
        AF.request(url)
            .validate()
            .response { response in
                guard
                    let data = response.data,
                    let string = String(data: data, encoding: .utf8) 
                else {return}
                print(string)
            }
    }
    
}
