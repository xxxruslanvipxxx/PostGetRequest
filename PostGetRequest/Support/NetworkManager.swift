//
//  NetworkManager.swift
//  PostGetRequest
//
//  Created by Руслан Забиран on 5.02.24.
//

//import UIKit
import UIKit

class NetworkManager {
    
    static func downloadImage(_ url: String, completion: @escaping (Data) -> Void) {
        
        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    completion(data)
                }
            }
        }.resume()
    }
    
    static func getRequest(_ url: String) {
        guard let url = URL(string: url) else { return }
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            guard
                let response = response,
                    let data = data
            else {return}
            print(response)
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
        
    }
    
    static func postRequest(_ url: String) {
        guard let url = URL(string: url) else { return }
        let userData = ["Name": "Jeffrey", "Surname": "Epstein"]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: userData) else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response else {return}
            print(response)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    public func fetchData(url: String, completion: @escaping ([Course]) -> Void) {
        guard let url = URL(string: url) else {return}
        
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            guard let data = data else {return}
            if let courses = self.parseData(with: data) {
                completion(courses)
            }
        }.resume()
    }
    
    private func parseData(with data: Data) -> [Course]? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let courses = try decoder.decode([Course].self, from: data)
            return courses
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func uploadImage(url: String) {
        
        let image = UIImage(named: "default")!
        let httpHeaders = ["Autorization": "Client-ID bc172cceefa4123"]
        guard let imageProperties = ImageProperties(withImage: image, forKey: "image") else { return }
        
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = httpHeaders
        request.httpBody = imageProperties.data
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    
    }
    
}
