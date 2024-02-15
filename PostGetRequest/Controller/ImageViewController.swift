//
//  ImageViewController.swift
//  PostGetRequest
//
//  Created by Руслан Забиран on 28.01.24.
//

import UIKit

private let url = "https://thispersondoesnotexist.com"

class ImageViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    public func fetchImage() {
        
        NetworkManager.downloadImage(url) { data in
            let image = UIImage(data: data)
            self.activityIndicator.stopAnimating()
            self.imageView.image = image
        }
        
    }
    
    public func fetchImageAlamofire() {
        
        AlamofireNetworkRequest.downloadImage(url) { data in
            guard let image = UIImage(data: data) else {return}
            self.activityIndicator.stopAnimating()
            self.imageView.image = image
            
        }
        
    }
    
}
