//
//  PostImagesViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 7/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import UIKit

final class PostImagesViewModel {
    
    // MARK: - Properties
    private let router: PostImagesRouter
    let postImages: [UIImage?]
    let indexPostImage: Int
    
    // MARK: - Init
    required init(router: PostImagesRouter, postImages: [UIImage?], indexPostImage: Int) {
        self.router = router
        self.postImages = postImages
        self.indexPostImage = indexPostImage
    }
}

// MARK: - Life cycle
extension PostImagesViewModel {
    func viewReady() {
        // Called when view is loaded and ready
    }
    
    func viewDidAppear() {
        // Called when view has appeared
    }
}

// MARK: - Functions
extension PostImagesViewModel {
    func didPressDismissButton() {
        self.router.dismissPostImages()
    }
}
