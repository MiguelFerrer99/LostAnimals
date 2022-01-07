//
//  Container.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/10/2021.
//  Copyright © 2020 Miguel Ferrer Fornali. All rights reserved.
//

import Foundation

class Container {
	static let shared = Container()
}

extension Container {
  func animalFilterPopupBuilder() -> AnimalFilterPopupBuilder {
    return AnimalFilterPopupBuilder()
  }
  
  func animalTypesBuilder() -> AnimalTypesBuilder {
    return AnimalTypesBuilder()
  }
  
  func contactWithPopupBuilder() -> ContactWithPopupBuilder {
    return ContactWithPopupBuilder()
  }
  
  func dateFilterPopupBuilder() -> DateFilterPopupBuilder {
    return DateFilterPopupBuilder()
  }
  
  func editPostBuilder() -> EditPostBuilder {
    return EditPostBuilder()
  }
  
  func errorPopupBuilder() -> ErrorPopupBuilder {
    return ErrorPopupBuilder()
  }
  
  func exploreBuilder() -> ExploreBuilder {
    return ExploreBuilder()
  }
  
  func forgotPasswordBuilder() -> ForgotPasswordBuilder {
    return ForgotPasswordBuilder()
  }
  
  func guestPopupBuilder() -> GuestPopupBuilder {
    return GuestPopupBuilder()
  }
  
  func locationBuilder() -> LocationBuilder {
    return LocationBuilder()
  }
  
  func locationFilterPopupBuilder() -> LocationFilterPopupBuilder {
    return LocationFilterPopupBuilder()
  }
  
  func loginBuilder() -> LoginBuilder {
    return LoginBuilder()
  }
  
  func newPostBuilder() -> NewPostBuilder {
    return NewPostBuilder()
  }
  
  func onboardingBuilder() -> OnboardingBuilder {
    return OnboardingBuilder()
  }
  
  func postBuilder() -> PostBuilder {
    return PostBuilder()
  }
  
  func postOptionsPopupBuilder() -> PostOptionsPopupBuilder {
    return PostOptionsPopupBuilder()
  }
  
  func profileBuilder() -> ProfileBuilder {
    return ProfileBuilder()
  }
  
  func savedPostsBuilder() -> SavedPostsBuilder {
    return SavedPostsBuilder()
  }
  
  func selectPhotoPopupBuilder() -> SelectPhotoPopupBuilder {
    return SelectPhotoPopupBuilder()
  }
  
  func signupBuilder() -> SignUpBuilder {
    return SignUpBuilder()
  }
  
  func startupBuilder() -> StartupBuilder {
    return StartupBuilder()
  }
  
  func successPopupBuilder() -> SuccessPopupBuilder {
    return SuccessPopupBuilder()
  }
  
  func tabBarBuilder() -> TabBarBuilder {
    return TabBarBuilder()
  }
  
  func termsAndConditionsBuilder() -> TermsAndConditionsBuilder {
    return TermsAndConditionsBuilder()
  }
  
  func whereCanWeFindYou() -> WhereCanWeFindYouBuilder {
    return WhereCanWeFindYouBuilder()
  }
  
  func whereDoYouLiveCitiesBuilder() -> WhereDoYouLiveCitiesBuilder {
    return WhereDoYouLiveCitiesBuilder()
  }
  
  func whereDoYouLiveCountriesBuilder() -> WhereDoYouLiveCountriesBuilder {
    return WhereDoYouLiveCountriesBuilder()
  }
}
