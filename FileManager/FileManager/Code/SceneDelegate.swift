//
//  SceneDelegate.swift
//  FileManager
//
//  Created by Aleksey Bardin on 24.07.2020.
//  Copyright © 2020 Aleksey Bardin. All rights reserved.
// swiftlint:disable unused_optional_binding

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }

    assembly(windowScene)

  }
}

private extension SceneDelegate {
  func assembly(_ windowScene: UIWindowScene ) {
    window = UIWindow(frame: windowScene.coordinateSpace.bounds)
    window?.windowScene = windowScene
    let viewController = DocumentsViewController()
    viewController.title = Names.documents
    let navigationViewController = UINavigationController(rootViewController: viewController)
    window?.rootViewController = navigationViewController

    window?.makeKeyAndVisible()
  }
}
