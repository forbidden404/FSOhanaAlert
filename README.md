# FSOhanaAlert

## Overview

FSOhanaAlert is a subclass of UIView, written in Swift, that creates simple Alert Views for Ohana - Family Together 

## Requirements
* iOS11

## Installation with CocoaPods

FSOhanaAlert is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "FSOhanaAlert"
```

## Usage

```Swift
import FSOhanaAlert

// Helper function that makes completion better
func completion<Result>(onResult: @escaping (Result) -> Void, onError: @escaping (Error) -> Void) -> ((Result?, Error?) -> Void) {
    return { (maybeResult, maybeError) in
        if let result = maybeResult {
            onResult(result)
        } else if let error = maybeError {
            onError(error)
        } else {
            onError(FSError.NoResultFound)
        }
    }
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let alertView = FSOhanaCustomAlert(frame: self.view.bounds)
        alertView.set(text: "Do you wish to take this activity?")
        alertView.set(image: #imageLiteral(resourceName: "icon_real"))
        
        alertView.set(completion: completion(
            onResult: { (result) in print("took")
                                    alertView.removeFromSuperview()
        },
            onError: { (error) in print("leave")
                                    alertView.removeFromSuperview()
        }), with: ["Cancel", "Take"])

        self.view.addSubview(alertView)
        self.view.bringSubview(toFront: alertView)
    }


```

## Author

Francisco Soares

## License

FSOhanaAlert is available under the MIT license. See the LICENSE file for more info.
