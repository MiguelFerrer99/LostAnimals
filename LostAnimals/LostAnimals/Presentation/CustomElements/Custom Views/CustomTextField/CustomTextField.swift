//
//  CustomTextField.swift
//  Template
//
//  Created by Toni García Alhambra on 11/03/2020.
//  Copyright © 2020 Rudo. All rights reserved.
//

import UIKit

@objc protocol CustomTextFieldDelegate: AnyObject {
  @objc optional func textFieldShouldReturn(_ customTextField: CustomTextField) -> Bool
  @objc optional func textFieldDidEndEditing(_ customTextField: CustomTextField)
  @objc optional func textFieldDidBeginEditing(_ customTextField: CustomTextField)
  func textFieldDidChange(_ customTextField: CustomTextField)
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
  
  @IBInspectable var placeholder: String = "" {
    willSet {
      textField.attributedPlaceholder = NSAttributedString(
        string: newValue,
        attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "CustomWhite")?.withAlphaComponent(0.5) ?? .white]
      )
      placeholderLabel.attributedText = textField.attributedPlaceholder
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
  
  // MARK: - Properties
  var delegate: CustomTextFieldDelegate?
  var errorsToCheck = [TextFieldError]()

  var hasError: Bool {
    for error in errorsToCheck {
      let hasError = error.checkCondition(value)
      errorLabel.text     = error.localizedDescription
      errorLabel.isHidden = !hasError
      UIView.animate(withDuration: 0.2) {
        self.statusView.isHidden = false
        self.statusImageView.image = UIImage(named: hasError ? "TextfieldBad" : "TextfieldOk")
      }
      if hasError { return false }
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
    addSubview(customView)
    textField.delegate = self
  }

  private func loadViewFromNib() -> UIView! {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    return view
  }

  func addErrorsToCheck(_ errorsToCheck: [TextFieldError]) {
    self.errorsToCheck = errorsToCheck
  }

  // MARK: - IBActions
  @IBAction func hideContentButtonPressed(_ sender: UIButton) {
    hideContentButton.setImage(UIImage(systemName: textField.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"), for: .normal)
    textField.isSecureTextEntry.toggle()
  }
  
  // MARK: - UITextFieldDelegate
  func textFieldShouldReturn(_ customTextField: UITextField) -> Bool {
    return ((delegate?.textFieldShouldReturn?(self)) != nil)
  }
  
  func textFieldDidBeginEditing(_ customTextField: UITextField) {
    delegate?.textFieldDidBeginEditing?(self)
  }

  func textFieldDidEndEditing(_ customTextField: UITextField) {
    delegate?.textFieldDidEndEditing?(self)
  }
  
  @IBAction func textFieldDidChangeEditing(_ customTextField: UITextField) {
    guard let text = customTextField.text else { return }
    UIView.animate(withDuration: 0.2) {
      self.placeholderLabel.alpha = text.isEmpty ? 0 : 1
      self.topTextFieldConstraint.constant = text.isEmpty ? 0 : 15
      self.layoutIfNeeded()
    }
    delegate?.textFieldDidChange(self)
  }
}
