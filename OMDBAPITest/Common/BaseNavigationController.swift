//
//  BaseNavigationController.swift
//  OMDBAPITest
//
//  Created by Mihail Salari on 7/15/23.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.prefersLargeTitles = true
    }
}
