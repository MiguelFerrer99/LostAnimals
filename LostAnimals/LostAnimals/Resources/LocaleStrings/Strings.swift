//
//  Strings.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 15/6/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

import UIKit

func isInSpanish() -> Bool {
    guard let preferredLanguage = Locale.preferredLanguages.first else { return false }
    return preferredLanguage.prefix(2) == "es"
}

func isInEnglish() -> Bool {
    guard let preferredLanguage = Locale.preferredLanguages.first else { return false }
    return preferredLanguage.prefix(2) == "en"
}

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
        case NotSpecifiedMale = "Commons_NotSpecifiedMale"
        case NotSpecifiedFemale = "Commons_NotSpecifiedFemale"
        case MailSent = "Commons_MailSent"
        case AnimalName = "Commons_AnimalName"
        case Animal = "Commons_Animal"
        case AnimalBreed = "Commons_AnimalBreed"
        case AnimalLastTimeSeen = "Commons_AnimalLastTimeSeen"
        case AnimalLocation = "Commons_AnimalLocation"
        case AnimalDescription = "Commons_AnimalDescription"
        case RemovePhoto = "Commons_RemovePhoto"
        case ChooseFromLibrary = "Commons_ChooseFromLibrary"
        case TakePhoto = "Commons_TakePhoto"
        case Yes = "Commons_Yes"
        case No = "Commons_No"
        case SelectAnimalYouWant = "Commons_SelectAnimalYouWant"
        case ApplyFilter = "Commons_ApplyFilter"
        case AnimalTypeDog = "Commons_AnimalTypeDog"
        case AnimalTypeBird = "Commons_AnimalTypeBird"
        case AnimalTypeCat = "Commons_AnimalTypeCat"
        case AnimalTypeTurtle = "Commons_AnimalTypeTurtle"
        case AnimalTypeSnake = "Commons_AnimalTypeSnake"
        case AnimalTypeRabbit = "Commons_AnimalTypeRabbit"
        case AnimalTypeOther = "Commons_AnimalTypeOther"
        case SaveChanges = "Commons_SaveChanges"
        case ChangesSaved = "Commons_ChangesSaved"
        case RemovePetData = "Commons_RemovePetData"
        case AreYouSureRemovePetData = "Commons_AreYouSureRemovePetData"
        case PetDataRemoved = "Commons_PetDataRemoved"
        case AreYouSureDeletePost = "Commons_AreYouSureDeletePost"
        case HaveYouLostYourPet = "Commons_HaveYouLostYourPet"
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
        case OpenMail = "ServiceErrors_OpenMail"
        case SendMail = "ServiceErrors_SendMail"
        case OpenPhone = "ServiceErrors_OpenPhone"
        case OpenWhatsapp = "ServiceErrors_OpenWhatsapp"
        case OpenInstagram = "ServiceErrors_OpenInstagram"
        case OpenTwitter = "ServiceErrors_OpenTwitter"
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
        case PostTypeLost = "Post_PostTypeLost"
        case PostTypeFound = "Post_PostTypeFound"
        case PostTypeAdopt = "Post_PostTypeAdopt"
    }
    enum EditPost: String, Localizable {
        case Title = "EditPost_Title"
        case DeletePost = "EditPost_DeletePost"
        case PostDeleted = "EditPost_PostDeleted"
    }
    enum Location: String, Localizable {
        case Title = "Location_Title"
        case HowToGo = "Location_HowToGo"
        case FoundAnimal = "Location_FoundAnimal"
    }
    enum NewPost: String, Localizable {
        case Title = "NewPost_Title"
        case Text = "NewPost_Text"
    }
    enum NewPostGeneric: String, Localizable {
        case Title = "NewPostGeneric_Title"
        case MustSelectPhoto = "NewPostGeneric_MustSelectPhoto"
        case PublishPostButton = "NewPostGeneric_PublishPostButton"
        case AreYouSureExit = "NewPostGeneric_AreYouSureExit"
        case PostPublished = "NewPostGeneric_PostPublished"
    }
    enum Profile: String, Localizable {
        case Title = "Profile_Title"
        case WelcomeBack = "Profile_WelcomeBack"
        case YeardOld = "Profile_YeardOld"
        case Posts = "Profile_Posts"
        case MyPosts = "Profile_MyPosts"
        case MySavedPosts = "Profile_MySavedPosts"
        case SocialMedias = "Profile_SocialMedias"
        case BlockedByYou = "Profile_BlockedByYou"
        case UserBlocked = "Profile_UserBlocked"
        case AreYouSureUnblock = "Profile_AreYouSureUnblock"
        case AreYouSureBlock = "Profile_AreYouSureBlock"
        case MyPet = "Profile_MyPet"
    }
    enum ProfileSettings: String, Localizable {
        case EditPersonalDetials = "ProfileSettings_EditPersonalDetials"
        case EditSocialMediaDetails = "ProfileSettings_EditSocialMediaDetails"
        case ChangePassword = "ProfileSettings_ChangePassword"
        case BlockedUsers = "ProfileSettings_BlockedUsers"
        case TermsAndConditions = "ProfileSettings_TermsAndConditions"
        case DeleteAccount = "ProfileSettings_DeleteAccount"
        case LogOut = "ProfileSettings_LogOut"
        case AreYouSureDeleteAccount = "ProfileSettings_AreYouSureDeleteAccount"
        case AreYouSureLogOut = "ProfileSettings_AreYouSureLogOut"
        case UnblockUserButton = "ProfileSettings_UnblockUserButton"
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
}
