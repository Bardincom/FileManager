//
//  DocumentsViewController.swift
//  FileManager
//
//  Created by Aleksey Bardin on 24.07.2020.
//  Copyright © 2020 Aleksey Bardin. All rights reserved.
//

import UIKit

final class DocumentsViewController: UIViewController {
  var documentStorage = [String]()

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
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //    documentStorage.count
    1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(reusable: DocumentTableViewCell.self, for: indexPath)
    cell.imageFile.image = Icon.addFile
    cell.nameFile.text = "Document"
    return cell
  }
}

// MARK: Delegate
extension DocumentsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("Нажали на ячейку")

    documentsTableView.deselectRow(at: indexPath, animated: true)
  }

}

private extension DocumentsViewController {
  func setupNavigationBar() {
    title = Names.documents
    navigationItem.rightBarButtonItems = .some([
      UIBarButtonItem(image: Icon.addFile, style: .plain, target: self, action: #selector(tapButton)),
      UIBarButtonItem(image: Icon.addDirectory, style: .plain, target: self, action: #selector(tapButton))
    ])
  }

  @objc
  func tapButton() {
    print("Tap")
  }
}
