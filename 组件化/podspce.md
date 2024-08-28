参考文章:
1. [cocoapods官网](https://guides.cocoapods.org/syntax/podspec.html#macos)
2. [公有库](https://www.jianshu.com/p/3ded0c98a7d4)
3. 登录用户失效，需重新注册
```
pod trunk register 'chenjie003@qq.com' 'chenxiaojie' --description='chenxiaojie'
```

(1) 提交内容：git commit -m'修改内容'

(2) 打tag： git tag 0.2.8
(3) 推tag: git push --tags
(4) 推送远程仓库，如下：

#### 一、公有库(github)
1. 推到远程仓库，如：
```
TXBaseKit:
 pod trunk push TXBaseKit.podspec --use-libraries --allow-warnings

TXCommonKit:
 pod trunk push TXCommonKit.podspec --allow-warnings

TXCategoryKit
pod trunk push TXCategoryKit.podspec --use-libraries --allow-warnings --skip-import-validation

```

2. 校验 podspec 是否符合规范
```
pod spec lint TXCategoryKit.podspec --use-libraries --allow-warnings --skip-import-validation

pod spec lint TXCommonKit.podspec --use-libraries --allow-warnings

pod spec lint TXBaseKit.podspec --use-libraries --allow-warnings
```

#### 二、私有库
```
CJBaseKit
pod lib lint --sources='http://192.168.11.241:10080/chenjie/CJBaseKit.git','http://192.168.11.241:10080/chenjie/TXCategoryKit.git','http://192.168.11.241:10080/chenjie/CJCommonKit.git' --allow-warnings


pod lib lint --sources='http://192.168.11.241:10080/chenjie/CJBaseKit.git','http://192.168.11.241:10080/chenjie/TXCategoryKit.git','http://192.168.11.241:10080/chenjie/CJCommonKit.git' --allow-warnings

pod repo remove CJBaseKit
pod repo add CJBaseKit http://192.168.11.241:10080/chenjie/CJBaseKit.git
pod repo push CJBaseKit CJBaseKit.podspec --allow-warnings


CJCommonKit
pod repo remove CJCommonKit
pod repo add CJCommonKit http://192.168.11.241:10080/chenjie/CJCommonKit.git
pod repo push CJCommonKit CJCommonKit.podspec --allow-warnings

CJCustomKit
pod repo remove CJCustomKit
pod repo add CJCustomKit http://192.168.11.241:10080/chenjie/CJCustomKit.git
pod repo push CJCustomKit CJCustomKit.podspec --allow-warnings
```

pod update 库名 --verbose --no-repo-update
