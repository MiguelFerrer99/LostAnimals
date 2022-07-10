//
//  CustomTextField.swift
//  Template
//
//  Created by Toni García Alhambra on 11/03/2020.
//  Copyright © 2020 Rudo. All rights reserved.
//

import UIKit

// MARK: - Protocols
@objc protocol CustomTextFieldDelegate: AnyObject {
    func textFieldShouldReturn(_ customTextField: CustomTextField) -> Bool
    func textFieldDidChange(_ customTextField: CustomTextField)
    func textFieldDidEndEditing(_ customTextField: CustomTextField)
    @objc optional func textFieldDidBeginEditing(_ customTextField: CustomTextField)
    @objc optional func textFieldWillSelectCity(_ customTextField: CustomTextField)
    @objc optional func textFieldWillSelectAddress(_ customTextField: CustomTextField)
    @objc optional func textFieldWillSelectAnimal(_ customTextField: CustomTextField)
}

@IBDesignable
class CustomTextField: UIView {
    // MARK: - IBInspectables
    @IBInspectable var capitalizeFirstLetter: Bool = false {
        willSet { textField.autocapitalizationType = newValue ? .words : .none }
    }
    @IBInspectable var hideContent: Bool = false {
        willSet {
            textField.isSecureTextEntry = newValue
            hideContentView.isHidden = !newValue
        }
    }
    @IBInspectable var whiteTheme: Bool = false {
        willSet {
            addStackView.backgroundColor = newValue ? .customWhite : .customBlack
            textField.textColor = newValue ? .customBlack : .customWhite
            textField.tintColor = newValue ? .customBlack : .customWhite
            textField.attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [NSAttributedString.Key.foregroundColor: newValue ? UIColor.customBlack.withAlphaComponent(0.5) : UIColor.customWhite.withAlphaComponent(0.5)]
            )
            placeholderLabel.attributedText = textField.attributedPlaceholder
            hideContentButton.imageView?.tintColor = newValue ? .customBlack : .customWhite
        }
    }
    @IBInspectable var placeholder: String = "" {
        willSet {
            textField.attributedPlaceholder = NSAttributedString(
                string: newValue,
                attributes: [NSAttributedString.Key.foregroundColor: whiteTheme ? UIColor.customBlack.withAlphaComponent(0.5) : UIColor.customWhite.withAlphaComponent(0.5)]
            )
            placeholderLabel.attributedText = textField.attributedPlaceholder
        }
    }
    @IBInspectable var datePickerEnabled: Bool = false {
        willSet {
            if newValue { createDatePicker(datePickerMode: .date) }
        }
    }
    @IBInspectable var dateAndTimePickerEnabled: Bool = false {
        willSet {
            if newValue { createDatePicker(datePickerMode: .dateAndTime) }
        }
    }
    @IBInspectable var cityPickerEnabled: Bool = false {
        willSet {
            selectCityButton.isHidden = !newValue
        }
    }
    @IBInspectable var addressPickerEnabled: Bool = false {
        willSet {
            selectAddressButton.isHidden = !newValue
        }
    }
    @IBInspectable var isNumberPad: Bool = false {
        willSet {
            if newValue { createNumberPadToolbar() }
        }
    }
    @IBInspectable var animalPickerEnabled: Bool = false {
        willSet {
            selectAnimalButton.isHidden = !newValue
        }
    }
    
    // MARK: - IBOutlets
    @IBOutlet private weak var customView: UIView!
    @IBOutlet private weak var addStackView: UIStackView!
    @IBOutlet private weak var placeholderLabel: UILabel!
    @IBOutlet private weak var topTextFieldConstraint: NSLayoutConstraint!
    @IBOutlet private weak var hideContentView: UIView!
    @IBOutlet private weak var hideContentButton: UIButton!
    @IBOutlet private weak var statusView: UIView!
    @IBOutlet private weak var statusImageView: UIImageView!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var selectCityButton: UIButton!
    @IBOutlet private weak var selectAddressButton: UIButton!
    @IBOutlet private weak var selectAnimalButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - Properties
    var errorsToCheck = [TextFieldError]()
    private let datePicker = UIDatePicker()
    private let passwordsAreNotEqualError = TextFieldErrorPasswordsAreNotEqual()
    weak var delegate: CustomTextFieldDelegate?
    
    var hasError: Bool {
        for error in errorsToCheck {
            let hasError = error.checkCondition(value)
            errorLabel.text = error.localizedDescription
            errorLabel.isHidden = !hasError
            statusView.isHidden = false
            statusImageView.image = UIImage(named: hasError ? "TextfieldBad" : "TextfieldOk")
            if hasError { return true }
        }
        return false
    }
    
    var value: String {
        return textField.text ?? ""
    }
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

// MARK: - Functions
extension CustomTextField {
    func didFinishSelectContentFromOtherVC() {
        textFieldDidChangeEditing(textField)
    }
    
    func addErrorsToCheck(_ errorsToCheck: [TextFieldError]) {
        self.errorsToCheck = errorsToCheck
    }
    
    func resetTextfield() {
        textField.text = nil
        errorLabel.text = nil
        errorLabel.isHidden = true
        statusView.isHidden = true
        statusImageView.image = nil
        placeholderLabel.alpha = 0
        topTextFieldConstraint.constant = 0
        layoutIfNeeded()
    }
    
    func showPasswordsAreNotEqualError() {
        errorLabel.text = passwordsAreNotEqualError.localizedDescription
        errorLabel.isHidden = false
        statusView.isHidden = false
        statusImageView.image = UIImage(named: "TextfieldBad")
    }
    
    func initEditableTextfield() {
        self.placeholderLabel.alpha = value.isEmpty ? 0 : 1
        self.topTextFieldConstraint.constant = value.isEmpty ? 0 : 15
        _ = hasError
    }
}

// MARK: - Private functions
private extension CustomTextField {
    func setup() {
        customView = loadViewFromNib()
        customView.frame = bounds
        customView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth,
                                       UIView.AutoresizingMask.flexibleHeight]
        addStackView.layer.cornerRadius = 10
        textField.keyboardAppearance = .light
        textField.delegate = self
        addSubview(customView)
    }
    
    func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func createDatePicker(datePickerMode: UIDatePicker.Mode) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneDatePickerPressed))
        let spacerItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spacerItem, doneButton], animated: true)
        toolbar.tintColor = .customBlack
        toolbar.backgroundColor = .customWhite
        textField.inputAccessoryView = toolbar
        datePicker.maximumDate = Date()
        datePicker.datePickerMode = datePickerMode
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        textField.inputView = datePicker
    }
    
    func createNumberPadToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneNumberPadPressed))
        let spacerItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spacerItem, doneButton], animated: true)
        toolbar.tintColor = .customBlack
        toolbar.backgroundColor = .customWhite
        textField.inputAccessoryView = toolbar
    }
    
    @objc func doneDatePickerPressed() {
        textField.text = datePicker.date.toString(withFormat: datePickerEnabled ? DateFormat.dayMonthYearOther : DateFormat.dayMonthYearHourOther)
        textFieldDidChangeEditing(textField)
        textField.endEditing(true)
    }
    
    @objc func doneNumberPadPressed() {
        textField.endEditing(true)
        let _ = textFieldShouldReturn(self.textField)
    }
}

// MARK: - IBActions
private extension CustomTextField {
    @IBAction func hideContentButtonPressed(_ sender: UIButton) {
        hideContentButton.setImage(UIImage(systemName: textField.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"), for: .normal)
        textField.isSecureTextEntry.toggle()
    }
    
    @IBAction func textFieldDidChangeEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2) {
            self.placeholderLabel.alpha = self.value.isEmpty ? 0 : 1
            self.topTextFieldConstraint.constant = self.value.isEmpty ? 0 : 15
            self.layoutIfNeeded()
        }
        delegate?.textFieldDidChange(self)
    }
    
    @IBAction func selectCityButtonPressed(_ sender: UIButton) {
        delegate?.textFieldWillSelectCity?(self)
    }
    
    @IBAction func selectAddressButtonPressed(_ sender: UIButton) {
        delegate?.textFieldWillSelectAddress?(self)
    }
    
    @IBAction func selectAnimalButtonPressed(_ sender: UIButton) {
        delegate?.textFieldWillSelectAnimal?(self)
    }
}

// MARK: - UITextFieldDelegate
extension CustomTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return ((delegate?.textFieldShouldReturn(self)) != nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.textFieldDidBeginEditing?(self)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.textFieldDidEndEditing(self)
    }
}
