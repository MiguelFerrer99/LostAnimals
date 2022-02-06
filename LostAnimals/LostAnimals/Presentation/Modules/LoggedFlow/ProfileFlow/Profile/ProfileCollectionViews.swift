//
//  ProfileCollectionViews.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 20/1/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import Foundation
import UIKit

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func configureCollectionView(_ collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PostCollectionViewCell.self)
        collectionView.register(SocialMediaCollectionViewCell.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == firstCollectionView {
            return HardcodedData.explorePosts.count
        } else {
            if viewModel.isMyProfile {
                return HardcodedData.savedPosts.count
            } else {
                return viewModel.user.socialMedias.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == firstCollectionView {
            let post = HardcodedData.explorePosts[indexPath.row]
            let summary = PostCollectionViewCellSummary(postType: post.postType,
                                                        animal: post.animal,
                                                        postImage: post.animal.images.first ?? UIImage(named: "SelectPhotoPlaceholder"),
                                                        leadingPadding: indexPath.row == 0 ? 20 : 10,
                                                        trailingPadding: indexPath.row == HardcodedData.explorePosts.count - 1 ? 20 : 10)
            let cell = collectionView.dequeue(PostCollectionViewCell.self, for: indexPath)
            cell.display(summary: summary)
            return cell
        } else {
            if viewModel.isMyProfile {
                let post = HardcodedData.savedPosts[indexPath.row]
                let summary = PostCollectionViewCellSummary(postType: post.postType,
                                                            animal: post.animal,
                                                            postImage: post.animal.images.first ?? UIImage(named: "SelectPhotoPlaceholder"),
                                                            leadingPadding: indexPath.row == 0 ? 20 : 10,
                                                            trailingPadding: indexPath.row == HardcodedData.savedPosts.count - 1 ? 20 : 10)
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
                let summary = SocialMediaCollectionViewCellSummary(icon: socialMediaIcon,
                                                                   backgroundImage: socialMediaBackgroundImage,
                                                                   leadingPadding: indexPath.row == 0 ? 20 : 10,
                                                                   trailingPadding: indexPath.row == viewModel.user.socialMedias.count - 1 ? 20 : 10)
                let cell = collectionView.dequeue(SocialMediaCollectionViewCell.self, for: indexPath)
                cell.display(summary: summary)
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.8, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == firstCollectionView {
            let post = HardcodedData.explorePosts[indexPath.row]
            viewModel.didPressPost(post: post)
        } else if collectionView == secondCollectionView {
            if viewModel.isMyProfile {
                let post = HardcodedData.savedPosts[indexPath.row]
                viewModel.didPressPost(post: post)
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
