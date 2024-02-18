//
//  ImageViewController.swift
//  PostGetRequest
//
//  Created by Руслан Забиран on 28.01.24.
//

import UIKit

private let url = "https://thispersondoesnotexist.com"
private let largeImageUrl = "https://onlinetestcase.com/wp-content/uploads/2023/06/10.4-MB.png"

class ImageViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var completedLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        self.completedLabel.isHidden = true
        self.progressView.isHidden = true
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
    
    public func downloadImageWithProgress() {
        
        AlamofireNetworkRequest.onProgress = { progress in
            self.progressView.isHidden = false
            self.progressView.setProgress(progress, animated: true)
        }
        
        AlamofireNetworkRequest.completed = { completed in
            self.completedLabel.isHidden = false
            self.completedLabel.text = completed
        }
        
        AlamofireNetworkRequest.downloadImageWithProgress(largeImageUrl) { data  in
            guard let image = UIImage(data: data) else {return}
            self.activityIndicator.stopAnimating()
            self.progressView.isHidden = true
            self.completedLabel.isHidden = true
            self.imageView.image = image
        }
    }
    
}
