

# iOS 组件化

### 制作 cocoapods 组件库

#### 0x01 如何使用模版创建 Cocoapods 库

```bash
# 使用模版创建私有库
pod lib create [库名称]
# 使用平台
What platform do you want to use?? [ iOS / macOS ]
 > iOS
# 编程语言
What language do you want to use?? [ Swift / ObjC ]
 > Objc
# 是否创建调试Demo
Would you like to include a demo application with your library? [ Yes / No ]
 > Yes
# 是否启用测试框架
Which testing frameworks will you use? [ Specta / Kiwi / None ]
 > None
# 是否启用UI测试框架
Would you like to do view based testing? [ Yes / No ]
 > No
# 类前缀
What is your class prefix?
 > CBD
```

#### 0x02 文件结构

```bash
├── Example
│   ├── Podfile
│   ├── Podfile.lock
│   ├── Pods
│   ├── PrivatePodsDemo
│   ├── PrivatePodsDemo.xcodeproj
│   ├── PrivatePodsDemo.xcworkspace
│   └── Tests
├── LICENSE
├── PrivatePodsDemo
│   ├── Assets
│   └── Classes
├── PrivatePodsDemo.podspec
├── README.md
└── _Pods.xcodeproj -> Example/Pods/Pods.xcodeproj
```

文件根目录主要需要关注的一共有三个文件，分别是 `PrivatePodsDemo` `PrivatePodsDemo` `PrivatePodsDemo.podspec`

##### PrivatePodsDemo

该文件夹下主要有两个文件夹

<u>**Assets**</u>:存放资源文件

**<u>Classes</u>**:存放代码文件

##### Example

该文件夹主要是用来调试代码的

##### PrivatePodsDemo.podspec

[doc](https://guides.cocoapods.org/syntax/podspec.html)

该文件是描述代码库的相关信息

```ruby
Pod::Spec.new do |s|
  s.name             = 'CarbadaNetworkingV2'
  s.version          = '1.0.0'
  s.summary          = 'A short description of CarbadaNetworkingV2.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
车巴达网络库基础组件，基于AFN 二次封装
                       DESC

  s.homepage         = 'http://git.17usoft.com/iOS_CocoapodsTest/CarbadaNetworkingV2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '杨植栋' => 'yangzhidong@chebada.com' }
  s.source           = { :git => 'http://git.17usoft.com/iOS_CocoapodsTest/CarbadaNetworkingV2.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0' # iOS 最低支持版本

s.xcconfig = {
    'VALID_ARCHS' =>  'arm64 armv7 x86_64',
    }
  s.source_files = 'CarbadaNetworkingV2/Classes/**/*' # 代码文件路径
  
  # s.resource_bundles = {
  #   'CarbadaNetworkingV2' => ['CarbadaNetworkingV2/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AFNetworking', '~> 3.0' # 依赖库
```

#### 0x03 代码库检查

上传源码并打上标签

```bash
pod lib lint 本地仓库校验 推荐使用这个命令
pod spec lint 远程仓库校验
# 可选参数
--allow-warnings 忽略warning
--verbose 啰嗦模式
--sources 代码库集合地址
--skip-import-validation lint 将跳过验证 pod 是否可以导入
```

#### 0x04 代码库上传

```bash
pod repo push [代码库集合名称] [当前代码库名称].podspec 
# 可选参数
--sources='git@git.17usoft.com:wireless-bus/iOS_CheBaDa_Specs_Source.git,https://cdn.cocoapods.org' 代码库集合地址
--allow-warnings 忽略warning
--verbose 啰嗦模式
--skip-import-validation push 将跳过验证 pod 是否可以导入
```

#### 0x05 二进制转换

##### **[ cocoapods-imy-bin](https://github.com/MeetYouDevs/cocoapods-imy-bin)**

###### 使用

创建二进制壳工程

```bash
1. pod lib create XXX
2. 复制 podspec 到 Example 中， 因为 imy-bin 要求 podspec 和 podfile 在同一个目录下
3. cd Example
```

安装 mongodb

```bash
# 进入 /usr/local
cd /usr/local
# 下载
sudo curl -O https://fastdl.mongodb.org/osx/mongodb-osx-ssl-x86_64-4.0.9.tgz
# 解压
sudo tar -zxvf mongodb-osx-ssl-x86_64-4.0.9.tgz
# 重命名为 mongodb 目录
sudo mv mongodb-osx-x86_64-4.0.9/ mongodb
# 创建数据库存储目录
这里自己选一个位置，然后 pwd 打出路径
# 启动 mongod
sudo mongod --dbpath 存储路径
```

安装 binaryServer

```bash
# 下载
git clone https://github.com/su350380433/binary-server.git
# 进入项目
cd binary-server-master
# 安装依赖库
npm install
启动 binaryServer
npm start
```

初始化 bin 环境

```bash
# 环境初始化
pod bin init
可选值：[ dev / debug_iphoneos / release_iphoneos ]
旧值：dev
源码私有源 Git 地址
旧值：git@git.17usoft.com:wireless-bus/iOS_CheBaDa_Specs_Source.git
二进制私有源 Git 地址
旧值：git@git.17usoft.com:wireless-bus/iOS_CheBaDa_Specs.git
二进制下载地址，内部会依次传入组件名称与版本，替换字符串中的 %s 
旧值：http://10.102.52.44:8099/frameworks/%s/%s/zip
下载二进制文件类型
可选值：[ zip / tgz / tar / tbz / txz / dmg ]
旧值：zip

# 二进制打包 这里需要提前准备好 mogondb 和 binaryServier
pod bin auto --all-make
```

###### 二进制切换

使用podfile，操作命令 `pod install`

```bash
plugin 'cocoapods-imy-bin'
use_binaries!
```

使用podfile_local，操作命令 `pod bin install`

```bash
#target 'Seeyou' do 不同的项目注意修改下Seeyou的值
#:path => '../IMYYQHome',根据实际情况自行修改，与之前在podfile写法一致


 plugin 'cocoapods-imy-bin'
#是否启用二进制插件，想开启把下面注释去掉
# use_binaries! 

#设置使用【源码】版本的组件。
#set_use_source_pods ['YYKit','SDWebImaage']

#需要替换Podfile里面的组件才写到这里
#在这里面的所写的组件库依赖，默认切换为【源码】依赖
target 'Seeyou' do
  #本地库引用
	#pod 'YYModel', :path => '../YYModel'

  #覆盖、自定义组件
  	#pod 'YYCache', :podspec => 'http://覆盖、自定义/'
end
```

###### 源码调试

```bash
pod bin code [需要调试的代码库名称]
# 可选参数
--all-clean   删除所有已经下载的源码
    --clean       删除所有指定下载的源码
    --list        展示所有一级下载的源码以及其大小
    --source      源码路径，本地路径,会去自动链接本地源码
```

#### 0x00 常见问题

* 不要跨组建分享宏定义

  ![bfac6d24-0a18-4a4f-8cb9-1ddb8e62d904](/Users/admin/Library/Containers/com.tencent.WeWorkMac/Data/Library/Application Support/WXWork/Data/1688850057180196/Cache/Image/2021-12/bfac6d24-0a18-4a4f-8cb9-1ddb8e62d904.png)

* error: include of non-modular header inside framework module

  在进行Framework化的过程中，一旦引用了某些Framework其使用者Project，就会报错

