//
//  Alert.swift
//  FileManager
//
//  Created by Aleksey Bardin on 26.07.2020.
//  Copyright © 2020 Aleksey Bardin. All rights reserved.
//

import UIKit

final class Alert {

  /// Выводит окно для ввода на звания файла или папки
  /// - Parameters:
  ///   - viewController: предать контроллер в котором немобходимо вывести алерт
  ///   - massage: передать сообщение что создаем
  ///   - hendler: передает название для файла или папка для  дальнейшего создания
  class func showAlert(_ viewController: UIViewController,
                       _ massage: String,
                       hendler: @escaping (String) -> Void) {

    let alert = UIAlertController(title: nil, message: massage, preferredStyle: .alert)
    alert.addTextField { textField in
      textField.placeholder = "Enter file name"
    }

    alert.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
    alert.addAction(.init(title: "Create", style: .default, handler: { _ in
      guard let nameFile = alert.textFields?.first?.text else { return }
      hendler(nameFile)
    }))

    viewController.present(alert, animated: true)

  }
}
