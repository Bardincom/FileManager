//
//  DocumentsViewController.swift
//  FileManager
//
//  Created by Aleksey Bardin on 24.07.2020.
//  Copyright © 2020 Aleksey Bardin. All rights reserved.
//

import UIKit

final class DocumentsViewController: UIViewController {

  @IBOutlet private var documentsTableView: UITableView! {
    willSet {
      newValue.register(nibCell: DocumentTableViewCell.self)
    }
  }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension DocumentsViewController: UITableViewDelegate {

}

extension DocumentsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(reusable: DocumentTableViewCell.self, for: indexPath)
    cell.imageFile.image = UIImage(systemName: "folder.fill")
    cell.nameFile.text = "Document"
    return cell
  }
}
