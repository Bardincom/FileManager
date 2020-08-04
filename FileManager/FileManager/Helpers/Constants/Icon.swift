//
//  Icon.swift
//  FileManager
//
//  Created by Aleksey Bardin on 24.07.2020.
//  Copyright © 2020 Aleksey Bardin. All rights reserved.
//

import UIKit

enum Icon {
  static let directory = UIImage(systemName: "folder.fill")
  static let addDirectory = UIImage(systemName: "folder.badge.plus")
  static let file = UIImage(systemName: "doc.fill")
  static let addFile = UIImage(named: "doc.badge.plus")
}

enum ObjectType {
  case directory, file
}
