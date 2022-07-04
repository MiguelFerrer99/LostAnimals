//
//  MyPetViewModel.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/7/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Enums
enum MyPetField {
    case name
    case type
    case breed
    case description
}

final class MyPetViewModel {
    // MARK: - Properties
    private let router: MyPetRouter
    let myPet: Pet?
    var postImages: [UIImage] = []
    var numberOfTextFields = 2
    var editedTextFields = [CustomTextField]()
    var selectPhotoImageViews: [UIImageView] = []
    var selectedIndexImageView = 0
    var currentPetValues: [MyPetField: String] = [:]
    var newPetValues: [MyPetField: String] = [:]
    var imagesModified = false
    
    // MARK: - Services
    let userService = UserService()
    
    // MARK: - Init
    required init(router: MyPetRouter, myPet: Pet?) {
        self.router = router
        self.myPet = myPet
        if let myPet = myPet {
            self.currentPetValues[.name] = myPet.name
            self.currentPetValues[.type] = myPet.type.rawValue
            self.currentPetValues[.breed] = myPet.breed ?? ""
            self.currentPetValues[.description] = myPet.description ?? ""
            self.newPetValues = currentPetValues
        }
    }
}

// MARK: - Life cycle
extension MyPetViewModel {
    func viewReady() {
        // Called when view is loaded and ready
    }
    
    func viewDidAppear() {
        // Called when view has appeared
    }
}

// MARK: - Functions
extension MyPetViewModel {
    func textFieldsHaveErrors() -> Bool {
        var haveErrors = false
        editedTextFields.forEach { editedTextField in
            if editedTextField.hasError && !haveErrors { haveErrors = true }
        }
        return haveErrors
    }
    
    func getImagesFromURLImages(completion: @escaping (() -> ())) {
        guard let myPet = myPet else { return }
        if let petURLImage1 = myPet.urlImage1 {
            petURLImage1.getURLImage(completion: { image1 in
                if let image1 = image1 { self.postImages.append(image1) }
                
                if let petURLImage2 = myPet.urlImage2 {
                    petURLImage2.getURLImage(completion: { image2 in
                        if let image2 = image2 { self.postImages.append(image2) }
                        
                        if let petURLImage3 = myPet.urlImage3 {
                            petURLImage3.getURLImage(completion: { image3 in
                                if let image3 = image3 { self.postImages.append(image3) }
                                
                                if let petURLImage4 = myPet.urlImage4 {
                                    petURLImage4.getURLImage(completion: { image4 in
                                        if let image4 = image4 { self.postImages.append(image4) }
                                        
                                        if let petURLImage5 = myPet.urlImage5 {
                                            petURLImage5.getURLImage(completion: { image5 in
                                                if let image5 = image5 { self.postImages.append(image5) }
                                                
                                                if let petURLImage6 = myPet.urlImage6 {
                                                    petURLImage6.getURLImage(completion: { image6 in
                                                        if let image6 = image6 { self.postImages.append(image6) }
                                                        
                                                        if let petURLImage7 = myPet.urlImage7 {
                                                            petURLImage7.getURLImage(completion: { image7 in
                                                                if let image7 = image7 { self.postImages.append(image7) }
                                                                
                                                                if let petURLImage8 = myPet.urlImage8 {
                                                                    petURLImage8.getURLImage(completion: { image8 in
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
    
    func dismiss() {
        self.router.goBack()
    }
    
    func didPressSelectPhotoButton() {
        guard let selectPhotoImageView = selectPhotoImageViews[selectedIndexImageView].image else { return }
        self.router.goToSelectPhotoPopup(showRemoveOption: !selectPhotoImageView.isEqualTo(image: UIImage(named: "SelectPhotoPlaceholder")))
    }
    
    func didPressAnimalTypeButton() {
        self.router.goToAnimalTypes(comesFrom: .newPost)
    }
    
    func didPressLostYourPetButton() {
        guard let myPet = myPet, let me = User.shared else { return }
        let postToLoad = Post(id: "",
                              postType: .lost,
                              animalName: myPet.name,
                              animalType: myPet.type,
                              animalBreed: myPet.breed,
                              urlImage1: myPet.urlImage1,
                              urlImage2: myPet.urlImage2,
                              urlImage3: myPet.urlImage3,
                              urlImage4: myPet.urlImage4,
                              urlImage5: myPet.urlImage5,
                              urlImage6: myPet.urlImage6,
                              urlImage7: myPet.urlImage7,
                              urlImage8: myPet.urlImage8,
                              lastTimeSeen: "",
                              location: Location(address: "", coordinates: nil),
                              description: myPet.description,
                              userID: me.id,
                              createdAt: Date())
        self.router.dismissAndGoToNewLostPost(postToLoad: postToLoad)
    }
    
    func didPressRemoveMyPetDataButton(finishedOK: @escaping (() -> Void), finishedKO: @escaping (() -> Void)) {
        guard let myPet = myPet else { return }
        userService.deleteMyPet(pet: myPet) { result in
            switch result {
            case .success: finishedOK()
            case .error(let error):
                finishedKO()
                showErrorPopup(title: error)
            }
        }
    }
    
    func didPressSaveChangesButton(myPet: Pet?, finishedOK: @escaping (() -> Void), finishedKO: @escaping (() -> Void)) {
        if let myPet = myPet {
            self.userService.addMyPet(myPet: myPet, images: getImagesFromImageViews()) { result in
                switch result {
                case .success: finishedOK()
                case .error(let error):
                    finishedKO()
                    showErrorPopup(title: error)
                }
            }
        } else {
            finishedKO()
            showErrorPopup(title: .ServiceErrors.Unexpected())
        }
    }
}
