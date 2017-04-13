//
//  ViewController.swift
//  APAXCarousel
//
//  Created by Joe Gesualdo on 4/8/17.
//  Copyright © 2017 Joe Gesualdo. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {
  var walkThroughtViewController: APAXCarouselController!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let contentViewController1 = ContentViewController()
    let contentViewController2 = ContentViewController()
    let contentViewController3 = ContentViewController()
    let contentViewController4 = ContentViewController()
    let contentViewController5 = ContentViewController()
    let contentControllers = [
      contentViewController1,
      contentViewController2,
      contentViewController3,
      contentViewController4,
      contentViewController5
    ]
    
    self.walkThroughtViewController = APAXCarouselController(
      withContentControllers: contentControllers,
      onChangePage: {pageIndex in
//        self.pageControlController.selectAtIndex(pageIndex)
        print("Changed to page: \(pageIndex)")
      },
      onScroll: {(transitioningToPageIndex, percentComplete) in
        self.walkThroughtViewController.contentControllers[transitioningToPageIndex].view.alpha = CGFloat(percentComplete)
        print("\(percentComplete*100)% complete transitioning to page \(transitioningToPageIndex)")

      }
    )
    
    self.addChildViewController(self.walkThroughtViewController)
    self.view.addSubview(self.walkThroughtViewController.view!)
    
//    self.walkThroughtViewController.setPage(index: 2)
    print(walkThroughtViewController.getCurrentPageIndex())
    
    walkThroughtViewController.view.translatesAutoresizingMaskIntoConstraints = false;
    walkThroughtViewController.view.heightAnchor.constraint(equalToConstant: 100).isActive = true
    walkThroughtViewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -400).isActive = true
    walkThroughtViewController.view.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    
    self.walkThroughtViewController.didMove(toParentViewController: self)
    
//    self.walkThroughtViewController.view.removeFromSuperview()
//    self.walkThroughtViewController.removeFromParentViewController()
  }
}


