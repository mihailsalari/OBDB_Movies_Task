//
//  ImageDownloaderManager.swift
//  OMDBAPITest
//
//  Created by Mihail Salari on 7/15/23.
//

import Foundation

protocol ImageDownloaderManagerProtocol: AnyObject {
    func downloadImage(for posterURLString: String, completion: @escaping (Result<Data, Error>) -> Void)
}

final class ImageDownloaderManager: ImageDownloaderManagerProtocol {
    private let network: NetworkManagerProtocol
    
    init(with network: NetworkManagerProtocol) {
        self.network = network
    }
    
    func downloadImage(for posterURLString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        network.downloadImage(from: posterURLString, completion: completion)
    }
}
