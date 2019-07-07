# ElMenus

# Requirements:

- iOS 11.0+ 
- Xcode 10.2+
- Swift 4.2+

# Libraries:

- SVProgressHUD : is a clean and easy-to-use HUD meant to display the progress of an ongoing task
![SVProgressHUD](http://f.cl.ly/items/2G1F1Z0M0k0h2U3V1p39/SVProgressHUD.gif)
- RealmSwift : is a mobile database that runs directly inside phones, tablets or wearables. This repository holds the source code for the iOS, macOS, tvOS & watchOS versions of Realm Swift & Realm Objective-C.
- SDWebImage : This library provides an async image downloader with cache support.
- UIScrollView-InfiniteScroll : Infinite scroll implementation as a category for UIScrollView
- Alamofire : used this library to check Connectivity
- SwiftMessageBar : used this library to show alert message for error

# Features:

- Fetch list of tags from mock api
- Fetch list of items based on tag name from mock api 
- cache the API response and display it in offline mode.

# Architecture:

MVVM design pattern : 

- Modelis a class that declares properties for managing business data
- View is represented by the UIView or UIViewController objects, accompanied with their .xib and .storyboard files, which should only display prepared data.
- ViewModel The viewModel is at the heart of the MVVM design pattern and provides the connection between the business logic and the view/view controller. The view (UI) responds to user input by passing input data (defined by the model) to the viewModel. In turn, the viewModel evaluates the input data and responds with an appropriate UI presentation according business logic workflow.






