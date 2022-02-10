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
    @IBOutlet weak var savePostImageView: UIImageView!
    @IBOutlet weak var postScrollView: UIScrollView!
    @IBOutlet weak var postImagesCollectionView: UICollectionView!
    @IBOutlet weak var postImagesPageControl: UIPageControl!
    @IBOutlet weak var postTypeImageView: UIImageView!
    @IBOutlet weak var postTypeLabel: UILabel!
    @IBOutlet weak var animalNameView: CustomView!
    @IBOutlet weak var animalNameLabel: UILabel!
    @IBOutlet weak var animalBreedLabel: UILabel!
    @IBOutlet weak var animalBreedView: CustomView!
    @IBOutlet weak var lastTimeSeenAndLocationStackView: UIStackView!
    @IBOutlet weak var lastTimeSeenLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var descriptionView: CustomView!
    @IBOutlet weak var authorView: CustomView!
    @IBOutlet weak var animalShelterImageView: UIImageView!
    @IBOutlet weak var authorPhotoImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var authorAgeLabel: UILabel!
    @IBOutlet weak var authorAddressLabel: UILabel!
    @IBOutlet weak var contactWithAuthorButton: UIButton!
    
    // MARK: - Properties
    override var navBarTitle: String {
        switch viewModel.post.postType {
        case .lost:
            return viewModel.post.animal.name ?? "Lost animal"
        case .found:
            return "Found animal"
        case .adopt:
            return viewModel.post.animal.name ?? "To adopt animal"
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
    
    // MARK: - Functions    
    private func unsubscribeToNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupUI() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        setNavBarButtons()
        configureScrollView(postScrollView)
        configureCollectionView(postImagesCollectionView)
        fillUI()
    }
    
    private func setNavBarButtons() {
        let optionsBarButtonItem = UIBarButtonItem(image: UIImage(named: "PostOptions"),
                                                   style: .plain,
                                                   target: self,
                                                   action: #selector(optionsBarButtonPressed))
        savePostBarButtonItem = UIBarButtonItem(image: UIImage(named: viewModel.post.isSaved ? "SavePostFilled" : "SavePost"),
                                                style: .plain,
                                                target: self,
                                                action: #selector(savePostBarButtonPressed))
        self.navigationItem.rightBarButtonItems = [optionsBarButtonItem, savePostBarButtonItem]
    }
    
    private func fillUI() {
        postTypeImageView.image = UIImage(named: "\(viewModel.post.animal.type.rawValue)")
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
        
        animalNameLabel.text = viewModel.post.animal.name
        animalBreedLabel.text = viewModel.post.animal.breed == nil ? "Not specified" : viewModel.post.animal.breed
        descriptionTextView.text = viewModel.post.description == nil ? "Without description" : viewModel.post.description
        authorPhotoImageView.image = viewModel.post.author.profileImage
        authorNameLabel.text = "\(viewModel.post.author.firstname) \(viewModel.post.author.lastname)"
        authorAddressLabel.text = viewModel.post.author.location.address
        if let authorAge = viewModel.getAge() { authorAgeLabel.text = "\(authorAge) years old" }
        
        if let lastTimeSeen = viewModel.post.lastTimeSeen {
            lastTimeSeenLabel.text = lastTimeSeen.toString(withFormat: DateFormat.dayMonthYearHourOther)
        }
        if let location = viewModel.post.location {
            locationLabel.text = location.address
        }
        
        contactWithAuthorButton.setTitle("Contact with \(viewModel.post.author.firstname)", for: .normal)
        
        if let me = User.shared, me.id == viewModel.post.author.id {
            authorView.isHidden = true
            contactWithAuthorButton.isHidden = true
        }
        animalShelterImageView.isHidden = !viewModel.post.author.isAnimalShelter
    }
    
    private func updateSavedPostUI() {
        guard let savePostBarButtonItemImage = savePostBarButtonItem.image,
              let savePostImageViewImage = savePostImageView.image
        else { return }
        
        savePostBarButtonItem.image = savePostBarButtonItemImage.isEqualTo(image: UIImage(named: "SavePost")) ? UIImage(named: "SavePostFilled") : UIImage(named: "SavePost")
        savePostImageView.image = savePostImageViewImage.isEqualTo(image: UIImage(named: "SavePostWhite")) ? UIImage(named: "SavePostFilled") : UIImage(named: "SavePostWhite")
    }
    
    private func savePost() {
        viewModel.didPressSavePostButton { allowed in
            if allowed { updateSavedPostUI() }
        }
    }
    
    @objc private func savePostBarButtonPressed() {
        savePost()
    }
    
    @objc private func optionsBarButtonPressed() {
        viewModel.didPressOptionsButton()
    }
    
    func presentActivityVC(postImageToShare: UIImage) {
        let activityViewController = UIActivityViewController(activityItems: [postImageToShare], applicationActivities: nil)
        self.present(viewController: activityViewController, completion: nil)
    }
    
    // MARK: - IBActions
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
