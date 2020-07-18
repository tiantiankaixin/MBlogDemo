#!/usr/bin/env python
# -*- coding:utf-8 -*-
# archive.py

import sys, os, requests
from pbxproj import XcodeProject
from git import Repo
from biplist import *

#常用配置项
kTargetName = "ArtAIClassSwiftTest"
kProjectName = "ArtAIClassSwift"
PLISTFILE = "archive.plist"
kCerTeam = "83G2F8FWQZ"

#工程路径
kProjectPath = "../%s/" % (kProjectName)
kProjectFilePath = kProjectPath + "ArtAIClassSwift.xcodeproj/project.pbxproj"
kPlistFilePath = kProjectPath + "ArtAIClassSwift/main/%s.plist" % (kTargetName)
kScriptPath = "../script/"
kConfiguePlist = kScriptPath + "configue.plist"

#蒲公英
kPgyAPIKey = "cf1b488fdf3b67f6b5a0a492988f1544"
kPgyUserKey = "4714e1e1227ff81221aecac0132780a0"


def _start():
    _modifyProject()
    # _archivePre()
    # _arcive()
    # _uploadIPAToPgy()
    # _clear()

def _archivePre():
    #切换至工程目录
    os.chdir(kProjectPath)
    print ("当前目录是%s" % (os.getcwd()))

    # 读取configue.plist
    print("开始读取配置文件")
    configuePlist = readPlist(kConfiguePlist)
    cAppVersion = configuePlist["appVersion"]
    cBuildVersion = configuePlist["buildVersion"]
    cBranch = configuePlist["branch"]
    cTarget = configuePlist["target"]
    print("git-branch: %s\n appVersion: %s\n buildVersion: %s\n target: %s" % (cBranch, cAppVersion, cBuildVersion, cTarget))

    #info.plist edit
    print("开始修改info.plist")
    print("plist文件的路径是%s" % (kPlistFilePath))
    infoPlist = readPlist(kPlistFilePath)
    infoPlist["CFBundleVersion"] = cBuildVersion
    infoPlist["CFBundleShortVersionString"] = cAppVersion
    editInfoPlistResult = writePlist(infoPlist, kPlistFilePath)
    if editInfoPlistResult:
        print(editInfoPlistResult)

    #git
    print (".......开始执行git命令.......\n")
    repo = Repo(kProjectPath)
    repo.git.checkout(cBranch)
    repo.git.pull()
    commit_log = repo.git.log('--pretty={"commit":"%h","author":"%an","summary":"%s","date":"%cd"}',
                                   max_count = 3,
                                   date='format:%Y-%m-%d %H:%M')
    print (commit_log)

    #pod
    print (".......开始执行pod命令.......\n")
    podCommand = "pod install"
    _systemCommand(podCommand)

def _modifyProject():
    project = XcodeProject.load(kProjectFilePath)
    target = project.get_target_by_name(kTargetName)
    print(target)
    configuelist = target["buildConfigurationList"]
    print(configuelist)
    buildlists = project["objects"][configuelist]["buildConfigurations"]
    for key in buildlists:
        if project["objects"][key]["buildSettings"]:
            buildSettingsArr = project["objects"][key]["buildSettings"]
            # buildSettingsArr['CODE_SIGN_STYLE'] = "Automatic"
            print(buildSettingsArr)
    # project.save()

def _arcive():
    print(kTargetName)
    os.chdir(kScriptPath)
    print ("当前目录是%s" % (os.getcwd()))

    _removeBuildFiles()

    command = "xcodebuild clean -project ../%s/%s.xcodeproj -target %s -sdk iphoneos -configuration Release" % (
    kProjectName, kProjectName, kTargetName)
    _systemCommand(command)

    command = "xcodebuild -workspace %s%s.xcworkspace archive -scheme %s -configuration Release -archivePath ../build/%s.xcarchive" % (
    kProjectPath, kProjectName, kTargetName, kTargetName)
    _systemCommand(command)

    command = "xcodebuild -exportArchive -archivePath ../build/%s.xcarchive -exportOptionsPlist %s -exportPath %s" % (
    kTargetName, PLISTFILE, kTargetName)
    _systemCommand(command)

def _removeBuildFiles():
    command = "rm -rf ../build"
    _systemCommand(command)

def _uploadIPAToPgy():
    currentPath = os.getcwd()
    IPAPath = "%s/%s/%s.ipa" % (currentPath, kTargetName, kTargetName)
    print("\n***********************************IPA包开始上传到蒲公英**************************\n")
    url = 'https://www.pgyer.com/apiv2/app/upload'

    data = {
        '_api_key': kPgyAPIKey,
        'buildInstallType': '2',
        'buildPassword': 'msbnb',
        'buildUpdateDescription': '更新说明'
    }
    files = {'file': open(IPAPath, 'rb')}
    r = requests.post(url, data=data, files=files)
    print(r)

def _clear():
    print("开始清理工作")
    _removeBuildFiles()


def _systemCommand(command):
    if os.system(command) != 0:
        print('Error: ' + command)
        sys.exit(0)

def main():
    argvs = len(sys.argv)
    if argvs == 1:
        _start()
    

    return 0

if __name__ == '__main__':
    sys.exit(main())



