//
//  XibView.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 12/6/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import UIKit

open class XibView: UIView {
    public var view: UIView?
    public var groupedAccessibilityElements: [Any]?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.xibSetup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.xibSetup()
    }
    
    private func xibSetup() {
        self.view = self.loadViewFromNib()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.view ?? UIView())
        self.view?.fullFit()
    }
    
    private var bundle: Bundle? {
        let bundle = Bundle(for: type(of: self))
        guard let bundleName = bundle.bundleIdentifier?.split(separator: ".").last else { return nil }
        let bundleURL = bundle.url(forResource: String(bundleName), withExtension: "bundle")
        return bundleURL.flatMap(Bundle.init)
    }
    
    private func loadViewFromNib() -> UIView {
        guard let bundle = self.bundle else { return UIView() }
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil)[0] as? UIView ?? UIView()
    }
}
