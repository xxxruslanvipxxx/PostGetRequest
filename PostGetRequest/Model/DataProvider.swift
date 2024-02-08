//
//  DataProvider.swift
//  PostGetRequest
//
//  Created by Руслан Забиран on 7.02.24.
//

import UIKit

final class DataProvider: NSObject {

    private var downloadTask: URLSessionDownloadTask!
    var fileLocation: ((URL)->())?
    var onProgress: ((Double)->())?
    
    private lazy var bgSession: URLSession = {
        let config = URLSessionConfiguration.background(withIdentifier: "rusl.PostGetRequest")
        config.isDiscretionary = true // system choose optimal time to start task (false by default)
        config.waitsForConnectivity = true // session wait for network connection  (true by default)
        config.sessionSendsLaunchEvents = true // allows session to launch app in background
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()
    
    func startDownload() {

        if let url = URL(string: "https://singapore.downloadtestfile.com/100MB.bin") {
            downloadTask = bgSession.downloadTask(with: url)
            downloadTask.earliestBeginDate = Date().addingTimeInterval(3)
            downloadTask.countOfBytesClientExpectsToSend = 512
            downloadTask.countOfBytesClientExpectsToReceive = 100 * 1024 * 1024
            downloadTask.resume()
        }
        
    }
    
    func stopDownload() {
        downloadTask.cancel()
    }
}


extension DataProvider: URLSessionDelegate {
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        
        DispatchQueue.main.async {
            guard
                let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                let completionHandler = appDelegate.bgSessionCompletionHandler
            else { return }
            appDelegate.bgSessionCompletionHandler = nil
            completionHandler()
        }
        
    }
    
}

extension DataProvider: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Did finish downloading: \(location.absoluteString)")
        
        DispatchQueue.main.async { [weak self] in
            self?.fileLocation?(location)
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        guard totalBytesExpectedToWrite != NSURLSessionTransferSizeUnknown else { return }
        
        let progress = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
        print("Download progress: \(progress)")
        
        DispatchQueue.main.async { [weak self] in
            self?.onProgress?(progress)
        }
    }
}
