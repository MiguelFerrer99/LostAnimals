//
//  Constants.swift
//  LostAnimals
//
//  Created by Miguel Ferrer Fornali on 28/10/2021.
//  Copyright © 2020 Miguel Ferrer Fornali. All rights reserved.
//

import UIKit

// MARK: - Constants
struct Constants {
    // MARK: - Properties
    static let emptyUser = User(id: "",
                                email: "",
                                animalShelter: false,
                                firstname: "",
                                lastname: "",
                                birthdate: Date.today.toString(withFormat: DateFormat.dayMonthYearOther),
                                userImage: UIImage(named: "DefaultUserImage") ?? UIImage(),
                                headerImage: UIImage(named: "DefaultHeaderImage") ?? UIImage(),
                                location: Location(address: "Not specified", coordinates: nil),
                                socialMedias: [:],
                                banned: false,
                                blockedUsers: [])
    
    static let onboardingStepsInfo = [
        OnboardingStepInfo(title: "Share",
                           description: "Have you lost your pet? We help you to find her by sharing information. Everyone stay tuned! 👀",
                           image: UIImage(named: "OnboardingItem1") ?? UIImage()),
        OnboardingStepInfo(title: "Find",
                           description: "Have you seen an abandoned pet? Share it so everyone knows where and when have you seen it 🔍",
                           image: UIImage(named: "OnboardingItem2") ?? UIImage()),
        OnboardingStepInfo(title: "Contact",
                           description: "Contact people easily through their social networks to solve everything 📞",
                           image: UIImage(named: "OnboardingItem3") ?? UIImage())
    ]
    
    static let termsAndConditions = [
        TermAndCondition(title: """
            Thanks for using LostAnimals
            
            """, description: "For the smooth running of the community, we need you to follow the proposed Terms and Conditions of Use, which will be applicable to users from 1 March 2022."),
        TermAndCondition(title: "LostAnimals Terms and Conditions of Use", description: """
            These Terms and Conditions of Use establish the conditions under which users are offered access to LostAnimals websites, services and applications, which is a platform that allows users to find their lost animals in a much faster and more efficient way thanks to the use of new technologies. The use of the Service confers to the user the condition of user of the Service and implies full acceptance of these Terms and Conditions. If the User does not agree with all or part of these Terms and Conditions, he/she must refrain from installing and using the Service. By accepting these Terms and Conditions, the User represents:
            - That he/she has read, understands and understands what is set forth herein.
            - That he/she assumes all the obligations set forth herein.
            - That he/she is of legal age and has sufficient legal capacity to use the Service.
            - The acceptance of these Terms and Conditions by the Users is a prior and indispensable step to the use of the Service.
            LostAnimals reserves the right to update and/or modify the Terms and Conditions at any time and for any reason in its sole discretion. LostAnimals will provide notice of any material changes to the Terms and Conditions or to any Service or other feature of the Services. By accessing or using the Services after LostAnimals has notified the User of a modification or update, the User agrees to be bound by the modified Terms and Conditions. If the modified Terms and Conditions are not acceptable to the User, the User's sole option is to discontinue using the Services.
            """),
        TermAndCondition(title: "Service owner", description: "The owner and proprietor of the Service is Miguel Ferrer Fornali. Email: miguelferrerfornali1999@gmail.com"),
        TermAndCondition(title: "Registration requirement", description: "In order to use the Service, the User must first register and accept these Terms and Conditions and the Privacy and Cookies Policy. The data entered by the User must be accurate, current and truthful. The registered User will be responsible at all times for the custody of your password, assuming any damages that may arise from its misuse, as well as the transfer, disclosure or loss of it, and must immediately inform LostAnimals in case you have reason to believe that your password has been used in an unauthorized manner or is likely to be used in an unauthorized manner. In any case, the User is considered to be responsible for the access and/or use of the Service in relation to his account, who will be liable in any case for such access and/or use. By accepting the Terms and Conditions, the User consents that his data will become part of the LostAnimalsy file and the treatment of such data will be in accordance with the provisions of the Privacy Policy."),
        TermAndCondition(title: "Rules for the use of the service", description: """
            The User undertakes to use the Service in accordance with the law, morality, public order and these Terms and Conditions. Likewise, the User undertakes to make appropriate use of the Service and not to use it for illicit or criminal activities that infringe the rights of third parties or that violate any rule of the legal system. The User undertakes not to transmit, introduce, disseminate and/or make available to third parties any type of material and information that is contrary to the law, morality, public order and these Terms and Conditions. By way of example and in no way limiting or excluding, the User undertakes to:
            - Not to introduce or disseminate content or propaganda of a racist, xenophobic or pornographic nature, or that advocates terrorism, armed conflict, incites hatred or violates human rights.
            - Not to disseminate, transmit or make available to third parties any type of information, element or content that violates the fundamental rights and public freedoms recognised in the constitution and in international treaties.
            - Not to disseminate, transmit or make available to third parties any type of information, element or content that constitutes unlawful or unfair advertising.
            - Not to transmit unsolicited or unauthorised advertising, advertising material, "junk mail", "chain letters", "pyramid structures", or any other form of solicitation.
            - Not to introduce or disseminate any false, misleading, deceptive, ambiguous or inaccurate information and content in a manner that misleads or is likely to mislead the recipients of the information.
            - Not to impersonate other Users of the Service.
            - Not to disseminate, transmit or make available to third parties any type of information, element or content without the authorisation of the holders of the intellectual and industrial property rights that may apply to such information, element or content.
            - Not to disseminate, transmit or make available to third parties any type of information, element or content that involves a violation of the secrecy of communications and personal data legislation.
            - Not to disseminate, transmit or make available to third parties photographs or any representation or image of minors.
            - Not to report falsely or incorrectly repeatedly.
            - To use LostAnimals services correctly.
            The User agrees to hold LostAnimals harmless against any possible claim, fine, penalty or sanction that may come forced to bear as a result of the breach by the User of any of the above rules of use, also reserving LostAnimals the right to seek compensation for damages and damages that may apply.
            """),
        TermAndCondition(title: "Exclusion of Users", description: "LostAnimals reserves the right to prevent the use of the Service, either temporarily or permanently, to any User who violates any of the rules set forth in these Terms and Conditions, the law or morality. LostAnimals may also exclude Users and even stop providing all or part of the Service when it deems appropriate to improve the operation of the Service and/or the rest of the Users of the Service."),
        TermAndCondition(title: "Exclusion of liability", description: """
            LostAnimals does not own any of the pets posted through its platform and is not part of the exchange or adoption process, nor does it review or validate the pets that Users post through the Service, so LostAnimals will not be liable, either directly or indirectly, or subsidiarily, for damages of any nature arising from the use and contracting of the contents and activities of Users and/or third parties through the Service as well as the lack of legality, reliability, usefulness, truthfulness, accuracy, completeness and timeliness of the same. By way of example, and in no case limited, LostAnimals will not be liable for damages of any nature arising from:
            - The use that the Users make of the Service nor by the state, origin, possible inaccuracy, or possible falsity of the data provided by the Users nor of the products offered through the Service.
            - The contents, information, opinions and statements of any User or third parties or entities that are communicated or displayed through the Service.
            - The use that Users may make of the materials of the Service, whether prohibited or permitted, in infringement of intellectual and/or industrial property rights, confidential information, of the contents of the Service or of third parties.
            - The carrying out of acts of unfair competition and illegal advertising.
            - The possible loss of User data for reasons not attributable to the Service.
            - Access by minors to the contents included in the Service.
            - The unavailability, errors, access failures and lack of continuity of the Service.
            - Failures or incidents that may occur in communications, deletion or incomplete transmissions.
            - The non-operability or problems in the email address provided by the user.
            LostAnimals will respond solely and exclusively to the User of the Services provided by itself and the content directly originated and identified with its copyright.
            Any claim or controversy that may arise between the Users of the Service must be resolved between them, obliging LostAnimals to keep LostAnimals completely unharmed, without prejudice to which LostAnimals will make its best efforts to provide users with a prompt and satisfactory solution through its Customer Service.
            """),
        TermAndCondition(title: "Content and services linked through the Service", description: "The Service may include technical linking devices, directories and even search tools that allow the User to access other pages and Internet portals. The User acknowledges and agrees that access to the Linked Sites is at the User's sole risk and responsibility and exonerates LostAnimals from any liability for any infringement of intellectual or industrial property rights of the owners of the Linked Sites. Likewise, the User exonerates LostAnimals from any responsibility for the technical availability of the Linked Sites, the quality, reliability, accuracy and/or veracity of the services, information, elements and/or contents that the User may access. In these cases, LostAnimals will only be responsible for the contents and services provided in the Linked Sites to the extent that it has actual knowledge of the unlawfulness and has not disabled the link with due diligence. In the event that the User considers that there is a Linked Site with illegal or inappropriate content may communicate it to LostAnimals, without in any case this communication entails the obligation to remove the corresponding link. In any case, the existence of Linked Sites should not presuppose the formalization of agreements with those responsible or owners thereof, nor the recommendation, promotion or identification of LostAnimals with the statements, content or services provided. LostAnimals does not know the contents and services of the Linked Sites and, therefore, is not responsible directly or indirectly for the damages caused by the unlawfulness, quality, outdatedness, unavailability, error and uselessness of the contents and/or services of the Linked Sites or for any other damage that is not directly attributable to LostAnimals."),
        TermAndCondition(title: "Intellectual and industrial property", description: "The industrial and intellectual property rights over the works, protected services and any content or elements with intellectual and industrial property rights that are used in the Service belong to their legitimate owners. By using the Service, the User does not acquire any intellectual or industrial property rights or any licence to use such elements. The Contents of the Service are the texts, photographs, graphics, images, icons, technology, software, databases and other audiovisual or sound contents, as well as their graphic design and source codes used in the Service. This list is for illustrative and exemplary purposes only and is not exhaustive. The text, images, graphics, sound files, animation files, video files, software and appearance of the LostAnimals website are protected by intellectual and industrial property rights. These elements may not be validly and legitimately copied or distributed for commercial use, nor may they be modified or inserted in other websites without the prior express authorization of their owners. The User declares that he/she is the exclusive owner of all the rights to the works, protected services and any other elements protected by intellectual or industrial property that he/she incorporates in the Service. The User grants LostAnimals, free of charge and exclusively, the rights of public communication, reproduction, distribution and transformation of the Contents, in all the existing exploitation modalities on the date of acceptance of these Terms and Conditions, for the whole time of validity of the rights object of cession, for the universal territorial scope."),
        TermAndCondition(title: "Publication of pet search and adoption advertisements", description: """
            "When posting your pet search and adoption ads, the User must take into account some considerations, including the following:
            - It is not allowed to publish images or descriptions that do not correspond to the advertised pet.
            - Only one pet per ad is allowed to be advertised.
            - It is not allowed to publish advertisements with sexual images.
            - It is not allowed to publish images of minors.
            In any case, the User must take into consideration the rules of publication when publishing his/her advertisements.
            On the other hand, the User interested in adopting a pet must take into account that LostAnimals is an application that acts as a mere intermediary and does not intervene in the adoption process. LostAnimals does not own any of the pets. LostAnimals does not review or validate the veracity of the ads that the Users spread through the service, so LostAnimals will not be in any case responsible, directly or indirectly, or subsidiarily, for damages of any nature, nor will be responsible for the lack of legality, reliability, usefulness, truthfulness, accuracy, completeness and timeliness of the same.
            """),
        TermAndCondition(title: "Invalidity and ineffectiveness of clauses", description: "If any provision of these Terms and Conditions is declared wholly or partly invalid or unenforceable, such invalidity or invalidity shall only affect that provision or that part of it which is invalid or unenforceable, and these Terms and Conditions shall otherwise remain in full force and effect, such provision or part of it being deemed not to be included."),
        TermAndCondition(title: "Applicable law and competent jurisdiction", description: "These Terms and Conditions shall be governed by and construed in accordance with Spanish law. In the event of a dispute between LostAnimals and the User, the User may bring his or her action before the Spanish courts corresponding to the domicile of LostAnimals, or before the courts of the place where the User is domiciled.")
    ]
    
    static let animalTypes: [AnimalType] = [
        .dog,
        .bird,
        .cat,
        .turtle,
        .snake,
        .rabbit,
        .other
    ]
}
