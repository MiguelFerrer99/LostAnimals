//
//  PostViewController.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 3/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

// MARK: - Protocols
protocol GoToMyProfileFromPostDelegate: AnyObject {
    func goToMyProfile()
}

final class PostViewController: ViewController, UIGestureRecognizerDelegate {
    // MARK: - IBOutlets
    @IBOutlet private weak var savePostImageView: UIImageView!
    @IBOutlet weak var savePostButton: UIButton!
    @IBOutlet private weak var savePostButtonView: UIView!
    @IBOutlet private weak var optionsButtonView: UIView!
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
    @IBOutlet private weak var authorButton: UIButton!
    @IBOutlet private weak var loadingAuthorInfoView: UIView!
    @IBOutlet private weak var authorInfoStackView: UIStackView!
    @IBOutlet private weak var animalShelterImageView: UIImageView!
    @IBOutlet private weak var authorPhotoImageView: UIImageView!
    @IBOutlet private weak var authorNameLabel: UILabel!
    @IBOutlet private weak var authorAgeLabel: UILabel!
    @IBOutlet private weak var authorAddressLabel: UILabel!
    @IBOutlet private weak var contactWithAuthorButton: CustomButton!
    @IBOutlet private var savePostButtonViewConstraint: NSLayoutConstraint!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var breedLabel: UILabel!
    @IBOutlet private weak var lastTimeSeenTitleLabel: UILabel!
    @IBOutlet private weak var locationTitleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
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
    override var navBarRightButtons: [UIBarButtonItem] {
        savePostBarButtonItem = UIBarButtonItem(image: UIImage(named: "SavePost"),
                                                style: .plain,
                                                target: self,
                                                action: #selector(savePostBarButtonPressed))
        return [savePostBarButtonItem]
    }
    override var hideNavigationBar: Bool {
        return shouldHideNavigationBar
    }
    var shouldHideNavigationBar: Bool {
        return postScrollView.contentOffset.y < 20
    }
    var viewModel: PostViewModel!
    var savePostBarButtonItem = UIBarButtonItem()
    weak var delegate: GoToMyProfileFromPostDelegate?
    
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
    func setupUI() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        configureScrollView(postScrollView)
        contactWithAuthorButton.showLoading()
        configureCollectionView(postImagesCollectionView)
        fillUI()
    }
    
    func setOptionsBarButton() {
        optionsButtonView.isHidden = false
        savePostButtonViewConstraint = NSLayoutConstraint(item: savePostButtonView!, attribute: .trailing, relatedBy: .equal, toItem: optionsButtonView, attribute: .leading, multiplier: 1.0, constant: -20)
        savePostButtonViewConstraint.isActive = true
        let optionsBarButtonItem = UIBarButtonItem(image: UIImage(named: "PostOptions"),
                                                   style: .plain,
                                                   target: self,
                                                   action: #selector(optionsBarButtonPressed))
        self.navigationItem.rightBarButtonItems = [optionsBarButtonItem, savePostBarButtonItem]
    }
    
    func fillUI() {
        setLocalizables()
        fillPostUI()
        fillPostImages()
        getAuthorInfo()
    }
    
    func setLocalizables() {
        nameLabel.text = .Post.NameTitle()
        breedLabel.text = .Post.BreedTitle()
        lastTimeSeenTitleLabel.text = .Post.LastTimeSeenTitle()
        locationTitleLabel.text = .Post.LocationTitle()
        descriptionLabel.text = .Post.DescriptionTitle()
        authorLabel.text = .Post.AuthorTitle()
    }
    
    func fillPostUI() {
        postTypeImageView.image = UIImage(named: viewModel.post.animalType.rawValue)
        switch viewModel.post.postType {
        case .lost:
            postTypeLabel.text = .Post.LostPostTypeTitle()
        case .found:
            postTypeLabel.text = .Post.FoundPostTypeTitle()
            animalNameView.isHidden = true
        case .adopt:
            postTypeLabel.text = .Post.ToAdoptPostTypeTitle()
            lastTimeSeenAndLocationStackView.isHidden = true
        }
        animalNameLabel.text = viewModel.post.animalName ?? .Commons.NotSpecifiedMale()
        animalBreedLabel.text = viewModel.post.animalBreed ?? .Commons.NotSpecifiedFemale()
        lastTimeSeenLabel.text = viewModel.post.lastTimeSeen
        locationLabel.text = viewModel.post.location.address
        descriptionTextView.text = viewModel.post.description ?? .Commons.NotSpecifiedFemale()
        updateSavedPostUI()
    }
    
    func fillPostImages() {
        viewModel.getImagesFromURLImages {
            DispatchQueue.main.async {
                self.setOptionsBarButton()
                self.postImagesPageControl.numberOfPages = self.viewModel.postImages.count
                self.viewModel.isLoadingPostImages = false
                self.postImagesCollectionView.reloadData()
            }
        }
    }
    
    func getAuthorInfo() {
        viewModel.getAuthorInfo { self.fillAuthorUI() }
    }
    
    func fillAuthorUI() {
        guard let user = viewModel.user else { return }
        animalShelterImageView.isHidden = !user.animalShelter
        authorNameLabel.text = "\(user.firstname) \(user.lastname)"
        authorAddressLabel.text = user.location.address
        if let authorAge = viewModel.getAge() { authorAgeLabel.text = "\(authorAge) years old" }
        else { authorAgeLabel.isHidden = true }
        updateAuthorUI()
        contactWithAuthorButton.hideLoading {
            self.contactWithAuthorButton.setTitle(.Post.ContactWithTitle.localized(with: user.firstname), for: .normal)
        }
        if let userURLImage = user.userURLImage {
            userURLImage.getURLImage { image in
                DispatchQueue.main.async {
                    self.authorPhotoImageView.image = image
                    self.loadingAuthorInfoView.isHidden = true
                }
            }
        }
    }
    
    func updateAuthorUI() {
        loadingAuthorInfoView.isHidden = true
        authorInfoStackView.isHidden = false
        authorButton.isUserInteractionEnabled = true
    }
    
    func updateSavedPostUI() {
        savePostBarButtonItem.image = viewModel.saved ? UIImage(named: "SavePostFilled") : UIImage(named: "SavePost")
        savePostImageView.image = viewModel.saved ? UIImage(named: "SavePostFilledWhite") : UIImage(named: "SavePostWhite")
    }
    
    func savePost() {
        savePostButton.isUserInteractionEnabled = false
        viewModel.didPressSavePostButton {
            self.savePostButton.isUserInteractionEnabled = true
            self.updateSavedPostUI()
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
