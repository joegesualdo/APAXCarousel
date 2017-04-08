//
//  APAXCarouselController.swift
//  APAXCarousel
//
//  Created by Joe Gesualdo on 4/8/17.
//  Copyright © 2017 Joe Gesualdo. All rights reserved.
//

import Foundation
import UIKit

public class APAXCarouselController: UIViewController , UIPageViewControllerDataSource, UIPageViewControllerDelegate{
  var pageViewController: UIPageViewController!
  var contentControllers: [UIViewController]!
  var currentIndex: Int = 0
  var transitioningToIndex: Int = 0
  var onChangePage: ((_ pageIndex: Int) -> Void)!
  
  public convenience init(withContentControllers contentControllers: [UIViewController], onChangePage: @escaping ((_ pageIndex: Int) -> Void)){
    self.init()
    self.onChangePage = onChangePage
    self.contentControllers = contentControllers
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nil, bundle: nil)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func getCurrentPageIndex() -> Int {
    return self.currentIndex
  }
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.white
    
    self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    self.pageViewController.dataSource = self
    self.pageViewController.delegate = self
    
    // Ad child controllers
    self.addChildViewController(self.pageViewController)
    // Add child views
    let pageView = self.pageViewController.view
    self.view.addSubview(pageView!)
    
    pageView?.translatesAutoresizingMaskIntoConstraints = false;
    pageView?.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    pageView?.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
    pageView?.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    pageView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    
    self.pageViewController.didMove(toParentViewController: self)
    
    setPage(index: 0)
  }
  public func setPage(index: Int) {
    self.currentIndex = index
    self.pageViewController.setViewControllers([self.viewControllerAtIndex(index: index)], direction: .forward, animated: true, completion: nil)
    self.onChangePage(index)
  }
  
  func viewControllerAtIndex(index: Int) -> UIViewController {
    let contentViewController = self.contentControllers[index]
    return contentViewController
  }
  
  
  // MARK: - Page View Controller Data Source
  public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    
    if (self.currentIndex == 0 || self.currentIndex == NSNotFound) {
      return nil
    }
    let newIndex = self.currentIndex - 1
    return self.viewControllerAtIndex(index: newIndex)
  }
  
  public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    if (self.currentIndex == self.contentControllers.count - 1 || self.currentIndex == NSNotFound) {
      return nil
    }
    let newIndex = self.currentIndex + 1
    return self.viewControllerAtIndex(index: newIndex)
  }
  
  public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    let previousViewController = previousViewControllers[0]
    let previousIndex = self.contentControllers.index(of: previousViewController)
    if (completed) {
      if (transitioningToIndex == previousIndex) {
        // do nothing
      } else if (transitioningToIndex > previousIndex!){
        if (currentIndex < self.contentControllers.count) {
          self.currentIndex = currentIndex + 1
        }
      } else {
        if (currentIndex > 0) {
          self.currentIndex = currentIndex - 1
        }
      }
      setPage(index: currentIndex)
    } else {
      // Need this incase we do a half slide but don't do the full thing
      if (transitioningToIndex > previousIndex!) {
        if (currentIndex > 0) {
          transitioningToIndex = transitioningToIndex - 1
        }
      } else {
        if (currentIndex <= self.contentControllers.count) {
          transitioningToIndex = transitioningToIndex + 1
        }
      }
    }
  }
  public func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
    let futureIndex = self.contentControllers.index(of: pendingViewControllers[0])
    self.transitioningToIndex = futureIndex!
  }
}
