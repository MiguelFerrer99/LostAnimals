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
  @IBOutlet weak var animalNameLabel: UILabel!
  @IBOutlet weak var animalBreedLabel: UILabel!
  @IBOutlet weak var lastTimeSeenLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var descriptionTextView: UITextView!
  @IBOutlet weak var authorPhotoImageView: UIImageView!
  @IBOutlet weak var authorNameLabel: UILabel!
  @IBOutlet weak var authorAgeLabel: UILabel!
  @IBOutlet weak var authorAddressLabel: UILabel!
  @IBOutlet weak var contactWithAuthorButton: UIButton!
  
  // MARK: - Properties
  override var navBarTitle: String {
    switch viewModel.post.postType {
    case .lost:
      return "Lost animal"
    case .found:
      return "Found animal"
    case .adopt:
      return "To adopt animal"
    }
  }
  override var hideNavigationBar: Bool {
    return shouldHideNavigationBar
  }
  var shouldHideNavigationBar: Bool {
    return postScrollView.contentOffset.y < 280
  }
  var viewModel: PostViewModel!
  var savePostBarButtonItem = UIBarButtonItem()
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    NotificationCenter.default.addObserver(self, selector: #selector(editPostButtonPressed), name: .GoToEditPostFromPostOptionsPopup, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(showGuestPopupFromPostOptionsPopup), name: .ShowGuestPopupFromPostOptionsPopup, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(showSuccessPopupFromPostOptionsPopup), name: .ShowSuccessPopupFromPostOptionsPopup, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(showErrorPopupFromPostOptionsPopup), name: .ShowErrorPopupFromPostOptionsPopup, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(showActivityViewControllerFromPostOptionsPopup), name: .ShowActivityViewControllerFromPostOptionsPopup, object: nil)
    
    setupUI()
    setupBindings()
    viewModel.viewReady()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    viewModel.viewDidAppear()
  }
  
  // MARK: - Functions
  private func setupBindings() {
    // Do bindings setup
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
    case .adopt:
      postTypeLabel.text = "To adopt animal"
    }
    
    authorPhotoImageView.image = viewModel.post.author.profileImage
    animalNameLabel.text = viewModel.post.animal.name
    animalBreedLabel.text = viewModel.post.animal.breed
    lastTimeSeenLabel.text = viewModel.post.lastTimeSeen.toString(withFormat: DateFormat.dayMonthYearHourOther)
    locationLabel.text = viewModel.post.location.address
    descriptionTextView.text = viewModel.post.description
    authorNameLabel.text = "\(viewModel.post.author.firstname) \(viewModel.post.author.lastname)"
    
    let birthdate = DateComponents(year: viewModel.post.author.birthdate.year, month: viewModel.post.author.birthdate.month, day: viewModel.post.author.birthdate.day)
    let now = Calendar.current.dateComponents([.year, .month, .day], from: Date())
    let ageComponents = Calendar.current.dateComponents([.year], from: birthdate, to: now)
    if let authorAge = ageComponents.year {
      authorAgeLabel.text = "\(authorAge) years old"
    }
    
    authorAddressLabel.text = viewModel.post.author.location.address
    contactWithAuthorButton.setTitle("Contact with \(viewModel.post.author.firstname)", for: .normal)
  }
  
  @objc private func savePostBarButtonPressed() {
    viewModel.didPressSavePostButton { allowed in
      if allowed {
        savePostBarButtonItem.image = savePostBarButtonItem.image == UIImage(named: "SavePost") ? UIImage(named: "SavePostFilled") : UIImage(named: "SavePost")
        savePostImageView.image = savePostBarButtonItem.image
      }
    }
  }
  
  @objc private func optionsBarButtonPressed() {
    viewModel.didPressOptionsButton()
  }
  
  @objc private func editPostButtonPressed() {
    viewModel.didPressEditPostButton()
  }
  
  @objc private func showGuestPopupFromPostOptionsPopup() {
    viewModel.showGuestPopupFromPostOptionsPopup()
  }
  
  @objc private func showSuccessPopupFromPostOptionsPopup() {
    viewModel.showSuccessPopupFromPostOptionsPopup()
  }
  
  @objc private func showErrorPopupFromPostOptionsPopup() {
    viewModel.showErrorPopupFromPostOptionsPopup()
  }
  
  @objc private func showActivityViewControllerFromPostOptionsPopup(_ notification: NSNotification) {
    if let postImageToShare = notification.userInfo?["postImageToShare"] as? UIImage {
      let activityViewController = UIActivityViewController(activityItems: [postImageToShare], applicationActivities: nil)
      self.present(viewController: activityViewController, completion: nil)
    }
  }
  
  // MARK: - IBActions
  @IBAction func backButtonPressed(_ sender: UIButton) {
    viewModel.didPressBackButton()
  }
  
  @IBAction func savePostButtonPressed(_ sender: UIButton) {
    viewModel.didPressSavePostButton { allowed in
      if allowed {
        savePostImageView.image = savePostImageView.image == UIImage(named: "SavePost") ? UIImage(named: "SavePostFilled") : UIImage(named: "SavePost")
        savePostBarButtonItem.image = savePostImageView.image
      }
    }
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
