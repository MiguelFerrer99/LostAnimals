//
//  NotificationName.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 20/12/21.
//  Copyright © 2021 Rudo. All rights reserved.
//

import Foundation

// MARK: - Notifications
extension Notification.Name {
    static let SendWhereDoYouLiveToSignUp = Notification.Name("SendWhereDoYouLiveToSignUp")
    static let SendWhereDoYouLiveToEditPersonalDetails = Notification.Name("SendWhereDoYouLiveToEditPersonalDetails")
    
    static let UpdateExplorePosts = Notification.Name("UpdateExplorePosts")
    static let UpdateUserAndUpdateExplorePosts = Notification.Name("UpdateUserAndUpdateExplorePosts")
}
