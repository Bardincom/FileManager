//
//  FileManagerService.swift
//  FileManager
//
//  Created by Aleksey Bardin on 25.07.2020.
//  Copyright © 2020 Aleksey Bardin. All rights reserved.
//

import Foundation

//enum ObjectType {
//  case directory
//  case file
//}
//
//struct Object {
//  var type: ObjectType
//  var url: URL
//  var name: String
//}

struct FileManagerService {

  let mainDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first

  /// Список объектов содержищихся в директории
  /// - Parameter path: Путь к директории, если nil отображается список в корневой папке
  /// - Returns: Возвращаем список объектов
  func listObject(at path: String?) -> [String] {

    guard let path = path else {

      guard let directoryPath = mainDirectory?.path,
        let list = try? FileManager.default.contentsOfDirectory(atPath: directoryPath) else { return [String]() }

      return getSortedObject(in: list, at: directoryPath)
    }

    guard let directoryPath = mainDirectory?.appendingPathComponent(path).path,
      let list = try? FileManager.default.contentsOfDirectory(atPath: directoryPath) else { return [String]() }

    return getSortedObject(in: list, at: directoryPath)
  }

  /// Создать директорию
  /// - Parameters:
  ///   - path: Путь директории, если nil создается в корневой папке
  ///   - name: Имя новой директории
  func createDirectory(at path: String?, with name: String) {
    guard let path = path else {

      guard let directoryPath = mainDirectory?.appendingPathComponent(name).path else { return }
      try? FileManager.default.createDirectory(atPath: directoryPath, withIntermediateDirectories: true, attributes: nil)
      return
    }

    guard let directoryPath = mainDirectory?.appendingPathComponent(path).appendingPathComponent(name).path else { return }
    try? FileManager.default.createDirectory(atPath: directoryPath, withIntermediateDirectories: true, attributes: nil)
  }

  /// Создать тектовый файл
  /// - Parameters:
  ///   - path: Путь создания файла, если nil создается в корневой папке
  ///   - name: Имя нового текстового файла
  func createFile(at path: String?, with name: String) {
    guard let path = path else {

      guard let directoryPath = mainDirectory?.appendingPathComponent(name).path else { return }
      let rawData: Data? = "Hello, world".data(using: .utf8)
      FileManager.default.createFile(atPath: directoryPath, contents: rawData, attributes: nil)
      return
    }

    guard let directoryPath = mainDirectory?.appendingPathComponent(path).appendingPathComponent(name).path else { return }

    let rawData: Data? = "Hello, world".data(using: .utf8)
    FileManager.default.createFile(atPath: directoryPath, contents: rawData, attributes: nil)
  }

  func readFile(at path: String?, with name: String) -> String? {
    guard let path = path else {

      guard let directoryPath = mainDirectory?.appendingPathComponent(name) else { return nil }

      guard let fileContent = FileManager.default.contents(atPath: directoryPath.path),
              let fileContentEncoded = String(bytes: fileContent, encoding: .utf8) else {
                  return nil
          }

      return fileContentEncoded
    }

    guard let directoryPath = mainDirectory?.appendingPathComponent(path).appendingPathComponent(name) else { return nil }

    guard let fileContent = FileManager.default.contents(atPath: directoryPath.path),
            let fileContentEncoded = String(bytes: fileContent, encoding: .utf8) else {
                return nil
        }

    return fileContentEncoded
    }
}

private extension FileManagerService {
  func getSortedObject(in listObject: [String], at path: String) -> [String] {
    let listDirectory = listObject.filter { name -> Bool in
      FileManager.default.contents(atPath: path + "/" + name) == nil
    }.sorted()

    let listFile = listObject.filter { name -> Bool in
      FileManager.default.contents(atPath: path + "/" + name) != nil
    }.sorted()

    return listDirectory + listFile
  }

}
