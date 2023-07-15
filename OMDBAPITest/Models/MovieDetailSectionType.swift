//
//  MovieDetailSectionType.swift
//  OMDBAPITest
//
//  Created by Mihail Salari on 7/15/23.
//

import UIKit

enum MovieDetailSectionType {
    case rating(image: MovieDetailImageType, text: String)
    case general(image: MovieDetailImageType, text: String)
    case plot(image: MovieDetailImageType, text: String, font: UIFont)
    case other(image: MovieDetailImageType, text: String)
    
    var attributedString: NSAttributedString? {
        switch self {
        case let .rating(image, text):
            return createAttachment(image: image.image, text: text)
        case let .general(image, text):
            return createAttachment(image: image.image, text: text)
        case let .plot(image, text, font):
            guard let attributedString = createAttachment(image: image.image, text: text, font: font) else {
                return nil
            }
            let newAttributedString = NSMutableAttributedString()
            newAttributedString.append(NSMutableAttributedString(string: "\n"))
            newAttributedString.append(attributedString)
            newAttributedString.append(NSMutableAttributedString(string: "\n"))
            
            return newAttributedString
        case let .other(image, text):
            return createAttachment(image: image.image, text: text)
        }
    }
    
    private func createAttachment(image: UIImage?, text: String, font: UIFont = UIFont.systemFont(ofSize: 14)) -> NSAttributedString? {
        let ratingAttributes: [NSAttributedString.Key: Any] = [
            .font: font
        ]
        let ratingAttributedString = NSMutableAttributedString(string: "\n")
        
        if let image = image {
            // Create the attributed string for the rating
            let ratingAttachment = NSTextAttachment()
            ratingAttachment.image = image.withTintColor(.yellow)
            let ratingAttachmentAttributedString = NSAttributedString(attachment: ratingAttachment)
            ratingAttributedString.append(ratingAttachmentAttributedString)
        }
  
        ratingAttributedString.append(NSAttributedString(string: " "))
        ratingAttributedString.append(NSAttributedString(string: text, attributes: ratingAttributes))
        
        let newLineAttributedString = NSMutableAttributedString(string: "\n")
        ratingAttributedString.append(newLineAttributedString)
        
        return ratingAttributedString
    }
}
