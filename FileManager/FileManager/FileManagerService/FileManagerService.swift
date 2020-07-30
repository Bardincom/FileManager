//
//  FileManagerService.swift
//  FileManager
//
//  Created by Aleksey Bardin on 25.07.2020.
//  Copyright © 2020 Aleksey Bardin. All rights reserved.
//

import Foundation

enum ObjectType {
  case directory
  case file
}

struct Object {
  var type: ObjectType
  var url: URL
  var name: String

}

struct FileManagerService {

  let mainDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first

  func writeDirectory(_ name: String, at path: String) {
    guard let urlPath = mainDirectory?.appendingPathComponent(path).appendingPathComponent(name) else { return }
    print("urlPath --- \(urlPath) ---")
    if !FileManager.default.fileExists(atPath: urlPath.path) {
      try? FileManager.default.createDirectory(at: urlPath, withIntermediateDirectories: false, attributes: nil)
    } else {
      print("Заходим сюда")
    }
//    guard let directory = getMainDirectory() else {
//      print("Сюда2")
//
//      return }
//    let path = getMainDirectory()?.appendingPathComponent(<#T##pathComponent: String##String#>) + "/" + "\(name)"
//    let path = directory.appendingPathComponent(path).appendingPathComponent(name)
//    try? FileManager.default.createDirectory(at: path, withIntermediateDirectories: false)

  }


//  func createDirectory(with name: String, at path: String) {
//         guard let url = documentDirectory?.appendingPathComponent(path).appendingPathComponent(name) else { return }
//         print("createDirectory \(url)")
//         if FileManager.default.fileExists(atPath: url.path) {
//             print("You alreade Have file with this name")
//         } else {
//             try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: false, attributes: nil)
//         }
//     }

  func writeFile(_ name: String) {

//        let path = getMainDirectory() + "/" + "\(name)"
//      FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
      }

  func listFiles(in directory: String) -> [Object] {
    print("Directory: \(directory)")
    guard let mainDirectory = mainDirectory?.appendingPathComponent(directory),
        let list = try? FileManager.default.contentsOfDirectory(atPath: mainDirectory.path)
        else {
          print("вот тут")
          return [] }
    print(mainDirectory)
    let object: [Object] = list.sorted().map { name in
        let url = mainDirectory.appendingPathComponent(name)

        if url.hasDirectoryPath {
          return Object(type: .directory, url: url, name: name)
        } else {
          return Object(type: .file, url: url, name: name)
        }
    }

      return object
    }
}

private extension FileManagerService {
  func getMainDirectory() -> URL? {
    guard let urlPath = mainDirectory else {
      print("Сюда1")
      return nil}
    return urlPath
  }
}
