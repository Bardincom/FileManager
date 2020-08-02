//
//  ContentFileViewController.swift
//  FileManager
//
//  Created by Aleksey Bardin on 02.08.2020.
//  Copyright © 2020 Aleksey Bardin. All rights reserved.
//

import UIKit

class ContentFileViewController: UIViewController {

  @IBOutlet private var contentTextView: UITextView!
  var contentText: String?
  
    override func viewDidLoad() {
        super.viewDidLoad()

      contentTextView.text = contentText
    }

}
