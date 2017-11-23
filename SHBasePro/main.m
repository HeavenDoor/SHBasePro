//
//  main.m
//  camera
//
//  Created by shenghai on 16/5/6.
//  Copyright © 2016年 ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool
    {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

// From here to end of file added by Injection Plugin //

#ifdef DEBUG
#define INJECTION_PORT 31444 // AppCode
static char _inMainFilePath[] = __FILE__;
static const char *_inIPAddresses[] = {"192.168.20.123", 0};

#define INJECTION_ENABLED
#import "/Users/shenghai/Library/Application Support/Developer/Shared/Xcode/Plug-ins/InjectionPlugin.xcplugin/Contents/Resources//BundleInjection.h"
#endif
