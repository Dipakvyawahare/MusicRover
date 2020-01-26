//
//  RequestService.swift
//  MusicRover
//
//  Created by Dipak V. Vyawahare on 25/01/20.
//  Copyright © 2020 MyOrganization. All rights reserved.
//

import Foundation

let endPoint = "http://api.deezer.com"
//let searchArtist = URL(string: "http://api.deezer.com/search/artist?q=kygo")!
//let artistAlbums = URL(string: "http://api.deezer.com/artist/8706544/albums")!
//let albumInfo = URL(string: "http://api.deezer.com/album/125657812")!
//let albumTracks = URL(string: "http://api.deezer.com/album/125657812/tracks")!

protocol RequestServiceProtocol {
    @discardableResult func fetchData(for path: String,
                                      queryParmas: [String: String],
                                      completion: @escaping (
        (Result<Data, ErrorResult>) -> Void)) -> URLSessionDataTask?
}

final class RequestService: RequestServiceProtocol {
    static let shared = RequestService()
    private init() {}
    
    lazy var session: URLSession = {
        let session = URLSession(configuration: URLSessionConfiguration.default,
                                 delegate: nil,
                                 delegateQueue: OperationQueue.main)
        return session
    }()
    
    @discardableResult func fetchData(for path: String,
                                      queryParmas: [String: String],
                                      completion: @escaping (
        (Result<Data, ErrorResult>) -> Void)) -> URLSessionDataTask? {
        guard let apiUrl = URLBuilder(url: endPoint)
            .set(path: path)
            .addQueryItems(queries: queryParmas)
            .build() else {
                print("Invalid URL")
                return nil
        }
        let request = URLRequest(url: apiUrl)
        if let reachability = Reachability(), !reachability.isReachable {
            completion(.failure(.network(string: "No Netwok connection!")))
            return nil
        }
        let task = session.dataTask(with: request) { (data, _, error) in
            if let error = error {
                switch error {
                case _ where (error as NSError).code == NSURLErrorCancelled:
                    break
                default:
                    let msg =  "An error occured during request :" + error.localizedDescription
                    completion(.failure(.parser(string: msg)))
                }
                return
            }
            
            if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
        return task
    }
}
