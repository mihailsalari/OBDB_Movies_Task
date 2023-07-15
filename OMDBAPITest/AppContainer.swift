//
//  AppContainer.swift
//  OMDBAPITest
//
//  Created by Mihail Salari on 7/14/23.
//

import Foundation
import Swinject

struct AppContainer {
    static let `default`: Container = {
        let container = Container()
        
        // Register your services and dependencies here
        container.register(NetworkManagerProtocol.self) { _ in
            NetworkManager()
        }
        
        container.register(ImageDownloaderManagerProtocol.self) { c in
            let network = c.resolve(NetworkManagerProtocol.self)!
            return ImageDownloaderManager(with: network)
        }
        
        container.register(MoviesServiceProtocol.self) { c in
            let network = c.resolve(NetworkManagerProtocol.self)!
            return MoviesService(with: network)
        }
                
        return Container(parent: container)
    }()
}
