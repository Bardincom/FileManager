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

    setupNavigationBar()
  }
}

// MARK: DataSource
extension DocumentsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return fileManagerServise.listObject(at: directoryPath).count
  }

  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(reusable: DocumentTableViewCell.self, for: indexPath)
    let object = fileManagerServise.listObject(at: directoryPath)[indexPath.row]

    if let _ = fileManagerServise.readFile(at: directoryPath, withName: object) {
      cell.displayObject(object, object: .file)
    } else {
      cell.displayObject(object, object: .directory)
    }

    return cell
  }

  func tableView(_ tableView: UITableView,
                 commit editingStyle: UITableViewCell.EditingStyle,
                 forRowAt indexPath: IndexPath) {
    let object = fileManagerServise.listObject(at: directoryPath)[indexPath.row]

    if editingStyle == .delete {
      fileManagerServise.deleteObject(at: directoryPath, withName: object)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
}

// MARK: Delegate
extension DocumentsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView,
                 didSelectRowAt indexPath: IndexPath) {
    documentsTableView.deselectRow(at: indexPath, animated: true)

    let name = fileManagerServise.listObject(at: directoryPath)[indexPath.row]
    var newPath: String

    guard var url = fileManagerServise.mainDirectory else { return }

    switch path {
      case nil:
        url = url.appendingPathComponent(name)
        newPath = name
      default:
        guard let directoryPath = directoryPath else { return }
        url = url.appendingPathComponent(directoryPath).appendingPathComponent(name)
        newPath = directoryPath + "/" + name
    }

    guard let text = fileManagerServise.readFile(at: directoryPath, withName: name) else {
      goToDirectory(newPath, with: name)
      return }

    openFileContent(name, with: text)
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

  func openFileContent(_ name: String, with text: String) {
    let viewController = ContentFileViewController()
    viewController.title = name
    viewController.contentText = text
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
      self.fileManagerServise.createFile(at: self.directoryPath, withName: name)
      self.documentsTableView.reloadData()
    }
  }

}
