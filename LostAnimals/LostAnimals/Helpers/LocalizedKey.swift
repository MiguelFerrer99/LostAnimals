//
//  LocalizedKey.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/10/2021.
//  Copyright © 2020 Miguel Ferrer Fornali. All rights reserved.
//

import UIKit

extension UILabel {
    static var localizedKey:UInt8 = 0
    @IBInspectable public var localizationKey: String? {
        set {
            objc_setAssociatedObject(self, &UILabel.localizedKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            return objc_getAssociatedObject(self, &UILabel.localizedKey) as? String
        }
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        if let localizationKey = self.localizationKey {
            text = NSLocalizedString(localizationKey, comment: "")
        }
    }
}

extension UIButton {
    static var localizedKey:UInt8 = 0
    @IBInspectable public var localizationKey: String? {
        set {
            objc_setAssociatedObject(self, &UIButton.localizedKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            return objc_getAssociatedObject(self, &UIButton.localizedKey) as? String
        }
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        if let localizationKey = self.localizationKey {
            setTitle(NSLocalizedString(localizationKey, comment: ""), for: .normal)
        }
    }
}

extension UIBarItem {
    static var localizedKey:UInt8 = 0
    @IBInspectable public var localizationKey: String? {
        set {
            objc_setAssociatedObject(self, &UIBarItem.localizedKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            return objc_getAssociatedObject(self, &UIBarItem.localizedKey) as? String
        }
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        if let localizationKey = self.localizationKey {
            
            title = NSLocalizedString(localizationKey, comment: "")
        }
    }
}
