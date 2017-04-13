# APAXCarousel
> A simple to implement iOS carousel.

![](https://github.com/joegesualdo/APAXCarousel/raw/master/APAXCarousel_demo.gif)

# Install
```ruby
pod 'APAXCarousel', '0.1.1'
```

# Usage
```swift
class ViewController: UIViewController {
  let carouselController: APAXCarouselController!

  override func viewDidLoad() {
    ...
    let contentControllers: [UIViewController] = [...]

    self.carouselController = APAXCarouselController(
      withContentControllers: contentControllers,
      onChangePage: {pageIndex in
        print("Changed to page: \(pageIndex)")
      },
      onScroll: {(transitioningToPageIndex, percentComplete) in
        print("\(percentComplete*100)% complete transitioning to page: \(transitioningToPageIndex)")

      }
    )

    self.addChildViewController(self.carouselController)
    self.view.addSubview(self.carouselController)
    self.carouselController.didMove(toParentViewController: self)
    ...
  }
}
```
> Remember to add constraints or frame information (width, height, x, y) on the carousel view.

```swift
self.carouselController.view.translatesAutoresizingMaskIntoConstraints = false;
self.carouselController.view.heightAnchor.constraint(equalToConstant: 100).isActive = true
self.carouselController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
self.carouselController.view.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
```
