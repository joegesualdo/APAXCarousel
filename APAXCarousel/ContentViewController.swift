//
//  ContentViewController.swift
//  APAXCarousel
//
//  Created by Joe Gesualdo on 4/8/17.
//  Copyright © 2017 Joe Gesualdo. All rights reserved.
//

import Foundation
import UIKit

public class ContentViewController: UIViewController {
  var pageIndex: Int!
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    let imageView = UIView()
    imageView.backgroundColor = getRandomColor()
    
//    imageView.contentMode = .scaleAspectFit
//    imageView.image = #imageLiteral(resourceName: "grumpy-cat-4")
    
//    if let url = URL.init(string:PAGES[self.pageIndex].image) {
//      getImageFromURL(
//        url: url,
//        onSuccess: { (image) in
//          imageView.image = image
//        },
//        onError: { (data, response, error) in
//          print("Error loading image")
//        }
//      )
//    }
    self.view.addSubview(imageView)
    
    imageView.translatesAutoresizingMaskIntoConstraints = false;
    imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
    imageView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
    imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    imageView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
  }
}

// FETCH IMAGE
// Modiefied from:
//  http://stackoverflow.com/questions/41132122/how-to-download-image-with-url-swift-3
func getImageDataFromURL(url: URL, onSuccess: @escaping ((_ data: Data, _ response: URLResponse) -> Void), onError: @escaping ((_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void)) {
  let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
    let httpURLResponse = response as? HTTPURLResponse
    let mimeType = response?.mimeType
    // Right now were erroring out if status code is anythign but 200 and the mime type is onot set to image
    let hasError: Bool = httpURLResponse?.statusCode != 200 || !(mimeType?.hasPrefix("image"))! || error != nil
    if (hasError) {
      onError(data, response, error)
    } else {
      onSuccess(data!, response!)
    }
  }
  session.resume()
}

func getImageFromURL(url: URL, onSuccess: @escaping ((_ image: UIImage) -> Void), onError: @escaping ((_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void)) {
  getImageDataFromURL(
    url: url,
    onSuccess: { (data, response) in
      let image = UIImage(data: data as Data)
      onSuccess(image!)
    },
    onError: { (data, response, error) in
      onError(data, response, error)
    }
  )
}

func getRandomColor() -> UIColor{
  //Generate between 0 to 1
  let red:CGFloat = CGFloat(drand48())
  let green:CGFloat = CGFloat(drand48())
  let blue:CGFloat = CGFloat(drand48())
  
  return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
}
