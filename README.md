# mt-lints

## 分类

### oclint

- [installs]()
```
// Install by brew
brew tap oclint/formulae
brew install oclint

// Install by source code
brew install cmake ninja
git clone https://github.com/oclint/oclint
cd oclint-scripts
./make
cd build

// Env
OCLint_PATH=/Users/<username>/Desktop/oclint/build/oclint-release
export PATH=$OCLint_PATH/bin:$PATH

source .zshrc // source .bash_profile
```
- [download](https://github.com/oclint/oclint/releases/tag/v20.11)
- [custom lint rule](https://juejin.cn/post/6844903853775650830)
- [xcpretty]()


### swiftlint

- [download](https://github.com/realm/SwiftLint)
- [sample](https://github.com/muyexi/SwiftLinter)
- [pretty: swizzy]()
```
npm install -g swizzy
```
- [document](https://realm.github.io/SwiftLint/Enums/RuleKind.html), [document-in-github](https://github.com/realm/SwiftLint/blob/master/README_CN.md)
- [3th-doc](https://www.jianshu.com/p/eea2520f34ae), [TecentDoc](https://cloud.tencent.com/developer/article/1617958)
- Version mapping
Swift 版本	最后一个 SwiftLint 支持版本
Swift 1.x	- SwiftLint 0.1.2
Swift 2.x	- SwiftLint 0.18.1
Swift 3.x	- SwiftLint 0.25.1
Swift 4.0-4.1.x -	SwiftLint 0.28.2
Swift 4.2.x-5.0 -	最新的
