//
//  ProfileCollectionViews.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 20/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Functions
extension ProfileViewController {
    func configureCollectionView(_ collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PostCollectionViewCell.self)
        collectionView.register(SocialMediaCollectionViewCell.self)
    }
}

// MARK: - UICollectionViewDataSource
extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == firstCollectionView {
            return viewModel.posts.count
        } else {
            if viewModel.isMyProfile {
                return viewModel.savedPosts.count
            } else {
                return viewModel.user.socialMedias.count - 1
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == firstCollectionView {
            let post = viewModel.posts[indexPath.row]
            var trailingPadding: CGFloat = indexPath.row == viewModel.posts.count - 1 ? 20 : 10
            if viewModel.posts.count <= 2 { trailingPadding = 10 }
            let summary = PostCollectionViewCellSummary(postType: post.postType,
                                                        animalName: post.animalName,
                                                        animalType: post.animalType,
                                                        postURLImage: post.urlImage1 ?? "",
                                                        leadingPadding: indexPath.row == 0 ? 20 : 10,
                                                        trailingPadding: trailingPadding)
            let cell = collectionView.dequeue(PostCollectionViewCell.self, for: indexPath)
            cell.display(summary: summary)
            return cell
        } else {
            if viewModel.isMyProfile {
                let savedPost = viewModel.savedPosts[indexPath.row]
                var trailingPadding: CGFloat = indexPath.row == viewModel.posts.count - 1 ? 20 : 10
                if viewModel.savedPosts.count <= 2 { trailingPadding = 10 }
                let summary = PostCollectionViewCellSummary(postType: savedPost.postType,
                                                            animalName: savedPost.animalName,
                                                            animalType: savedPost.animalType,
                                                            postURLImage: savedPost.urlImage1 ?? "",
                                                            leadingPadding: indexPath.row == 0 ? 20 : 10,
                                                            trailingPadding: trailingPadding)
                let cell = collectionView.dequeue(PostCollectionViewCell.self, for: indexPath)
                cell.display(summary: summary)
                return cell
            } else {
                var socialMediaIcon = UIImage()
                var socialMediaBackgroundImage = UIImage()
                let socialMediaType = viewModel.socialMediaTypes[indexPath.row]
                switch socialMediaType {
                case .email:
                    socialMediaIcon = UIImage(named: "Mail") ?? UIImage()
                    socialMediaBackgroundImage = UIImage(named: "CustomRedBackground") ?? UIImage()
                case .phonePrefix, .phoneNumber:
                    socialMediaIcon = UIImage(named: "Phone") ?? UIImage()
                    socialMediaBackgroundImage = UIImage(named: "CustomBlueBackground") ?? UIImage()
                case .whatsapp:
                    socialMediaIcon = UIImage(named: "Whatsapp") ?? UIImage()
                    socialMediaBackgroundImage = UIImage(named: "CustomLightGreenBackground") ?? UIImage()
                case .instagram:
                    socialMediaIcon = UIImage(named: "Instagram") ?? UIImage()
                    socialMediaBackgroundImage = UIImage(named: "InstagramBackground") ?? UIImage()
                case .twitter:
                    socialMediaIcon = UIImage(named: "Twitter") ?? UIImage()
                    socialMediaBackgroundImage = UIImage(named: "CustomLightBlueBackground") ?? UIImage()
                }
                var trailingPadding: CGFloat = indexPath.row == viewModel.user.socialMedias.count - 2 ? 20 : 10
                if (viewModel.socialMediaTypes.count - 1) <= 2 { trailingPadding = 10 }
                let summary = SocialMediaCollectionViewCellSummary(icon: socialMediaIcon,
                                                                   backgroundImage: socialMediaBackgroundImage,
                                                                   leadingPadding: indexPath.row == 0 ? 20 : 10,
                                                                   trailingPadding: trailingPadding)
                let cell = collectionView.dequeue(SocialMediaCollectionViewCell.self, for: indexPath)
                cell.display(summary: summary)
                return cell
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == firstCollectionView {
            let post = viewModel.posts[indexPath.row]
            viewModel.didPressPost(post: post)
        } else if collectionView == secondCollectionView {
            if viewModel.isMyProfile {
                let savedPost = viewModel.savedPosts[indexPath.row]
                viewModel.didPressPost(post: savedPost)
            } else {
                let socialMediaType = viewModel.socialMediaTypes[indexPath.row]
                let socialMediaValue = viewModel.user.socialMedias[socialMediaType]
                switch socialMediaType {
                case .email:
                    sendEmail(email: socialMediaValue ?? "")
                case .phonePrefix, .phoneNumber:
                    viewModel.didPressPhoneButton()
                case .whatsapp:
                    viewModel.didPressWhatsappButton()
                case .instagram:
                    viewModel.didPressInstagramButton()
                case .twitter:
                    viewModel.didPressTwitterButton()
                }
            }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.25, height: collectionView.frame.height)
    }
}
