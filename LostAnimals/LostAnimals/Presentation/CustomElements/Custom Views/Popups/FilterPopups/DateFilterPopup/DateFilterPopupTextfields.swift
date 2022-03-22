//
//  DateFilterPopupTextfields.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Functions
extension DateFilterPopupViewController {
    func configureTextfields() {
        // postsPreviousToTextfield
        let postsPreviousToToolbar = UIToolbar()
        postsPreviousToToolbar.sizeToFit()
        let postsPreviousToDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(postsPreviousToDoneDatePickerPressed))
        let spacerItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        postsPreviousToToolbar.setItems([spacerItem, postsPreviousToDoneButton], animated: true)
        postsPreviousToToolbar.tintColor = .customBlack
        postsPreviousToToolbar.backgroundColor = .customWhite
        
        postsPreviousToTextfield.inputAccessoryView = postsPreviousToToolbar
        postsPreviousToDatePicker.maximumDate = .today
        postsPreviousToDatePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            postsPreviousToDatePicker.preferredDatePickerStyle = .wheels
        }
        postsPreviousToTextfield.inputView = postsPreviousToDatePicker
        postsPreviousToTextfield.text = Date.today.toString(withFormat: DateFormat.dayMonthYearOther)
        
        // postsAfterTextfield
        let postsAfterToolbar = UIToolbar()
        postsAfterToolbar.sizeToFit()
        let postsAfterDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(postsAfterDoneDatePickerPressed))
        postsAfterToolbar.setItems([spacerItem, postsAfterDoneButton], animated: true)
        postsAfterToolbar.tintColor = .customBlack
        postsAfterToolbar.backgroundColor = .customWhite
        
        postsAfterTextfield.inputAccessoryView = postsAfterToolbar
        postsAfterDatePicker.maximumDate = .today
        postsAfterDatePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            postsAfterDatePicker.preferredDatePickerStyle = .wheels
        }
        postsAfterTextfield.inputView = postsAfterDatePicker
        postsAfterTextfield.text = Date.today.toString(withFormat: DateFormat.dayMonthYearOther)
    }
}

// MARK: - Private functions
private extension DateFilterPopupViewController {
    @objc func postsPreviousToDoneDatePickerPressed() {
        postsPreviousToTextfield.text = postsPreviousToDatePicker.date.toString(withFormat: DateFormat.dayMonthYearOther)
        postsPreviousToTextfield.endEditing(true)
    }
    
    @objc func postsAfterDoneDatePickerPressed() {
        postsAfterTextfield.text = postsAfterDatePicker.date.toString(withFormat: DateFormat.dayMonthYearOther)
        postsAfterTextfield.endEditing(true)
    }
}
