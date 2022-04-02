//
//  PostViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import UIKit

final class PostViewController: ViewController, UIGestureRecognizerDelegate {
    // MARK: - IBOutlets
    @IBOutlet private weak var savePostImageView: UIImageView!
    @IBOutlet private weak var postScrollView: UIScrollView!
    @IBOutlet private weak var postTypeImageView: UIImageView!
    @IBOutlet private weak var postTypeLabel: UILabel!
    @IBOutlet private weak var animalNameView: CustomView!
    @IBOutlet private weak var animalNameLabel: UILabel!
    @IBOutlet private weak var animalBreedLabel: UILabel!
    @IBOutlet private weak var animalBreedView: CustomView!
    @IBOutlet private weak var lastTimeSeenAndLocationStackView: UIStackView!
    @IBOutlet private weak var lastTimeSeenLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var descriptionTextView: UITextView!
    @IBOutlet private weak var descriptionView: CustomView!
    @IBOutlet private weak var authorView: CustomView!
    @IBOutlet private weak var animalShelterImageView: UIImageView!
    @IBOutlet private weak var authorPhotoImageView: UIImageView!
    @IBOutlet private weak var authorNameLabel: UILabel!
    @IBOutlet private weak var authorAgeLabel: UILabel!
    @IBOutlet private weak var authorAddressLabel: UILabel!
    @IBOutlet private weak var contactWithAuthorButton: UIButton!
    @IBOutlet weak var postImagesCollectionView: UICollectionView!
    @IBOutlet weak var postImagesPageControl: UIPageControl!
    
    // MARK: - Properties
    override var navBarTitle: String {
        switch viewModel.post.postType {
        case .lost:
            return viewModel.post.animalName ?? "Lost animal"
        case .found:
            return "Found animal"
        case .adopt:
            return viewModel.post.animalName ?? "To adopt animal"
        }
    }
    override var hideNavigationBar: Bool {
        return shouldHideNavigationBar
    }
    var shouldHideNavigationBar: Bool {
        return postScrollView.contentOffset.y < 20
    }
    var viewModel: PostViewModel!
    var savePostBarButtonItem = UIBarButtonItem()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel.viewReady()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.viewDidAppear()
    }
}

// MARK: - Functions
extension PostViewController {
    func presentActivityVC(postImageToShare: UIImage) {
        let activityViewController = UIActivityViewController(activityItems: [postImageToShare], applicationActivities: nil)
        self.present(viewController: activityViewController, completion: nil)
    }
}

// MARK: - Private functions
private extension PostViewController {
    func unsubscribeToNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupUI() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        setNavBarButtons()
        configureScrollView(postScrollView)
        configureCollectionView(postImagesCollectionView)
        fillUI()
    }
    
    func setNavBarButtons() {
        let optionsBarButtonItem = UIBarButtonItem(image: UIImage(named: "PostOptions"),
                                                   style: .plain,
                                                   target: self,
                                                   action: #selector(optionsBarButtonPressed))
        savePostBarButtonItem = UIBarButtonItem(image: UIImage(named: viewModel.post.saved ? "SavePostFilled" : "SavePost"),
                                                style: .plain,
                                                target: self,
                                                action: #selector(savePostBarButtonPressed))
        self.navigationItem.rightBarButtonItems = [optionsBarButtonItem, savePostBarButtonItem]
    }
    
    func fillUI() {
        guard let user = viewModel.user else { return }
        
        postTypeImageView.image = UIImage(named: "\(viewModel.post.animalType.rawValue)")
        switch viewModel.post.postType {
        case .lost:
            postTypeLabel.text = "Lost animal"
        case .found:
            postTypeLabel.text = "Found animal"
            animalNameView.isHidden = true
        case .adopt:
            postTypeLabel.text = "To adopt animal"
            lastTimeSeenAndLocationStackView.isHidden = true
        }
        
        animalNameLabel.text = viewModel.post.animalName
        animalBreedLabel.text = viewModel.post.animalBreed
        descriptionTextView.text = viewModel.post.description
        authorPhotoImageView.image = user.userImage
        authorNameLabel.text = "\(user.firstname) \(user.lastname)"
        authorAddressLabel.text = user.location.address
        if let authorAge = viewModel.getAge() { authorAgeLabel.text = "\(authorAge) years old" }
        lastTimeSeenLabel.text = viewModel.post.lastTimeSeen
        locationLabel.text = viewModel.post.location.address
        contactWithAuthorButton.setTitle("Contact with \(user.firstname)", for: .normal)
        
        if User.shared == user {
            authorView.isHidden = true
            contactWithAuthorButton.isHidden = true
        }
        animalShelterImageView.isHidden = !user.animalShelter
    }
    
    func updateSavedPostUI() {
        guard let savePostBarButtonItemImage = savePostBarButtonItem.image,
              let savePostImageViewImage = savePostImageView.image
        else { return }
        
        savePostBarButtonItem.image = savePostBarButtonItemImage.isEqualTo(image: UIImage(named: "SavePost")) ? UIImage(named: "SavePostFilled") : UIImage(named: "SavePost")
        savePostImageView.image = savePostImageViewImage.isEqualTo(image: UIImage(named: "SavePostWhite")) ? UIImage(named: "SavePostFilled") : UIImage(named: "SavePostWhite")
    }
    
    func savePost() {
        viewModel.didPressSavePostButton { allowed in
            if allowed { updateSavedPostUI() }
        }
    }
    
    @objc func savePostBarButtonPressed() {
        savePost()
    }
    
    @objc func optionsBarButtonPressed() {
        viewModel.didPressOptionsButton()
    }
}

// MARK: - IBActions
private extension PostViewController {
    @IBAction func backButtonPressed(_ sender: UIButton) {
        viewModel.didPressBackButton()
    }
    
    @IBAction func savePostButtonPressed(_ sender: UIButton) {
        savePost()
    }
    
    @IBAction func postOptionsButtonPressed(_ sender: UIButton) {
        viewModel.didPressOptionsButton()
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        viewModel.didPressLocation()
    }
    
    @IBAction func authorButtonPressed(_ sender: UIButton) {
        viewModel.didPressAuthor()
    }
    
    @IBAction func contactWithAuthorButtonPressed(_ sender: UIButton) {
        viewModel.didPressContactWithAuthor()
    }
}
