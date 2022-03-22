//
//  CustomTextField-Models.swift
//  Template
//
//  Created by Toni García Alhambra on 11/03/2020.
//  Copyright © 2020 Rudo. All rights reserved.
//

class TextFieldError {
    // MARK: - Properties
    let localizedDescription: String
    let checkCondition: ((String) -> Bool)
    
    // MARK: - Init
    init(localizedDescription: String, checkCondition: @escaping ((String) -> Bool)) {
        self.localizedDescription = localizedDescription
        self.checkCondition       = checkCondition
    }
}

// MARK: - Errors
class TextFieldErrorMinimumCharacters: TextFieldError {
    // MARK: - Properties
    let minCharacters: Int
    
    // MARK: - Init
    init(_ minCharacters: Int) {
        self.minCharacters = minCharacters
        
        super.init(localizedDescription: "Minimum \(minCharacters) characters") { (value) -> Bool in
            return value.count < minCharacters
        }
    }
}

class TextFieldErrorEmailFormat: TextFieldError {
    // MARK: - Init
    init() {
        super.init(localizedDescription: "Invalid email format") { (value) -> Bool in
            return !value.isValidEmail()
        }
    }
}

class TextFieldErrorEmptyValue: TextFieldError {
    // MARK: - Init
    init() {
        super.init(localizedDescription: "Empty field") { (value) -> Bool in
            return value.isEmpty
        }
    }
}

class TextFieldErrorPasswordFormat: TextFieldError {
    // MARK: - Init
    init() {
        super.init(localizedDescription: "Invalid password format") { (value) -> Bool in
            return !value.isValidPassword()
        }
    }
}

class TextFieldErrorPasswordsAreNotEqual: TextFieldError {
    // MARK: - Init
    init() {
        super.init(localizedDescription: "Passwords are not equal") { (value) -> Bool in
            return true
        }
    }
}

class TextFieldErrorOnlyLettersAndSpaces: TextFieldError {
    // MARK: - Init
    init() {
        super.init(localizedDescription: "The field may contain only letters and spaces") { (value) -> Bool in
            return !value.areOnlyLettersAndSpaces()
        }
    }
}

class TextFieldErrorMaximumCharacters: TextFieldError {
    // MARK: - Init
    init(_ maximum: Int) {
        super.init(localizedDescription: "The field can contain maximum \(maximum) characters") { (value) -> Bool in
            return !value.maximumCharacters(maximum: maximum)
        }
    }
}

class TextFieldErrorPhoneNumber: TextFieldError {
    // MARK: - Init
    init() {
        super.init(localizedDescription: "Invalid phone number format") { (value) -> Bool in
            return !value.isValidPhoneNumber()
        }
    }
}
