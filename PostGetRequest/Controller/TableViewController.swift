//
//  TableViewController.swift
//  PostGetRequest
//
//  Created by Руслан Забиран on 31.01.24.
//

import UIKit

private let url = "https://swiftbook.ru//wp-content/uploads/api/api_courses"

class TableViewController: UITableViewController {

    private var courses = [Course]()
    private var courseName: String?
    private var courseURL: String?

    func fetchData() {
        
        NetworkManager().fetchData(url: url) { courses in
            self.courses = courses
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func configureCell(cell: CourseCell, indexPath: IndexPath) {
        let course = courses[indexPath.row]
        cell.courseName.text = course.name
        
        if let numberOfLessons = course.numberOfLessons {
            cell.numberOfLessons.text = "Number of lessons: \(numberOfLessons)"
        }
        if let numberOfTests = course.numberOfTests {
            cell.numberOfTests.text = "Number of tests: \(numberOfTests)"
        }
        DispatchQueue.global().async {
            guard let imageUrlString = course.imageUrl, let url = URL(string: imageUrlString) else {return}
            guard let imageData = try? Data(contentsOf: url) else {return}
            
            DispatchQueue.main.async {
                let image = UIImage(data: imageData)
                cell.courseImage.image = image
            }
        }
    
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let webViewController = segue.destination as! WebViewController

        webViewController.selectedCourse = courseName
        if let url = courseURL {
            webViewController.courseURL = url
        }
    }
    
}

// MARK: - Table view data source
extension TableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell") as! CourseCell
        configureCell(cell: cell, indexPath: indexPath)
        return cell
    }

}


//MARK: - Table view delegate
extension TableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let course = courses[indexPath.row]
        
        courseName = course.name
        courseURL = course.link
        
        performSegue(withIdentifier: "showWebView", sender: self)
        
    }
    
}
