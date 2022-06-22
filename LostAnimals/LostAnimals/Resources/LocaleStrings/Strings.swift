//
//  Strings.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 15/6/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

protocol Localizable: CustomStringConvertible {
    var rawValue: String { get }
}

extension Localizable {
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }

    var uppercased: String {
        return self.localized.uppercased()
    }

    var description: String {
        return self.localized
    }

    func localized(with: CVarArg...) -> String {
        let text = String(format: self.localized, arguments: with)
        return text
    }

    func callAsFunction() -> String {
        return self.localized
    }
}

extension String {
    enum Commons: String, Localizable {
        case Mail = "Commons_Mail"
        case Firstname = "Commons_Firstname"
        case Lastname = "Commons_Lastname"
        case Birthdate = "Commons_Birthdate"
        case WhereDoYouLive = "Commons_WhereDoYouLive"
        case AnimalShelterName = "Commons_AnimalShelterName"
        case WhereCanWeFindYou = "Commons_WhereCanWeFindYou"
        case Password = "Commons_Password"
        case ConfirmPassword = "Commons_ConfirmPassword"
        case Phone = "Commons_Phone"
        case HaveWhatsApp = "Commons_HaveWhatsApp"
        case OptionalInstagram = "Commons_OptionalInstagram"
        case OptionalTwitter = "Commons_OptionalTwitter"
        case BackButton = "Commons_BackButton"
        case NextButton = "Commons_NextButton"
        case NoPostsAvailable = "Commons_NoPostsAvailable"
        case GuestPopupTitle = "Commons_GuestPopupTitle"
        case GoToStartup = "Commons_GoToStartup"
        case Cancel = "Commons_Cancel"
        case SavedPostsTitle = "Commons_SavedPostsTitle"
    }
    enum TextFieldErrors: String, Localizable {
        case Empty = "TextFieldErrors_Empty"
        case EmptyField = "TextFieldErrors_EmptyField"
        case EmailFormat = "TextFieldErrors_EmailFormat"
        case PasswordFormat = "TextFieldErrors_PasswordFormat"
        case PasswordsDifferent = "TextFieldErrors_PasswordsDifferent"
        case InvalidFormat = "TextFieldErrors_InvalidFormat"
        case OnlyLettersAndSpaces = "TextFieldErrors_OnlyLettersAndSpaces"
        case MinimumCharacters = "TextFieldErrors_MinimumCharacters"
        case MaximumCharacters = "TextFieldErrors_MaximumCharacters"
    }
    enum ServiceErrors: String, Localizable {
        case EmailAlreadyUsed = "ServiceErrors_EmailAlreadyUsed"
        case NoUserRegistered = "ServiceErrors_NoUserRegistered"
        case Unexpected = "ServiceErrors_Unexpected"
        case VerifyAccount = "ServiceErrors_VerifyAccount"
        case InternetConnection = "ServiceErrors_InternetConnection"
        case InvalidMailOrPassword = "ServiceErrors_InvalidMailOrPassword"
        case LocationAddress = "ServiceErrors_LocationAddress"
        case Banned = "ServiceErrors_Banned"
    }
    enum Startup: String, Localizable {
        case WelcomeTitle = "Startup_WelcomeTitle"
        case WelcomeText = "Startup_WelcomeText"
        case ContinueAsGuest = "Startup_ContinueAsGuest"
        case LogIn = "Startup_LogIn"
        case SignUp = "Startup_SignUp"
    }
    enum Onboarding: String, Localizable {
        case Item1Title = "Onboarding_Item1Title"
        case Item1Text = "Onboarding_Item1Text"
        case Item2Title = "Onboarding_Item2Title"
        case Item2Text = "Onboarding_Item2Text"
        case Item3Title = "Onboarding_Item3Title"
        case Item3Text = "Onboarding_Item3Text"
    }
    enum LogIn: String, Localizable {
        case Title = "LogIn_Title"
        case ForgotPassword = "LogIn_ForgotPassword"
        case LogInButton = "LogIn_LogInButton"
    }
    enum ForgotPassword: String, Localizable {
        case Title = "ForgotPassword_Title"
        case Text = "ForgotPassword_Text"
        case RecoverPasswordButton = "ForgotPassword_RecoverPasswordButton"
        case SuccessPopup = "ForgotPassword_SuccessPopup"
    }
    enum SignUp: String, Localizable {
        case Title = "SignUp_Title"
        enum PersonalDetails: String, Localizable {
            case Title = "SignUp_PersonalDetails_Title"
            case Text = "SignUp_PersonalDetails_Text"
            case AnimalShelterButton = "SignUp_PersonalDetails_AnimalShelterButton"
            case PersonButton = "SignUp_PersonalDetails_PersonButton"
        }
        enum AccountDetails: String, Localizable {
            case Title = "SignUp_AccountDetails_Title"
            case Text = "SignUp_AccountDetails_Text"
            case PasswordRequirement = "SignUp_AccountDetails_PasswordRequirement"
        }
        enum SocialMediaDetails: String, Localizable {
            case Title = "SignUp_SocialMediaDetails_Title"
            case Text = "SignUp_SocialMediaDetails_Text"
            case AcceptTermsAndConditions = "SocialMediaDetails_AcceptTermsAndConditions"
            case TermsAndConditionsButton = "SocialMediaDetails_TermsAndConditionsButton"
            case GetStartedButton = "SocialMediaDetails_GetStartedButton"
            case SuccessPopup = "SocialMediaDetails_SuccessPopup"
        }
    }
    enum WhereDoYouLiveCountries: String, Localizable {
        case Title = "WhereDoYouLiveCountries_Title"
        case SearchBarPlaceholder = "WhereDoYouLiveCountries_SearchBarPlaceholder"
    }
    enum WhereDoYouLiveCities: String, Localizable {
        case Title = "WhereDoYouLiveCities_Title"
        case SearchBarPlaceholder = "WhereDoYouLiveCities_SearchBarPlaceholder"
    }
    enum WhereCanWeFindYou: String, Localizable {
        case Title = "WhereCanWeFindYou_Title"
        case SearchBarPlaceholder = "WhereCanWeFindYou_SearchBarPlaceholder"
        case CurrentLocation = "WhereCanWeFindYou_CurrentLocation"
    }
    enum TermsAndConditions: String, Localizable {
        case Title = "TermsAndConditions_Title"
        case Item1Title = "TermsAndConditions_Item1Title"
        case Item1Description = "TermsAndConditions_Item1Description"
        case Item2Title = "TermsAndConditions_Item2Title"
        case Item2Description = "TermsAndConditions_Item2Description"
        case Item3Title = "TermsAndConditions_Item3Title"
        case Item3Description = "TermsAndConditions_Item3Description"
        case Item4Title = "TermsAndConditions_Item4Title"
        case Item4Description = "TermsAndConditions_Item4Description"
        case Item5Title = "TermsAndConditions_Item5Title"
        case Item5Description = "TermsAndConditions_Item5Description"
        case Item6Title = "TermsAndConditions_Item6Title"
        case Item6Description = "TermsAndConditions_Item6Description"
        case Item7Title = "TermsAndConditions_Item7Title"
        case Item7Description = "TermsAndConditions_Item7Description"
        case Item8Title = "TermsAndConditions_Item8Title"
        case Item8Description = "TermsAndConditions_Item8Description"
        case Item9Title = "TermsAndConditions_Item9Title"
        case Item9Description = "TermsAndConditions_Item9Description"
        case Item10Title = "TermsAndConditions_Item10Title"
        case Item10Description = "TermsAndConditions_Item10Description"
        case Item11Title = "TermsAndConditions_Item11Title"
        case Item11Description = "TermsAndConditions_Item11Description"
        case Item12Title = "TermsAndConditions_Item12Title"
        case Item12Description = "TermsAndConditions_Item12Description"
    }
    enum Explore: String, Localizable {
        case Title = "Explore_Title"
        case RecentFilterTitle = "Explore_RecentFilterTitle"
        case NearFilterTitle = "Explore_NearFilterTitle"
        case LostFilterTitle = "Explore_LostFilterTitle"
        case FoundFilterTitle = "Explore_FoundFilterTitle"
        case AdoptFilterTitle = "Explore_AdoptFilterTitle"
        case AnimalFilterTitle = "Explore_AnimalFilterTitle"
    }
    enum Post: String, Localizable {
        case SharePostTitle = "Post_SharePostTitle"
        case EditPostTitle = "Post_EditPostTitle"
        case BlockUserTitle = "Post_BlockUserTitle"
        case LostPostTypeTitle = "Post_LostPostTypeTitle"
        case FoundPostTypeTitle = "Post_FoundPostTypeTitle"
        case ToAdoptPostTypeTitle = "Post_ToAdoptPostTypeTitle"
        case NameTitle = "Post_NameTitle"
        case BreedTitle = "Post_BreedTitle"
        case LastTimeSeenTitle = "Post_LastTimeSeenTitle"
        case LocationTitle = "Post_LocationTitle"
        case DescriptionTitle = "Post_DescriptionTitle"
        case AuthorTitle = "Post_AuthorTitle"
        case ContactWithTitle = "Post_ContactWithTitle"
        case ContactTitle = "Post_ContactTitle"
        case ContactText = "Post_ContactText"
    }
}
