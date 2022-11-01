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
            
            static let postViewAlertTitle1 = String(localized: "alert_title1")
            static let postViewAlertMessage1 = String(localized: "alert_message1")
            static let postViewAlertTitle2 = String(localized: "alert_title2")
            static let postViewAlertMessage2 = String(localized: "alert_message2")

        }
        
        struct PostImageView {
            static let postImageViewPlaceholder = String(localized: "post_image_placeholder")
            static let postImageViewButton = String(localized: "post_image_button")
            
            static let postImageViewFailPostText = String(localized: "post_failed")
            static let postImageViewSuccessPostText = String(localized: "post_success")
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
            
            static let settingsFeedback = String(localized: "settings_feedback")
        }
        
        struct SettingsEditTextView {
            static let settingsEditTextButton = String(localized: "settings_edit_text_button")
            static let settingsEditSuccess = String(localized: "settings_edit_success")
        }
        
        struct SettingsEditImageView {
            static let settingsEditImageButton = String(localized: "settings_edit_image_button")
        }
        
        struct SignUpView {
            static let onboardingWelcome = String(localized: "onboarding_welcome")
            static let onboardingButton = String(localized: "onboarding_button")
            static let onboardingGuest = String(localized: "onboarding_guest")
            static let onboardingLogin = String(localized: "login_failed")
        }
        
        struct OnboardingView {
            static let onboardingTitle = String(localized: "onboarding_part2_title")
            static let onboardingPlaceholder = String(localized: "onboarding_part2_placeholder")
            static let onboardingButton = String(localized: "onboarding_part2_button")
            static let onboardingCreate = String(localized: "create_failed")
        }
        
        struct MailSignInView {
            static let mailSignInTitle = String(localized: "sign_in_mail_title")
            static let mailSignInPlaceholder = String(localized: "sign_in_mail_placeholder")
            static let passSignInTitle = String(localized: "sign_in_pass_title")
            static let passSignInPlaceholder = String(localized: "sign_in_pass_placeholder")
            static let mailSignInButton = String(localized: "sign_in_pass_button")
            static let mailSignInPassHint = String(localized: "password_hint")
        }
        
        struct WarningView {
            static let warningView = String(localized: "screen_warning")
            static let warningTitle = String(localized: "screen_title")
        }
    }
}
