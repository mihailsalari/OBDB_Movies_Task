//
//  GradientView.swift
//  OMDBAPITest
//
//  Created by Mihail Salari on 7/15/23.
//

import Foundation
import UIKit

final class GradientView: UIView {
    override func draw(_ rect: CGRect) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        
        let topColor = UIColor(white: 0, alpha: 0) // Transparent black
        let middleColor = UIColor(white: 0, alpha: 1) // Solid black
        let bottomColor = UIColor(white: 0, alpha: 0.8) // Black with alpha 0.8
        
        // Set up the colors for the gradient
        gradient.colors = [topColor.cgColor, middleColor.cgColor, middleColor.cgColor, bottomColor.cgColor]
        
        // Set up the color locations for the gradient
        let trackingHeight: CGFloat = 70.0
        gradient.locations = [0.0, NSNumber(value: trackingHeight / bounds.height), NSNumber(value: trackingHeight / bounds.height), 1.0]
        
        // Configure the direction of the gradient
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        
        // Add the gradient layer as a sublayer, but adjust its zPosition to be below other sibling views
        layer.insertSublayer(gradient, at: 0)
    }
}
