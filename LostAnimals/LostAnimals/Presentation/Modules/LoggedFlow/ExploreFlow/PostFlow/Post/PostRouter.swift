//
//  PostRouter.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

final class PostRouter {
    // MARK: - Properties
    private weak var viewController: PostViewController?
    
    // MARK: - Init
    required init(viewController: PostViewController?) {
        self.viewController = viewController
    }
}

// MARK: - Functions
extension PostRouter {
    func goBack() {
        DispatchQueue.main.async {
            self.viewController?.pop()
        }
    }
    
    func goToMyProfile() {
        self.viewController?.delegate?.goToMyProfile()
    }
    
    func goToPostImages(postImages: [UIImage?], indexPostImages: Int) {
        DispatchQueue.main.async {
            let viewController = Container.shared.postImagesBuilder().build(postImages: postImages, indexPostImage: indexPostImages)
            self.viewController?.present(viewController: viewController, completion: nil)
        }
    }
    
    func goToLocation(coordinates: Coordinates, animalName: String? = nil) {
        DispatchQueue.main.async {
            let viewController = Container.shared.locationBuilder().build(coordinates: coordinates, animalName: animalName)
            self.viewController?.push(viewController: viewController)
        }
    }
    
    func goToAuthorProfile(user: User) {
        DispatchQueue.main.async {
            let viewController = Container.shared.profileBuilder().build(user: user)
            viewController.hidesBottomBarWhenPushed = true
            self.viewController?.push(viewController: viewController)
        }
    }
    
    func showContactWithPopup(authorSocialMedias: [SocialMediaType: String]) {
        DispatchQueue.main.async {
            let viewController = Container.shared.contactWithPopupBuilder().build(authorSocialMedias: authorSocialMedias)
            self.viewController?.present(viewController: viewController, completion: nil)
        }
    }
    
    func goToPostOptionsPopup(comesFrom: PostComesFrom, post: Post, user: User, postImage: UIImage) {
        DispatchQueue.main.async {
            let viewController = Container.shared.postOptionsPopupBuilder().build(comesFrom: comesFrom, post: post, user: user, postImage: postImage)
            viewController.delegate = self.viewController
            self.viewController?.present(viewController: viewController, completion: nil)
        }
    }
    
    func goToEditPost(post: Post) {
        DispatchQueue.main.async {
            let viewController = Container.shared.editPostBuilder().build(post: post)
            self.viewController?.push(viewController: viewController)
        }
    }
}
