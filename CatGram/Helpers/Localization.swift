//
//  Localization.swift
//  CatGram
//
//  Created by Iury Vasconcelos on 18/10/22.
//

import Foundation

struct Localization {

    struct Screens {
        
        struct ContentView {
            static let browseBar = String(localized: "browse_bar")
            static let uploadBar = String(localized: "upload_bar")
            static let profileBar = String(localized: "profile_bar")
            static let profileView = String(localized: "profile_view")
        }
        
        struct CommentsView {
            static let commentPlaceholder = String(localized: "comment_placeholder")
            static let commentBar = String(localized: "comment_bar")
        }
        
        struct UploadView {
            static let uploadCamera = String(localized: "upload_camera")
            static let uploadlibrary = String(localized: "upload_library")
        }
        
        struct PostView {
            static let actionText = String(localized: "action_text")
            static let actionReport = String(localized: "action_report")
            static let actionLearn = String(localized: "action_learn")
            static let actionReportQuestion = String(localized: "action_report_question")
            static let actionReport1 = String(localized: "action_report1")
            static let actionReport2 = String(localized: "action_report2")
            static let actionReport3 = String(localized: "action_report3")
            static let sharePost = String(localized: "share_post")
        }
        
        struct PostImageView {
            static let postImageViewPlaceholder = String(localized: "post_image_placeholder")
            static let postImageViewButton = String(localized: "post_image_button")
        }
        
        struct SettingsView {
            static let settingsAboutText = String(localized: "settings_about_text")
            
            static let settingsProfileEditDescription = String(localized: "settings_profile_edit_description")
            static let settingsProfileEditName = String(localized: "settings_profile_edit_name")
            static let settingsProfileEditPlaceholder = String(localized: "settings_profile_edit_placeholder")
            
            static let settingsBioEditDescription = String(localized: "settings_bio_edit_description")
            static let settingsBioEditName = String(localized: "settings_bio_edit_name")
            static let settingsBioEditPlaceholder = String(localized: "settings_bio_edit_placeholder")
            static let settingsBioEditName2 = String(localized: "settings_bio_edit_name2")
            
            static let settingsImageEditDescription = String(localized: "settings_image_edit_description")
            static let settingsImageEditName = String(localized: "settings_image_edit_name")
            
            static let settingsSignOut = String(localized: "settings_sign_out")
            static let settingsSignOut2 = String(localized: "settings_sign_out2")
            
            static let settingsPrivacy = String(localized: "settings_privacy")
            static let settingsTerms = String(localized: "settings_terms")
            static let settingsSite = String(localized: "settings_site")
            static let settingsApplication = String(localized: "settings_aplication")
            
            static let settingsSignOff = String(localized: "settings_sign_off")
            static let settingsBar = String(localized: "settings_bar")
        }
        
        struct SettingsEditTextView {
            static let settingsEditTextButton = String(localized: "settings_edit_text_button")
        }
        
        struct SettingsEditImageView {
            static let settingsEditImageButton = String(localized: "settings_edit_image_button")
        }
        
        struct SignUpView {
            static let signUpInfo = String(localized: "sign_up_info")
            static let signUpText = String(localized: "sign_up_text")
            static let signUpButton = String(localized: "sign_up_button")
        }
        
        struct OnboardingView {
            static let onboardingWelcome = String(localized: "onboarding_welcome")
            static let onboardingButton = String(localized: "onboarding_button")
            static let onboardingGuest = String(localized: "onboarding_guest")
            static let onboardingLogin = String(localized: "login_failed")
        }
        
        struct OnboardingViewPart2 {
            static let onboardingPart2Title = String(localized: "onboarding_part2_title")
            static let onboardingPart2Placeholder = String(localized: "onboarding_part2_placeholder")
            static let onboardingPart2Button = String(localized: "onboarding_part2_button")
            static let onboardingCreate = String(localized: "create_failed")
        }
    }
}
