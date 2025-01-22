//
//  MemoirApp.swift
//  Memoir
//
//  Created by Shaquille McGregor on 27/12/2024.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct MemoirApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authViewModel = AuthenticationViewModel()
    @StateObject private var apptViewModel = ApptViewModel(apptService: ApptService())
    @StateObject private var clientViewModel = ClientViewModel()
    @StateObject private var serviceViewModel = ServiceViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .environmentObject(apptViewModel)
                    .environmentObject(authViewModel)
                    .environmentObject(clientViewModel)
                    .environmentObject(serviceViewModel)
            }
        }
    }
}
