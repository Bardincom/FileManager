//
//  FileManagerService.swift
//  FileManager
//
//  Created by Aleksey Bardin on 25.07.2020.
//  Copyright © 2020 Aleksey Bardin. All rights reserved.
//

import Foundation

struct FileManagerService {

  let mainDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first

  /// Список объектов содержищихся в директории
  /// - Parameter path: Путь к директории, если nil отображается список в корневой папке
  /// - Returns: Возвращаем список объектов
  func listObject(at path: String?) -> [String] {
    guard let path = path else {

      guard let directory = mainDirectory,
        let list = try? FileManager.default.contentsOfDirectory(atPath: directory.path) else { return [String]() }

      return getSortedObject(in: list, at: directory.path)
    }

    guard let directory = mainDirectory?.appendingPathComponent(path),
      let list = try? FileManager.default.contentsOfDirectory(atPath: directory.path) else { return [String]() }

    return getSortedObject(in: list, at: directory.path)
  }

  /// Создать директорию
  /// - Parameters:
  ///   - path: Путь директории, если nil создается в корневой папке
  ///   - name: Имя новой директории
  func createDirectory(at path: String?, with name: String) {
    guard let path = path else {

      guard let directory = mainDirectory?.appendingPathComponent(name) else { return }

      try? FileManager.default.createDirectory(atPath: directory.path, withIntermediateDirectories: false, attributes: nil)
      return
    }

    guard let directory = mainDirectory?.appendingPathComponent(path).appendingPathComponent(name) else { return }

    try? FileManager.default.createDirectory(atPath: directory.path, withIntermediateDirectories: false, attributes: nil)
  }

  /// Создать тектовый файл
  /// - Parameters:
  ///   - path: Путь создания файла, если nil создается в корневой папке
  ///   - name: Имя нового текстового файла
  func createFile(at path: String?, withName name: String) {
    guard let path = path else {

      guard let directory = mainDirectory?.appendingPathComponent(name) else { return }
      let rawData: Data? = "Hello, world".data(using: .utf8)
      FileManager.default.createFile(atPath: directory.path, contents: rawData, attributes: nil)
      return
    }

    guard let directory = mainDirectory?.appendingPathComponent(path).appendingPathComponent(name) else { return }

    let rawData: Data? = "Hello, world".data(using: .utf8)
    FileManager.default.createFile(atPath: directory.path, contents: rawData, attributes: nil)
  }


  /// Считывает содержимое файла
  /// - Parameters:
  ///   - path: Путь файла
  ///   - name: Имя файла
  /// - Returns: Возвращает опциональную строку с результатом.
  func readFile(at path: String?, withName name: String) -> String? {
    guard let path = path else {

      guard let directory = mainDirectory?.appendingPathComponent(name) else { return nil }

      guard let fileContent = FileManager.default.contents(atPath: directory.path),
              let fileContentEncoded = String(bytes: fileContent, encoding: .utf8) else {
                  return nil
          }

      return fileContentEncoded
    }

    guard let directory = mainDirectory?.appendingPathComponent(path).appendingPathComponent(name) else { return nil }

    guard let fileContent = FileManager.default.contents(atPath: directory.path),
            let fileContentEncoded = String(bytes: fileContent, encoding: .utf8) else {
                return nil
        }

    return fileContentEncoded
    }

  /// Удаляет объект по переданным данным
  /// - Parameters:
  ///   - path: Путь к объекту
  ///   - name: Имя объекта
  func deleteObject(at path: String?, withName name: String) {
    guard let path = path else {
      guard let directory = mainDirectory?.appendingPathComponent(name) else { return}
      do {
        try FileManager.default.removeItem(at: directory)
      } catch let error {
        print("Error: \(error.localizedDescription)")
      }
      return }

    guard let directory = mainDirectory?.appendingPathComponent(path).appendingPathComponent(name) else {
           return
       }

    do {
      try FileManager.default.removeItem(at: directory)
    } catch let error {
      print("Error: \(error.localizedDescription)")
    }
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
