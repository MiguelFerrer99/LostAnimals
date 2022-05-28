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
    private var postURLImages: [String] = []
    let post: Post
    let comesFrom: PostComesFrom
    var isLoadingPostImages = true
    var postImages: [UIImage] = []
    var user: User?
    
    // MARK: - Services
    let userService = UserService()
    
    // MARK: - Init
    required init(router: PostRouter, comesFrom: PostComesFrom, post: Post) {
        self.router = router
        self.comesFrom = comesFrom
        self.post = post
        if let postURLImage1 = post.urlImage1 { postURLImages.append(postURLImage1) }
        if let postURLImage2 = post.urlImage2 { postURLImages.append(postURLImage2) }
        if let postURLImage3 = post.urlImage3 { postURLImages.append(postURLImage3) }
        if let postURLImage4 = post.urlImage4 { postURLImages.append(postURLImage4) }
        if let postURLImage5 = post.urlImage5 { postURLImages.append(postURLImage5) }
        if let postURLImage6 = post.urlImage6 { postURLImages.append(postURLImage6) }
        if let postURLImage7 = post.urlImage7 { postURLImages.append(postURLImage7) }
        if let postURLImage8 = post.urlImage8 { postURLImages.append(postURLImage8) }
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
    func getAuthorInfo(completion: @escaping ((GenericResult) -> Void)) {
        userService.getUser(id: post.userID) { result in
            switch result {
            case .success(let author):
                self.user = author
                completion(.success)
            case .error(let error):
                showErrorPopup(title: error) { self.router.goBack() }
            }
        }
    }
    
    func getImagesFromURLImages(completion: @escaping (() -> ())) {
        if let postURLImage1 = postURLImages[safe: 0] {
            postURLImage1.getURLImage(completion: { image1 in
                if let image1 = image1 { self.postImages.append(image1) }
                
                if let postURLImage2 = self.postURLImages[safe: 1] {
                    postURLImage2.getURLImage(completion: { image2 in
                        if let image2 = image2 { self.postImages.append(image2) }
                        
                        if let postURLImage3 = self.postURLImages[safe: 2] {
                            postURLImage3.getURLImage(completion: { image3 in
                                if let image3 = image3 { self.postImages.append(image3) }
                                
                                if let postURLImage4 = self.postURLImages[safe: 3] {
                                    postURLImage4.getURLImage(completion: { image4 in
                                        if let image4 = image4 { self.postImages.append(image4) }
                                        
                                        if let postURLImage5 = self.postURLImages[safe: 4] {
                                            postURLImage5.getURLImage(completion: { image5 in
                                                if let image5 = image5 { self.postImages.append(image5) }
                                                
                                                if let postURLImage6 = self.postURLImages[safe: 5] {
                                                    postURLImage6.getURLImage(completion: { image6 in
                                                        if let image6 = image6 { self.postImages.append(image6) }
                                                        
                                                        if let postURLImage7 = self.postURLImages[safe: 6] {
                                                            postURLImage7.getURLImage(completion: { image7 in
                                                                if let image7 = image7 { self.postImages.append(image7) }
                                                                
                                                                if let postURLImage8 = self.postURLImages[safe: 7] {
                                                                    postURLImage8.getURLImage(completion: { image8 in
                                                                        if let image8 = image8 { self.postImages.append(image8) }
                                                                        completion()
                                                                    })
                                                                } else { completion() }
                                                            })
                                                        } else { completion() }
                                                    })
                                                } else { completion() }
                                            })
                                        } else { completion() }
                                    })
                                } else { completion() }
                            })
                        } else { completion() }
                    })
                } else { completion() }
            })
        } else { completion() }
    }
    
    func getAge() -> Int? {
        guard let user = user, let auxBirthdateString = user.birthdate else { return nil }
        let auxBirthdate = auxBirthdateString.toDate(withFormat: DateFormat.dayMonthYearOther)
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
        self.router.goToPostImages(postImages: postImages, indexPostImages: indexPostImage)
    }
    
    func didPressLocation() {
        guard let coordinates = post.location.coordinates else { return }
        self.router.goToLocation(coordinates: coordinates, animalName: post.animalName)
    }
    
    func didPressAuthor() {
        guard let user = user else { return }
        User.shared == user ? self.router.goToMyProfile() : self.router.goToAuthorProfile(user: user)
    }
    
    func didPressContactWithAuthor() {
        guard let user = user else { return }
        User.shared == user ? self.router.goToMyProfile() : self.router.showContactWithPopup(authorSocialMedias: user.socialMedias)
    }
    
    func didPressSavePostButton(allowed: ((Bool) -> ())) {
        let logged = Cache.get(boolFor: .logged)
        if logged {
            allowed(true)
        } else {
            showGuestPopup()
            allowed(false)
        }
    }
    
    func didPressOptionsButton() {
        guard let user = user, let postImage = postImages[safe: 0] else { return }
        self.router.goToPostOptionsPopup(comesFrom: comesFrom, post: post, user: user, postImage: postImage)
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
    
    func showErrorPopupFromPostOptionsPopup(error: String) {
        showErrorPopup(title: error, action: nil)
    }
}
