//
//  TUIChatBotPluginDataProvider.m
//  TUIChatBotPlugin
//
//  Created by lynx on 2023/10/30.
//

#import "TUIChatBotPluginDataProvider.h"
#import <TUICore/TUICore.h>
#import <TUICore/TUIDefine.h>
#import <ImSDK_Plus/ImSDK_Plus.h>

@implementation TUIChatBotPluginDataProvider

+ (void)sendTextMessage:(NSString *)text {
    V2TIMMessage *message = [[V2TIMManager sharedInstance] createTextMessage:text];
    if (message == nil) {
        return;
    }
    NSDictionary *param = @{TUICore_TUIChatService_SendMessageMethod_MsgKey: message};
    [TUICore callService:TUICore_TUIChatService
                  method:TUICore_TUIChatService_SendMessageMethod
                   param:param];
}

+ (void)sendCustomMessage:(NSData *)data {
    V2TIMMessage *message = [[V2TIMManager sharedInstance] createCustomMessage:data];
    if (message == nil) {
        return;
    }
    NSDictionary *param = @{TUICore_TUIChatService_SendMessageMethod_MsgKey: message};
    [TUICore callService:TUICore_TUIChatService
                  method:TUICore_TUIChatService_SendMessageMethod
                   param:param];
}

+ (void)sendCustomMessageWithoutUpdateUI:(NSData *)data {
    V2TIMMessage *message = [[V2TIMManager sharedInstance] createCustomMessage:data];
    if (message == nil) {
        return;
    }
    NSDictionary *param = @{TUICore_TUIChatService_SendMessageMethodWithoutUpdateUI_MsgKey: message};
    [TUICore callService:TUICore_TUIChatService
                  method:TUICore_TUIChatService_SendMessageMethodWithoutUpdateUI
                   param:param];
}

@end
