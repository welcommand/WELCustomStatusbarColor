# WELCustomStatusbarColor

change your Statusbar Color


<img src="https://github.com/welcommand/WELCustomStatusbarColor/blob/master/imgRes/1.png" width="22%" height="22%"> <img src="https://github.com/welcommand/WELCustomStatusbarColor/blob/master/imgRes/2.png" width="22%" height="22%"> <img src="https://github.com/welcommand/WELCustomStatusbarColor/blob/master/imgRes/3.png" width="22%" height="22%"> <img src="https://github.com/welcommand/WELCustomStatusbarColor/blob/master/imgRes/4.png" width="22%" height="22%">


## install with pod
```bash
    pod 'WELCustomStatusbarColor','~>1.0.5'
```

## How To Use

first you should remove these method from you project

```bash
    -[UIViewController preferredStatusBarStyle]
    -[UINavigationController childViewControllerForStatusBarStyle]
```

than you can call +[WELCustomStatusbarColor updateStatusbarIconColor:] everywhere
