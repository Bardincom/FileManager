//
//  DocumentsViewController.swift
//  FileManager
//
//  Created by Aleksey Bardin on 24.07.2020.
//  Copyright © 2020 Aleksey Bardin. All rights reserved.
//

import UIKit

final class DocumentsViewController: UIViewController {
  let fileManagerServise = FileManagerService()

  var path: String?

  var directoryPath: String? {
    get {
      return path
    }
    set {
      path = newValue
    }
  }

  @IBOutlet private var documentsTableView: UITableView! {
    willSet {
      newValue.register(nibCell: DocumentTableViewCell.self)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    print(NSHomeDirectory())
    setupNavigationBar()
  }
}

// MARK: DataSource
extension DocumentsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    fileManagerServise.listObject(at: directoryPath).count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(reusable: DocumentTableViewCell.self, for: indexPath)
    let object = fileManagerServise.listObject(at: directoryPath)[indexPath.row]
    cell.displayObject(object)
    return cell
  }
}

// MARK: Delegate
extension DocumentsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let object = fileManagerServise.listObject(at: directoryPath)[indexPath.row]
//    print("Путь выделенного файла \(object)")
    goToDirectory(object, with: object)

    documentsTableView.deselectRow(at: indexPath, animated: true)
  }

}

private extension DocumentsViewController {
  func setupNavigationBar() {
    navigationItem.rightBarButtonItems = .some([
      UIBarButtonItem(image: Icon.addFile, style: .plain, target: self, action: #selector(addFile)),
      UIBarButtonItem(image: Icon.addDirectory, style: .plain, target: self, action: #selector(addDirectory))
    ])
  }

  func goToDirectory(_ path: String, with name: String) {
    let viewController = DocumentsViewController()
    viewController.title = name
    viewController.directoryPath = path
    navigationController?.pushViewController(viewController, animated: true)
  }

  @objc
  func addDirectory() {
    Alert.showAlert(self, Names.directoryName) { name in
      self.fileManagerServise.createDirectory(at: self.directoryPath, with: name)
      self.documentsTableView.reloadData()
    }
  }

  @objc
  func addFile() {
    Alert.showAlert(self, Names.fileName) { name in
      self.fileManagerServise.createFile(at: self.directoryPath, with: name)
      self.documentsTableView.reloadData()
    }
  }

}
