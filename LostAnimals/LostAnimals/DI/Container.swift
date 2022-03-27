//
//  Container.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/10/2021.
//  Copyright © 2020 Miguel Ferrer Fornali. All rights reserved.
//

class Container {
    // MARK: - Singleton
    static let shared = Container()
}

// MARK: - Functions
extension Container {
    func animalFilterPopupBuilder() -> AnimalFilterPopupBuilder {
        AnimalFilterPopupBuilder()
    }
    
    func animalTypesBuilder() -> AnimalTypesBuilder {
        AnimalTypesBuilder()
    }
    
    func blockedUsersBuilder() -> BlockedUsersBuilder {
        BlockedUsersBuilder()
    }
    
    func changePasswordBuilder() -> ChangePasswordBuilder {
        ChangePasswordBuilder()
    }
    
    func confirmationPopupBuilder() -> ConfirmationPopupBuilder {
        ConfirmationPopupBuilder()
    }
    
    func contactWithPopupBuilder() -> ContactWithPopupBuilder {
        ContactWithPopupBuilder()
    }
    
    func dateFilterPopupBuilder() -> DateFilterPopupBuilder {
        DateFilterPopupBuilder()
    }
    
    func editPersonalDetailsBuilder() -> EditPersonalDetailsBuilder {
        EditPersonalDetailsBuilder()
    }
    
    func editSocialMediasBuilder() -> EditSocialMediasBuilder {
        EditSocialMediasBuilder()
    }
    
    func editPostBuilder() -> EditPostBuilder {
        EditPostBuilder()
    }
    
    func errorPopupBuilder() -> ErrorPopupBuilder {
        ErrorPopupBuilder()
    }
    
    func exploreBuilder() -> ExploreBuilder {
        ExploreBuilder()
    }
    
    func fakeSplashBuilder() -> FakeSplashBuilder {
        FakeSplashBuilder()
    }
    
    func forgotPasswordBuilder() -> ForgotPasswordBuilder {
        ForgotPasswordBuilder()
    }
    
    func guestPopupBuilder() -> GuestPopupBuilder {
        GuestPopupBuilder()
    }
    
    func locationBuilder() -> LocationBuilder {
        LocationBuilder()
    }
    
    func locationFilterPopupBuilder() -> LocationFilterPopupBuilder {
        LocationFilterPopupBuilder()
    }
    
    func loginBuilder() -> LoginBuilder {
        LoginBuilder()
    }
    
    func newPostBuilder() -> NewPostBuilder {
        NewPostBuilder()
    }
    
    func newPostGenericBuilder() -> NewPostGenericBuilder {
        NewPostGenericBuilder()
    }
    
    func onboardingBuilder() -> OnboardingBuilder {
        OnboardingBuilder()
    }
    
    func postBuilder() -> PostBuilder {
        PostBuilder()
    }
    
    func postImagesBuilder() -> PostImagesBuilder {
        PostImagesBuilder()
    }
    
    func postOptionsPopupBuilder() -> PostOptionsPopupBuilder {
        PostOptionsPopupBuilder()
    }
    
    func profileBuilder() -> ProfileBuilder {
        ProfileBuilder()
    }
    
    func profilePostsBuilder() -> ProfilePostsBuilder {
        ProfilePostsBuilder()
    }
    
    func profileSettingsBuilder() -> ProfileSettingsBuilder {
        ProfileSettingsBuilder()
    }
    
    func savedPostsBuilder() -> SavedPostsBuilder {
        SavedPostsBuilder()
    }
    
    func selectPhotoPopupBuilder() -> SelectPhotoPopupBuilder {
        SelectPhotoPopupBuilder()
    }
    
    func signupBuilder() -> SignUpBuilder {
        SignUpBuilder()
    }
    
    func startupBuilder() -> StartupBuilder {
        StartupBuilder()
    }
    
    func successPopupBuilder() -> SuccessPopupBuilder {
        SuccessPopupBuilder()
    }
    
    func tabBarBuilder() -> TabBarBuilder {
        TabBarBuilder()
    }
    
    func termsAndConditionsBuilder() -> TermsAndConditionsBuilder {
        TermsAndConditionsBuilder()
    }
    
    func whereCanWeFindYou() -> WhereCanWeFindYouBuilder {
        WhereCanWeFindYouBuilder()
    }
    
    func whereDoYouLiveCitiesBuilder() -> WhereDoYouLiveCitiesBuilder {
        WhereDoYouLiveCitiesBuilder()
    }
    
    func whereDoYouLiveCountriesBuilder() -> WhereDoYouLiveCountriesBuilder {
        WhereDoYouLiveCountriesBuilder()
    }
}
