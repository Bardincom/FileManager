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
  let list = [String]()

  @IBOutlet private var documentsTableView: UITableView! {
    willSet {
      newValue.register(nibCell: DocumentTableViewCell.self)
    }
  }
  var path = ""
  var directoryPath: String {
    get {
      return path
    }
    set {
      path = newValue
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
//    print(NSHomeDirectory())
    setupNavigationBar()
  }
}

// MARK: DataSource
extension DocumentsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    fileManagerServise.listFiles(in: directoryPath).count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(reusable: DocumentTableViewCell.self, for: indexPath)
    let object = fileManagerServise.listFiles(in: directoryPath)[indexPath.row]
    cell.displayObject(object)
    return cell
  }
}

// MARK: Delegate
extension DocumentsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let object = fileManagerServise.listFiles(in: directoryPath)[indexPath.row]
    goToDirectory(object.url.absoluteString, with: object.name)

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
    Alert.showAlert(self, Names.directoryName) {
      print(self.directoryPath)
      self.fileManagerServise.writeDirectory($0, at: self.directoryPath)
      self.documentsTableView.reloadData()
    }
  }

  @objc
  func addFile(_ directory: String) {
    Alert.showAlert(self, Names.fileName) {
      self.fileManagerServise.writeFile($0)
      self.documentsTableView.reloadData()
    }
  }
}
