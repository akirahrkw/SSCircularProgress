# SSCircularProgress

SSCircularProgress provides circular loading bar, like Instagram loading bar.
This library is written by Swift, simple and easy to use.

## Swift Version
this branch supports swift 1.2

## Interface Builder

As SSCircularProgress inherits UIView and uses @IBDesignable, @IBInspectable, 
you can use it on IB and can change the line width and progress on Attributes Inspector

## Code

if you are using SDWebImage, the callback for progress can be like this

```swift

@IBOutlet weak var progressView: SSCircularProgress!
...
...

var progress = { [unowned self] (receivedSize: NSInteger, expectedSize: NSInteger) -> () in

    var progress = CGFloat(receivedSize) / CGFloat(expectedSize)
    self.progressView.updateProgress(progress)
}
```

and the callback for completed can be like this

```swift

var completed:SDWebImageCompletionBlock = { [weak self] (image:UIImage!, error:NSError!, cacheType:SDImageCacheType, imageUrl: NSURL!) in

    ...
    ...
    self.progressView.hidden = true
}
```
