# Dynamic layout example project

This project is using a library called [Spots](https://github.com/hyperoslo/spots) to handle the dynamic layout of the views.
It is almost the same as how FINN.no's apps are built. But the FINN version is not open-sourced, so we use Spots in this example. 

There are layout bugs in the code and it will not handle all possible combinations of different types, span, etc.

So just play around with it and get the understanding of how this works and what problems it solves.

## Install
We are using [Carthage](https://github.com/Carthage/Carthage) to handle dependencies.

**How to install**

```
$ brew install Carthage
```

If you don't have or want to use [homebrew](http://brew.sh/), just install the latest .pkg file from [gitub releases](https://github.com/Carthage/Carthage/releases).

After the installation of Carthage you should be able to build and run the project

## Project information

All layout configuration files can be found in the Layout folder. Each layout folder containes a number of components.
```json
{
"components": [{
        "type": "Grid",
        "items": [{
            "type": "",
            "title": ""
            "subtitle": ""
            "image": "",
            "meta": {}
        }]
    }]
}
```

The component type 'cell' can be found in the Component folder. They are not used for much now, but can be editited to create custom components, change colors, etc.
If you want to see a custom component take a look at the included 'CarouselSpot'.

Each component contains a list of items and each item will decide how to layout the data provided. The data provided could include a image, title, subtitle or multiple key-value's in the meta dictionary.
In the meta dictonary could include for example font type, size, color, etc. It's up to each implemented item to handle these meta data.

To add new component or item you must register them into the SDK. This is currently done in the AppDelegate.swift

```
GridSpot.views["image"] = Image.self
GridSpot.views["titleTextBox"] = TitleTextBox.self
GridSpot.views["imageTitleBox"] = ImageTitleBox.self
GridSpot.views["imageTitleList"] = ImageTitleList.self

ListSpot.views["imageTitleList"] = ImageTitleList.self

CarouselSpot.views["image"] = Image.self
CarouselSpot.views["imageTitleList"] = ImageTitleList.self

SpotFactory.register("grid", spot: Grid.self)
SpotFactory.register("horizontal", spot: Horizontal.self)
```

### Changing layout files

Some examples could be to change (in search-list-v1.json):
- span=1 to span=2
- type=imageTitleHorizontal to type=imageTitleVertical

or (in object-page-v1.json):
- change the first grid from span=1 to span=2
- change image list from type=horizontal to type=grid or span=1 to span=2.


## Extra information
### Dependency handling

**How to add/update dependencies**

To add or update a dependency you need to change the Cartfile.
Just update the version number or add a new entry.

```
# Alamofire
github "Alamofire/Alamofire" == 1.2
```

When the file is changed you need to run:
```
carthage update --platform ios

*** Fetching Alamofire
*** Checking out Alamofire at "1.2.0"
*** xcodebuild output can be found in /var/folders/1w/6spscgds1pn1kkpgg_gq5ch80000gn/T/carthage-xcodebuild.nzJZdw.log
*** Building scheme "Alamofire iOS" in Alamofire.xcworkspace
```

When adding a new framework, it must be added to the project as a dependency.

1. On your application targets’ “General” settings tab, in the “Linked Frameworks and Libraries” section, drag and drop each framework you want to use from the Carthage/Build folder on disk.

1. On your application targets’ Build Phases” settings tab, click the “+” icon and choose “New Run Script Phase”. Create a Run Script with the following contents:

```sh
/usr/local/bin/carthage copy-frameworks
```

and add the paths to the frameworks you want to use under “Input Files”, e.g.:

```
$(SRCROOT)/Carthage/Build/iOS/Alamofire.framework
```