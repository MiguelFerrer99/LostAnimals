//
//  PostOptionsPopupViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Enums
enum PostComesFrom: String {
    case explore
    case profile
}

final class PostOptionsPopupViewModel {
    // MARK: - Properties
    private let router: PostOptionsPopupRouter
    let comesFrom: PostComesFrom
    let post: Post
    let user: User
    
    // MARK: - Init
    required init(router: PostOptionsPopupRouter, comesFrom: PostComesFrom, post: Post, user: User) {
        self.router = router
        self.comesFrom = comesFrom
        self.post = post
        self.user = user
    }
}

// MARK: - Life cycle
extension PostOptionsPopupViewModel {
    func viewReady() {
        // Called when view is loaded and ready
    }
    
    func viewDidAppear() {
        // Called when view has appeared
    }
}

// MARK: - Functions
extension PostOptionsPopupViewModel {
    func didPressDismissButton() {
        self.router.dismissPostOptionsPopup()
    }
    
    func didPressEditPostButton() {
        self.router.dismissPostOptionsPopupAndGoToEditPost()
    }
    
    func didPressBlockUserButton() {
        if Cache.get(boolFor: .logged) {
            self.router.dismissPostOptionsPopupAndShowSuccessPopup()
        } else {
            self.router.dismissPostOptionsPopupAndShowGuestPopup()
        }
    }
    
    func didPressSharePostButton() {
        guard let imageToShare = createImageToShare() else { return }
        self.router.dismissPostOptionsAndShowActivityViewController(postImageToShare: imageToShare)
    }
    
    func createImageToShare() -> UIImage? {
        // Variables
        var bgImage: UIImage?
        var firstText: String
        var secondText: String
        
        // Text attributes
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let mainTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.customWhite,
            .font: UIFont.nunitoBigBlack,
            .paragraphStyle: paragraphStyle
        ]
        let otherTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.customWhite.withAlphaComponent(0.6),
            .font: UIFont.nunitoSmallBold,
            .paragraphStyle: paragraphStyle
        ]
        
        // Setup variables
        switch post.postType {
        case .lost:
            bgImage = UIImage(named: "LostAnimalImageToShare")
            firstText = post.location.address
            secondText = post.lastTimeSeen
        case .found:
            bgImage = UIImage(named: "FoundAnimalImageToShare")
            firstText = post.location.address
            secondText = post.lastTimeSeen
        case .adopt:
            bgImage = UIImage(named: "ToAdoptAnimalImageToShare")
            firstText = user.firstname
            secondText = user.location.address
        }
        
        // Basic images
        guard let clearBg = UIImage(named: "ClearBackgroundImageToShare"),
              let postImage = post.images.first,
              let bgImage = bgImage
        else { return nil }
        
        // Clear background
        guard let returnedImage1 = postImage.drawImageIn(bgImage: clearBg,
                                                           position: CGRect(x: clearBg.size.width/2 - 180, y: clearBg.size.height/2 - 313, width: 360, height: 360))
        else { return nil }
        
        // Basic background
        guard let returnedImage2 = bgImage.drawImageIn(bgImage: returnedImage1,
                                                       position: CGRect(x: 0, y: 0, width: returnedImage1.size.width, height: returnedImage1.size.height))
        else { return nil }
        
        // Animal name
        let name: String = post.animalName ?? ""
        guard let returnedImage3 = name.drawTextIn(bgImage: returnedImage2,
                                                   position: CGRect(x: 70, y: 215, width: returnedImage2.size.width - 140, height: returnedImage2.size.height),
                                                   textAttributes: mainTextAttributes)
        else { return nil }
        
        // Lost in
        guard let returnedImage4 = firstText.drawTextIn(bgImage: returnedImage3,
                                                        position: CGRect(x: 70, y: returnedImage3.size.height/2 + 125, width: returnedImage3.size.width - 140, height: returnedImage3.size.height),
                                                        textAttributes: otherTextAttributes)
        else { return nil }
        
        // Lost on
        guard let returnedImage5 = secondText.drawTextIn(bgImage: returnedImage4,
                                                         position: CGRect(x: 70, y: returnedImage4.size.height/2 + 245, width: returnedImage4.size.width - 140, height: returnedImage4.size.height),
                                                         textAttributes: otherTextAttributes)
        else { return nil }
        
        return returnedImage5
    }
}
