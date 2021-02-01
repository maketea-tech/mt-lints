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


### swiftlint

- [download](https://github.com/realm/SwiftLint)
- [sample](https://github.com/muyexi/SwiftLinter)
