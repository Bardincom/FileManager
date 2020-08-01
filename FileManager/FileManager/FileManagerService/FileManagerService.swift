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

  /// Список обхектов содержищихся в директории
  /// - Parameter path: Путь к директории, если nil отображается список в корневой папке
  /// - Returns: Возвращаем список объектов
  func listObject(at path: String?) -> [String] {

    guard let path = path else {

      guard let directoryPath = mainDirectory?.path,
        let list = try? FileManager.default.contentsOfDirectory(atPath: directoryPath) else { return [String]() }
      return list
    }

    guard let directoryPath = mainDirectory?.appendingPathComponent(path).path,
      let list = try? FileManager.default.contentsOfDirectory(atPath: directoryPath) else { return [String]() }

    return list
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

}

