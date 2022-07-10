//
//  NewPostGenericViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 17/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Enums
enum PostType: String {
    case lost = "Lost"
    case found = "Found"
    case adopt = "Adopt"
    
    func toDTO() -> String {
        self.rawValue.lowercased()
    }
}

final class NewPostGenericViewModel {
    // MARK: - Properties
    private let router: NewPostGenericRouter
    var numberOfTextFields = 0
    var editedTextFields = [CustomTextField]()
    let postType: PostType
    let postToLoad: Post?
    var postImages: [UIImage] = []
    var selectPhotoImageViews: [UIImageView] = []
    var selectedIndexImageView = 0
    var newPostLocation = Location(address: .Commons.NotSpecifiedFemale(), coordinates: nil)
    var selectedAnimalType: AnimalType? = nil
    
    // MARK: - Services
    let postService = PostService()
    
    // MARK: - Init
    required init(router: NewPostGenericRouter, postType: PostType, postToLoad: Post? = nil) {
        self.router = router
        self.postType = postType
        self.postToLoad = postToLoad
        switch postType {
        case .lost:
            numberOfTextFields = 4
        case .found:
            numberOfTextFields = 3
        case .adopt:
            numberOfTextFields = 2
        }
        if let postToLoad = postToLoad { selectedAnimalType = postToLoad.animalType }
    }
}

// MARK: - Life cycle
extension NewPostGenericViewModel {
    func viewReady() {
        // Called when view is loaded and ready
    }
    
    func viewDidAppear() {
        // Called when view has appeared
    }
}

// MARK: - Functions
extension NewPostGenericViewModel {
    func textFieldsHaveErrors() -> Bool {
        var haveErrors = false
        editedTextFields.forEach { editedTextField in
            if editedTextField.hasError && !haveErrors { haveErrors = true }
        }
        return haveErrors
    }
    
    func getImagesFromURLImages(completion: @escaping (() -> ())) {
        guard let postToLoad = postToLoad else { return }
        if let postURLImage1 = postToLoad.urlImage1 {
            postURLImage1.getURLImage(completion: { image1 in
                if let image1 = image1 { self.postImages.append(image1) }
                
                if let postURLImage2 = postToLoad.urlImage2 {
                    postURLImage2.getURLImage(completion: { image2 in
                        if let image2 = image2 { self.postImages.append(image2) }
                        
                        if let postURLImage3 = postToLoad.urlImage3 {
                            postURLImage3.getURLImage(completion: { image3 in
                                if let image3 = image3 { self.postImages.append(image3) }
                                
                                if let postURLImage4 = postToLoad.urlImage4 {
                                    postURLImage4.getURLImage(completion: { image4 in
                                        if let image4 = image4 { self.postImages.append(image4) }
                                        
                                        if let postURLImage5 = postToLoad.urlImage5 {
                                            postURLImage5.getURLImage(completion: { image5 in
                                                if let image5 = image5 { self.postImages.append(image5) }
                                                
                                                if let postURLImage6 = postToLoad.urlImage6 {
                                                    postURLImage6.getURLImage(completion: { image6 in
                                                        if let image6 = image6 { self.postImages.append(image6) }
                                                        
                                                        if let postURLImage7 = postToLoad.urlImage7 {
                                                            postURLImage7.getURLImage(completion: { image7 in
                                                                if let image7 = image7 { self.postImages.append(image7) }
                                                                
                                                                if let postURLImage8 = postToLoad.urlImage8 {
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
    
    func getImagesFromImageViews() -> [UIImage?] {
        var images: [UIImage] = []
        selectPhotoImageViews.forEach { imageView in
            imageView.transform.rotated(by: .pi / 2)
            if let image = imageView.image, !image.isEqualTo(image: UIImage(named: "SelectPhotoPlaceholder")) {
                images.append(image)
            }
        }
        return images
    }
    
    func reloadPosts() {
        NotificationCenter.default.post(name: .UpdateExplorePosts, object: nil)
        NotificationCenter.default.post(name: .UpdateMyPosts, object: nil)
    }
    
    func goBack() {
        showConfirmationPopup(title: .NewPostGeneric.AreYouSureExit()) {
            self.router.goBack()
        }
    }
    
    func close() {
        showConfirmationPopup(title: .NewPostGeneric.AreYouSureExit()) {
            self.router.close()
        }
    }
    
    func didPressSelectPhotoButton() {
        guard let selectPhotoImageView = selectPhotoImageViews[selectedIndexImageView].image else { return }
        self.router.goToSelectPhotoPopup(showRemoveOption: !selectPhotoImageView.isEqualTo(image: UIImage(named: "SelectPhotoPlaceholder")))
    }
    
    func didPressAnimalTypeButton() {
        self.router.goToAnimalTypes(comesFrom: .newPost)
    }
    
    func didPressLocationButton() {
        self.router.goToWhereCanWeFindYou()
    }
    
    func didPressPublishPostButton(newPost: Post?, completion: @escaping (() -> Void)) {
        if let newPost = newPost {
            self.postService.uploadPost(post: newPost, images: getImagesFromImageViews()) { result in
                switch result {
                case .success:
                    self.reloadPosts()
                    showSuccessPopup(title: .NewPostGeneric.PostPublished()) {
                        self.router.goBackToTabBar()
                    }
                    completion()
                case .error(let error):
                    showErrorPopup(title: error)
                    completion()
                }
            }
        } else {
            showErrorPopup(title: .ServiceErrors.Unexpected())
            completion()
        }
    }
}
