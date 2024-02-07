//
//  CollectionViewController.swift
//  PostGetRequest
//
//  Created by Руслан Забиран on 5.02.24.
//

import UIKit

private let reuseIdentifier = "Cell"
private let url = "https://jsonplaceholder.typicode.com/posts"
private let uploadUrl = "https://api.imgur.com/3/image"
private let assetImageName = "default"

enum UserActions: String, CaseIterable {
    case downloadImage = "Download Image"
    case get = "GET"
    case post = "POST"
    case ourCourses = "Our Courses"
    case uploadImage = "Upload Image"
    case downloadFile = "Download File"
}

class MainViewController: UICollectionViewController {

    let userActions = UserActions.allCases
    private var alert: UIAlertController!
    
    private func showAlert() {
        
        alert = UIAlertController(title: "Downloading...", message: "0%", preferredStyle: .alert)
        
        let height = NSLayoutConstraint(item: alert.view!,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier: 0,
                                        constant: 170)
        alert.view.addConstraint(height)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addAction(cancelAction)
        present(alert, animated: true) {
            // setup UIActivityIndicator
            let size = CGSize(width: 40, height: 40)
            let point = CGPoint(x: self.alert.view.frame.width / 2 - size.width / 2,
                                y: self.alert.view.frame.height / 2 - size.height / 2)
            let activityIndicator = UIActivityIndicatorView(frame: CGRect(origin: point, size: size))
            activityIndicator.startAnimating()
            self.alert.view.addSubview(activityIndicator)
            
            // setup UIProgressView
            let progressView = UIProgressView(frame: CGRect(x: 0,
                                                           y: self.alert.view.frame.height - 44,
                                                           width: self.alert.view.frame.width,
                                                           height: 3))
            progressView.progress = 0.5
            self.alert.view.addSubview(progressView)
            
        }
        
    }

    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CollectionViewCell {
            cell.nameLabel.text = userActions[indexPath.row].rawValue
            return cell
        }
        let errorCell = UICollectionViewCell()
        errorCell.backgroundColor = .red
        return errorCell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let action = userActions[indexPath.row]
        
        switch action {
        case .downloadImage:
            performSegue(withIdentifier: "showImageSegue", sender: self)
        case .get:
            NetworkManager.getRequest(url)
        case .post:
            NetworkManager.postRequest(url)
        case .ourCourses:
            performSegue(withIdentifier: "showCoursesSegue", sender: self)
        case .uploadImage:
            NetworkManager.uploadImage(imageName: assetImageName, url: uploadUrl)
        case .downloadFile:
            showAlert()
        }
    }

}
