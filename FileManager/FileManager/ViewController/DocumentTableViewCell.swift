//
//  DocumentTableViewCell.swift
//  FileManager
//
//  Created by Aleksey Bardin on 24.07.2020.
//  Copyright © 2020 Aleksey Bardin. All rights reserved.
//

import UIKit

final class DocumentTableViewCell: UITableViewCell {

  @IBOutlet private var imageFile: UIImageView!
  @IBOutlet private var nameFile: UILabel!

  func displayObject(_ object: String, object type: ObjectType) {
    nameFile.text = object
    
    switch type {
      case .directory:
      imageFile.image = Icon.directory
      case .file:
      imageFile.image = Icon.file
    }
  }
}
