#!/usr/bin/env bash

# e.g.
#
# 发布 1.1.0正式版 (android coolapk 渠道，iOS 自动上传到 appstore)
# ./deploy_app.sh -v 1.1.0 -f coolapk -e prod
#
# 发布 1.1.0测试版 「自动上传到 pgyer」
# ./deploy_app.sh -v 1.1.0 -f coolapk -e test

export FASTLANE_ITUNES_TRANSPORTER_USE_SHELL_SCRIPT=1 
export FASTLANE_ITUNES_TRANSPORTER_PATH=/Applications/Transporter.app/Contents/itms 
export APP_STORE_CONNECT_API_KEY_PATH=~/.appstoreconnect/private_keys/AuthKey_KJY6D58SF3.p8

API_KEY=KJY6D58SF3
API_USER_ID=32c4fdad-058b-4320-ac99-cf69fce85a8b
APP_FILE=eye_sport_guard.ipa

# getopts

while getopts v:e:p: opt
do
    case $opt in
        v) version=${OPTARG} ;; # 软件版本
        e) env=${OPTARG} ;;     # 环境（test 「pgyer」, prod「appstore」）
        p) plat=${OPTARG} ;;    # 平台（all, ios, android）
    esac
done

version=${version:-"1.0.0"}
env=${env:-"prod"}
plat=${plat:-"ios"}
# 编译版本号
time=$(date "+%y%m%d%H%M")

echo "开始打包： v${version} build(${time})，plat: ${plat}，env: ${env}"

### 打包 iOS 客户端
if [ "$plat"x = "ios"x ] || [ "$plat"x = "all"x ]; then
  # 打包iOS
  flutter clean
  flutter build ipa --obfuscate --split-debug-info=./build_info --build-name=$version --build-number=$time --no-tree-shake-icons
  xcrun altool --upload-app --type ios -f 'build/ios/ipa/'$APP_FILE --apiKey $API_KEY --apiIssuer $API_USER_ID --verbose
fi