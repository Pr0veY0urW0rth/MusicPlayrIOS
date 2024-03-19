//
//  Enums.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 13.11.2022.
//

import Foundation
import UIKit

//MARK: - Strings
enum AuthStrings{
    //title
    static let title = NSLocalizedString("Auth.title", comment: "title of app"),
               spotifyTitle = NSLocalizedString("Auth.spotifyTitle", comment: "title of Spotify auth page"),
               //labels
               helloWord = NSLocalizedString("Auth.helloWord", comment: "hello word"),
               spotifyInf = NSLocalizedString("Auth.spotify", comment: "Label for current app inform"),
               accountExists = NSLocalizedString("Auth.accountExists", comment: "Account question label for sign up screen"),
               accountNotExists = NSLocalizedString("Auth.accountNotExists", comment: "Account question label for login screen"),
               exit = NSLocalizedString("Auth.exit", comment: "exit label"),
               //textfields
               login = NSLocalizedString("Auth.login", comment: "user login"),
               email = NSLocalizedString("Auth.email", comment: "e-mail label"),
               password = NSLocalizedString("Auth.password", comment: "password label"),
               repeatPassword = NSLocalizedString("Auth.repeatPassword", comment: "2 password label"),
               //buttons
               signUp = NSLocalizedString("Auth.signUp", comment: "sing up button label"),
               signIn = NSLocalizedString("Auth.signIn", comment: "sign in button label"),
               signOut = NSLocalizedString("Auth.signOut", comment: "sign out button label"),
               //alerts
               regComplete = NSLocalizedString("Alert.regComplete" , comment: "Alert for complete registration"),
               invalidUsername = NSLocalizedString("Alert.invalidUsername", comment: "Alert for wrong username"),
               invalidEmail = NSLocalizedString("Alert.invalidEmail", comment: "Alert for wrong e-mail"),
               invalidFirstPas = NSLocalizedString("Alert.invalidFirstPas", comment: "Alert for wrong pas"),
               invalidSecondPas = NSLocalizedString("Alert.invalidSecondtPas", comment: "Alert for not matching pas"),
               invalidlogin = NSLocalizedString("Alert.invalidUserPas", comment: "Alert for invalid login"),
               ok = NSLocalizedString("Alert.Ok", comment: "o.k. for alert"),
               //alerts title
               invalidUsernameTitle = NSLocalizedString("AlertTitle.invalidUsername", comment: "Alert title for wrong username"),
               invalidEmailTitle = NSLocalizedString("AlertTitle.invalidEmail", comment: "Alert title for wrong e-mail"),
               invalidFirstPasTitle = NSLocalizedString("AlertTitle.invalidFirstPas", comment: "Alert title for wrong pas"),
               invalidSecondPasTitle = NSLocalizedString("AlertTitle.invalidSecondPas", comment: "Alert title for not matching pas"),
               regCompleteTitle = NSLocalizedString("AlertTitle.regComplete", comment: "Alert title for succesfull reg"),
               loginFailed = NSLocalizedString("AlertTitle.loginFailed", comment: "Alert title for unsuccesfull login")
}

enum PlayerStrings{
    //SectionTitles
    static let artistSectionTitle = NSLocalizedString("Sec.artist" , comment: "Text for artist section label"),
               albumsSectionTitle = NSLocalizedString("Sec.albums", comment: "Text for album section label"),
               playlistSectionTitle = NSLocalizedString("Sec.playlists", comment: "Text for playlist section label"),
               trackSectionTitle = NSLocalizedString("Sec.tracks", comment: "Text for track section label"),
               //Greetings for home
               morning = NSLocalizedString("Good.morning", comment: "Greeting for morning"),
               afternoon = NSLocalizedString("Good.afternoon", comment: "Greeting for aternoon"),
               evening = NSLocalizedString("Good.evening", comment: "Greeting for evening"),
               //search controller
               searchPlaceholder = NSLocalizedString("Search.placeholder", comment: "Text for search placeholder in search controller"),
               seacrhCancel = NSLocalizedString("Search.cancel", comment: "Text for search cancel"),
               //settings
               settingsTitle = NSLocalizedString("Settings.title", comment: "Text for settings title")
}

enum NavBarStrings{
    static let home = NSLocalizedString("Nav.home", comment: "label for home button"),
               search = NSLocalizedString("Nav.search", comment: "label for search button"),
               library = NSLocalizedString("Nav.library", comment: "label for library button"),
               profile = NSLocalizedString("Nav.profile", comment: "label for library button")
}

//MARK: - Errors strings
enum Errors{
    static let fatalError = "init(coder:) has not been implemented"
}

//MARK: - Image names
enum Images{
    static let authBackgroundImage = "Back",
               playerBackgroundImage = "Player",
               showPassword = "eye.fill",
               hidePassword = "eye.slash.fill",
               //navigation
               navHome = "house",
               navSearch = "magnifyingglass",
               navLib = "music.note.list",
               navProfile = "person.fill",
               //player
               trackPlaceholder = "placeholder",
               notifications = "bell",
               recent = "clock",
               options = "gearshape",
               //playerControls
               isPlaying = "pause.circle",
               isPaused = "play.circle",
               previous = "arrow.backward.circle",
               next = "arrow.right.circle",
               more = "ellipsis.circle",
               isNotLiked = "heart.circle",
               isLiked = "heart.circle.fill",
               mix = "shuffle.circle.fill",
               again = "repeat.circle.fill",
               againOne = "repeat.1.circle.fill",
               profilePic = "person.fill"
}

//MARK: - Cells
enum CellsIndetifiers{
    static let label = "Label",
               button = "Button",
               textField = "TextField",
               cell = "Cell",
               track = "MusicTrack",
               artist = "Artist",
               album = "Album",
               playlist = "Playlist",
               category = "Category",
               profile = "Profile",
               rectangleButton = "RectangleButton",
               squareButton = "SquareButton"
}

enum CellType{
    //textfield
    case login
    case password
    case email
    case repeatPassword
    //label
    case helloWord
    case accountExists
    case accountNotExists
    case spotifyInfo
    case exit
    //button
    case signUp
    case signIn
    case signOut
    //music
    case track
    //profile
    case profile
    //for init
    case spacer
    case none
    
    var cellIdentifier:String{
        switch self{
        case .login,.password,.email,.repeatPassword:
            return CellsIndetifiers.textField
        case .helloWord,.accountExists,.accountNotExists,.spotifyInfo,.exit,.spacer:
            return CellsIndetifiers.label
        case .signUp,.signIn,.signOut:
            return CellsIndetifiers.button
        case .track:
            return CellsIndetifiers.track
        case .profile:
            return CellsIndetifiers.profile
        case .none:
            return "none"
        }
    }
    var cellClass: UITableViewCell.Type{
        switch self{
        case .login,.password,.email,.repeatPassword:
            return TextFieldTableViewCell.self
        case .helloWord,.accountExists,.accountNotExists,.spotifyInfo,.exit,.spacer:
            return LabelTableViewCell.self
        case .signUp,.signIn,.signOut:
            return ButtonTableViewCell.self
        case .track:
            return MusicTrackTableViewCell.self
        case .profile:
            return ProfileTableViewCell.self
        case .none:
            return UITableViewCell.self
        }
    }
}

enum CollectionCellType{
    case track
    case artist
    case playlist
    case album
    case category
    
    var cellIdentifier:String{
        switch self{
        case .track:
            return CellsIndetifiers.track
        case .artist:
            return CellsIndetifiers.artist
        case .album:
            return CellsIndetifiers.album
        case .playlist:
            return CellsIndetifiers.playlist
        case .category:
            return CellsIndetifiers.category
        }
    }
    
    var cellClass: UICollectionViewCell.Type{
        switch self{
        case .track:
            return MusicTrackCollectionViewCell.self
        case .artist:
            return ArtistCollectionViewCell.self
        case .album:
            return AlbumCollectionViewCell.self
        case .playlist:
            return PlaylistCollectionViewCell.self
        case .category:
            return CategoryCollectionViewCelll.self
        }
    }
}

//MARK: - Headers

enum HeaderIndetifiers{
    static let section = "SectionHeader",
               home = "HomeHeader",
               artist = "ArtistHeader"
}

enum HeaderKind{
    static let section = "SectionKind",
               home = "HomeKind",
               artist = "ArtistKind"
}

enum HeaderType{
    case sectionHeader
    case homeHeader
    case artist
    
    var headerIdentifier:String{
        switch self{
        case .sectionHeader:
            return HeaderIndetifiers.section
        case .homeHeader:
            return HeaderIndetifiers.home
        case .artist:
            return HeaderIndetifiers.artist
        }
    }
    
    var headerKinds:String{
        switch self{
        case .sectionHeader:
            return HeaderKind.section
        case .homeHeader:
            return ""
        case .artist:
            return HeaderKind.artist
        }
    }
    
    var headerClass: UICollectionReusableView.Type{
        switch self{
        case .sectionHeader:
            return SectionHeader.self
        case .homeHeader:
            return HomeHeader.self
        case .artist:
            return ArtistHeader.self
        }
    }
}

//MARK: - Fonts
enum FontSize{
    static let label = 24.0
}

//MARK: - Modes
enum AuthMode{
    case signInMode
    case signUpMode
}

//MARK: - Keys for everything
enum Keys{
    //user defaults keys
    static let isLoggedIn = "IsLoggedIn",
               username = "Username",
               email = "Email",
               password = "Password",
               access_token = "access_token",
               refresh_token = "refresh_token",
               experationDate = "expirationDate"
}
//MARK: - View axis
enum Direction{
    case horizontal
    case vertical
}

//MARK: - Fonts

enum FontTypes{
    static let poppins = "Poppins-Regular",
               poppinsBold = "Poppins-Bold",
               poppinsLight = "Poppins-Light",
               poppinsSemibold = "Poppins-SemiBold"
    
}
