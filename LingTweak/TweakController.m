//
//  TweakController.m
//  LingTweak
//
//  Created by John on 1/4/13.
//  Copyright (c) 2013 ling. All rights reserved.
//

#import "TweakController.h"

@implementation TweakController



- (NSString *)runCommand:(NSString *)commandToRun
{
    NSTask *task;
    task = [[NSTask alloc] init];
    [task setLaunchPath: @"/bin/sh"];
    
    NSArray *arguments = [NSArray arrayWithObjects:
                          @"-c" ,
                          [NSString stringWithFormat:@"%@", commandToRun],
                          nil];
    NSLog(@"run command: %@",commandToRun);
    [task setArguments: arguments];
    
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
    
    [task launch];
    
    NSData *data;
    data = [file readDataToEndOfFile];
    
    NSString *output;
    output = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
    return output;
}


- (void)openUrl:(NSString *)webUrl
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:webUrl]];
}


- (IBAction)showHiddenFiles:(id)sender
{
    [self runCommand:@"defaults write com.apple.finder AppleShowAllFiles -bool true"];
    [self runCommand:@"killAll Finder"];
}

- (IBAction)HideHiddenFiles:(id)sender
{
    [self runCommand:@"defaults write com.apple.finder AppleShowAllFiles -bool false"];
    [self runCommand:@"killAll Finder"];
}


- (IBAction)checkForUpdate:(id)sender
{
    [self openUrl:@"http://www.lingsky.com"];
}


@end
