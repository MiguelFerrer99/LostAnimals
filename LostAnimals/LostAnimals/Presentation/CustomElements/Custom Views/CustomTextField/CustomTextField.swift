//
//  CustomTextField.swift
//  Template
//
//  Created by Toni García Alhambra on 11/03/2020.
//  Copyright © 2020 Rudo. All rights reserved.
//

import UIKit

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
class CustomTextField: UIView, UITextFieldDelegate {
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
  @IBOutlet var customView: UIView!
  @IBOutlet weak var addStackView: UIStackView!
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var placeholderLabel: UILabel!
  @IBOutlet weak var topTextFieldConstraint: NSLayoutConstraint!
  @IBOutlet weak var hideContentView: UIView!
  @IBOutlet weak var hideContentButton: UIButton!
  @IBOutlet weak var statusView: UIView!
  @IBOutlet weak var statusImageView: UIImageView!
  @IBOutlet weak var errorLabel: UILabel!
  @IBOutlet weak var selectCityButton: UIButton!
  @IBOutlet weak var selectAddressButton: UIButton!
  @IBOutlet weak var selectAnimalButton: UIButton!
  
  // MARK: - Properties
  var delegate: CustomTextFieldDelegate?
  var errorsToCheck = [TextFieldError]()
  let datePicker = UIDatePicker()
  let passwordsAreNotEqualError = TextFieldErrorPasswordsAreNotEqual()
  
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
  
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: - Functions
  private func setup() {
    customView = loadViewFromNib()
    customView.frame = bounds
    customView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth,
                                   UIView.AutoresizingMask.flexibleHeight]
    addStackView.layer.cornerRadius = 10
    textField.keyboardAppearance = .light
    textField.delegate = self
    addSubview(customView)
  }
  
  private func loadViewFromNib() -> UIView! {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    return view
  }
  
  private func createDatePicker(datePickerMode: UIDatePicker.Mode) {
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneDatePickerPressed))
    let spacerItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    toolbar.setItems([spacerItem, doneButton], animated: true)
    toolbar.tintColor = .customBlack
    toolbar.backgroundColor = .customWhite
    textField.inputAccessoryView = toolbar
    datePicker.maximumDate = .today
    datePicker.datePickerMode = datePickerMode
    if #available(iOS 13.4, *) {
      datePicker.preferredDatePickerStyle = .wheels
    }
    textField.inputView = datePicker
  }
  
  @objc private func doneDatePickerPressed() {
    textField.text = datePicker.date.toString(withFormat: datePickerEnabled ? DateFormat.dayMonthYearOther : DateFormat.dayMonthYearHourOther)
    textFieldDidChangeEditing(textField)
    textField.endEditing(true)
  }
  
  private func createNumberPadToolbar() {
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneNumberPadPressed))
    let spacerItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    toolbar.setItems([spacerItem, doneButton], animated: true)
    toolbar.tintColor = .customBlack
    toolbar.backgroundColor = .customWhite
    textField.inputAccessoryView = toolbar
  }
  
  @objc private func doneNumberPadPressed() {
    textField.endEditing(true)
    let _ = textFieldShouldReturn(self.textField)
  }
  
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
    self.placeholderLabel.alpha = 1
    self.topTextFieldConstraint.constant = 15
    self.statusView.isHidden = false
    self.statusImageView.image = UIImage(named: "TextfieldOk")
  }
  
  // MARK: - IBActions
  @IBAction func hideContentButtonPressed(_ sender: UIButton) {
    hideContentButton.setImage(UIImage(systemName: textField.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"), for: .normal)
    textField.isSecureTextEntry.toggle()
  }
  
  // MARK: - UITextFieldDelegate
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    return ((delegate?.textFieldShouldReturn(self)) != nil)
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    delegate?.textFieldDidBeginEditing?(self)
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    delegate?.textFieldDidEndEditing(self)
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
