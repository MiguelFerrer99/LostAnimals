//
//  Int.swift
//  OptimusPlan
//
//  Created by David Alhambra on 13/10/20.
//  Copyright © 2020 Rudo. All rights reserved.
//

import Foundation

extension Int {
  var asMinutesToHourString: String {
    let hours = self / 60
    let minutes = self % 60
    
    return String(format:"%02ih %02imin", hours, minutes)
  }
}
