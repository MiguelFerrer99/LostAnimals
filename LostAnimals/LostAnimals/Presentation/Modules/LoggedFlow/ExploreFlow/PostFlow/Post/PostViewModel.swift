//
//  PostViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class PostViewModel {
    // MARK: - Properties
    private let router: PostRouter
    let comesFrom: PostComesFrom
    let post: Post
    var isSaved: Bool
    var user: User?
    
    // MARK: - Init
    required init(router: PostRouter, comesFrom: PostComesFrom, post: Post) {
        self.router = router
        self.comesFrom = comesFrom
        self.post = post
        self.isSaved = post.saved
    }
}

// MARK: - Life cycle
extension PostViewModel {
    func viewReady() {
        // Called when view is loaded and ready
    }
    
    func viewDidAppear() {
        // Called when view has appeared
    }
}

// MARK: - Functions
extension PostViewModel {
    func getAge() -> Int? {
        guard let user = user,
              let auxBirthdateString = user.birthdate,
              let auxBirthdate = auxBirthdateString.toDate(withFormat: DateFormat.dayMonthYearOther)
        else { return nil }
        let birthdate = DateComponents(year: auxBirthdate.year,
                                       month: auxBirthdate.month,
                                       day: auxBirthdate.day)
        let now = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let ageComponents = Calendar.current.dateComponents([.year], from: birthdate, to: now)
        
        return ageComponents.year
    }
    
    func didPressBackButton() {
        self.router.goBack()
    }
    
    func didPressPostImage(indexPostImage: Int) {
        self.router.goToPostImages(postImages: post.images, indexPostImages: indexPostImage)
    }
    
    func didPressLocation() {
        guard let coordinates = post.location.coordinates else { return }
        self.router.goToLocation(coordinates: coordinates, animalName: post.animalName)
    }
    
    func didPressAuthor() {
        guard let user = user else { return }
        self.router.goToAuthorProfile(user: user)
    }
    
    func didPressContactWithAuthor() {
        guard let user = user else { return }
        self.router.showContactWithPopup(authorSocialMedias: user.socialMedias)
    }
    
    func didPressSavePostButton(allowed: ((Bool) -> ())) {
        let logged = Cache.get(boolFor: .logged)
        if logged {
            isSaved.toggle()
            allowed(true)
        } else {
            showGuestPopup()
            allowed(false)
        }
    }
    
    func didPressOptionsButton() {
        guard let user = user else { return }
        self.router.goToPostOptionsPopup(comesFrom: comesFrom, post: post, user: user)
    }
    
    func didPressEditPostButton() {
        self.router.goToEditPost(post: post)
    }
    
    func showGuestPopupFromPostOptionsPopup() {
        showGuestPopup()
    }
    
    func showSuccessPopupFromPostOptionsPopup() {
        showSuccessPopup(title: "The user has been blocked successfully", action: nil)
    }
    
    func showErrorPopupFromPostOptionsPopup() {
        showErrorPopup(title: "An unexpected error occured. Please, try again later", action: nil)
    }
}
