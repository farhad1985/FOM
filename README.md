## FOM

Fom is a time management application based on the Pomodoro technique

<p align="center">
 <img src="/screenshots/logo.png" align="center"  />
</p>

## Support
Using this app is free but if you enjoy using it, you can support me :)

<a href="https://buymeacoffee.com/farhadpublw" target="_blank">
    <img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;">
</a>


## Install

open your terminal and enter pod install

```
pod 'KitUI'
```

## How to Use

```swift
import KitUI

class MyViewController: UIViewController {

    private var vwMain = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        vwMain
            .add(base: self.view)
            .setBackground(color: .purple)
            .setCorner(radius: 16)
            .width(constant: 200)
            .height(constant: 80)
            .center(to: self.view)
    }

}
```

you can set attribute for your view and set constraints and add it into your SuperView :) that's it.
