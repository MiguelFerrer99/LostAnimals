//
//  CustomButton.swift
//  Chatripp
//
//  Created by Toni García Alhambra on 11/10/2019.
//  Copyright © 2019 rudo. All rights reserved.
//

import UIKit
@IBDesignable class CustomButton: UIButton {
    // MARK: - IBInspectable
    @IBInspectable var fullRound: Bool = false {
        willSet {
            round(newValue)
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        willSet {
            setCornerRadius(of: newValue)
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        willSet {
            setBorderWidth(newValue)
        }
    }
    
    @IBInspectable var borderColor: UIColor = .clear {
        willSet {
            setBorderColor(newValue)
        }
    }
    
    @IBInspectable var tintedImage: UIImage? = nil {
        willSet {
            setTitedImage(newValue)
        }
    }
    
    @IBInspectable var indicatorColor: UIColor = .white
    
    // MARK: - Properties
    var originalButtonText: String?
    var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Functions
    func round(_ round: Bool) {
        layer.cornerRadius = round ? frame.height / 2 : cornerRadius
    }
    
    func setCornerRadius(of radius: CGFloat) {
        if fullRound { return }
        
        layer.cornerRadius = radius
    }
    
    func setBorderWidth(_ borderWidth: CGFloat) {
        layer.borderWidth = borderWidth
    }
    
    func setBorderColor(_ color: UIColor) {
        layer.borderColor = color.cgColor
    }
    
    func setTitedImage(_ image: UIImage?) {
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        setImage(tintedImage, for: .normal)
    }
    
    func showLoading() {
        isEnabled = false
        setTitle("", for: .normal)
        originalButtonText = titleLabel?.text
        
        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }
        
        showSpinning()
    }
    
    func hideLoading() {
        setTitle(originalButtonText, for: .normal)
        activityIndicator.stopAnimating()
        activityIndicator = nil
        isEnabled = true
    }
    
    // MARK: - Private functions
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = indicatorColor
        return activityIndicator
    }
    
    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        centerActivityIndicatorInButton()
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: activityIndicator,
                                                   attribute: .centerX,
                                                   multiplier: 1,
                                                   constant: 0)
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: activityIndicator,
                                                   attribute: .centerY,
                                                   multiplier: 1,
                                                   constant: 0)
        self.addConstraint(yCenterConstraint)
    }
}
