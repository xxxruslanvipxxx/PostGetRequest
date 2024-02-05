//
//  CollectionViewController.swift
//  PostGetRequest
//
//  Created by Руслан Забиран on 5.02.24.
//

import UIKit

private let reuseIdentifier = "Cell"
private let url = "https://jsonplaceholder.typicode.com/posts"

enum UserActions: String, CaseIterable {
    case downloadImage = "Download Image"
    case get = "GET"
    case post = "POST"
    case ourCourses = "Our Courses"
    case uploadImage = "Upload Image"
}

class MainViewController: UICollectionViewController {

    let userActions = UserActions.allCases
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

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
            print("Upload Image")
        }
    }

}
