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
class TextFieldErrorEmailFormat: TextFieldError {
    // MARK: - Init
    init() {
        super.init(localizedDescription: .TextFieldErrors.EmailFormat()) { (value) -> Bool in
            return !value.isValidEmail()
        }
    }
}

class TextFieldErrorEmptyValue: TextFieldError {
    // MARK: - Init
    init() {
        super.init(localizedDescription: .TextFieldErrors.EmptyField()) { (value) -> Bool in
            return value.isEmpty
        }
    }
}

class TextFieldErrorPasswordFormat: TextFieldError {
    // MARK: - Init
    init() {
        super.init(localizedDescription: .TextFieldErrors.PasswordFormat()) { (value) -> Bool in
            return !value.isValidPassword()
        }
    }
}

class TextFieldErrorPasswordsAreNotEqual: TextFieldError {
    // MARK: - Init
    init() {
        super.init(localizedDescription: .TextFieldErrors.PasswordsDifferent()) { (value) -> Bool in
            return true
        }
    }
}

class TextFieldErrorOnlyLettersAndSpaces: TextFieldError {
    // MARK: - Init
    init() {
        super.init(localizedDescription: .TextFieldErrors.OnlyLettersAndSpaces()) { (value) -> Bool in
            return !value.areOnlyLettersAndSpaces()
        }
    }
}

class TextFieldErrorMinimumCharacters: TextFieldError {
    // MARK: - Init
    init(_ minimum: Int) {
        super.init(localizedDescription: .TextFieldErrors.MinimumCharacters.localized(with: minimum)) { (value) -> Bool in
            return value.count < minimum
        }
    }
}

class TextFieldErrorMaximumCharacters: TextFieldError {
    // MARK: - Init
    init(_ maximum: Int) {
        super.init(localizedDescription: .TextFieldErrors.MaximumCharacters.localized(with: maximum)) { (value) -> Bool in
            return value.count > maximum
        }
    }
}

class TextFieldErrorPhoneNumber: TextFieldError {
    // MARK: - Init
    init() {
        super.init(localizedDescription: .TextFieldErrors.InvalidFormat()) { (value) -> Bool in
            return !value.isValidPhoneNumber()
        }
    }
}
