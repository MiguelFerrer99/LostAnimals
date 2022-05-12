//
//  String.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/10/2021.
//  Copyright © 2020 Miguel Ferrer Fornali. All rights reserved.
//

import UIKit

extension String {
    // MARK: - Properties
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}

// MARK: - Functions
extension String {
    public func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z]([A-Z0-9a-z._-]{0,64})+[A-Z0-9a-z]+@[A-Z0-9a-z]+([A-Za-z0-9.-]{0,64})+([A-Z0-9a-z])+\\.[A-Za-z]{2,4}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        if emailPredicate.evaluate(with: self) {
            let duplicatedDotsRegEx = "(?!.*([..])\\1{1}).+"
            let emailSecondPredicate = NSPredicate(format: "SELF MATCHES %@", duplicatedDotsRegEx)
            return emailSecondPredicate.evaluate(with: self)
        }
        return false
    }
    
    func isValidPassword() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^(?=.*[a-z])(?=.*[0-9]).{8,}$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func areOnlyLetters() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^([A-Za-z]+)$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func areOnlyLettersAndSpaces() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^([A-Za-z ]+)$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func maximumCharacters(maximum: Int) -> Bool {
        return self.count <= maximum
    }
    
    func isValidPhoneNumber() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^([0-9\\s]{1,12})$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func isValidTwitterUsername() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-z0-9_]*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func isValidInstagramUsername() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9._]*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func toDate(withFormat format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self) ?? Date.today
        return date
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func drawTextIn(bgImage: UIImage, position: CGRect, textAttributes: [NSAttributedString.Key: Any]) -> UIImage? {
        let nsString = NSString(string: self)
        UIGraphicsBeginImageContext(bgImage.size)
        bgImage.draw(in: CGRect(x: 0, y: 0, width: bgImage.size.width, height: bgImage.size.height))
        nsString.draw(in: position, withAttributes: textAttributes)
        let returnedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return returnedImage
    }
    
    func getURLImage(completion: @escaping ((UIImage?) -> ())) {
        if let url = URL(string: self) {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data, error == nil, let image = UIImage(data: data) {
                    completion(image)
                } else { completion(nil) }
            }.resume()
        } else { completion(nil) }
    }
}
