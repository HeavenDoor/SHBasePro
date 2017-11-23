/*******************************************************************************
 # File        : BinaryTreeNode.h
 # Project     : SHBasePro
 # Author      : shenghai
 # Created     : 2017/11/23
 # Corporation : 成都好房通科技股份有限公司
 # Description :
 Description Logs
 -------------------------------------------------------------------------------
 # Date        : Change Date
 # Author      : Change Author
 # Notes       :
 Change Logs
 ******************************************************************************/

#import <Foundation/Foundation.h>

@interface BinaryTreeNode : NSObject

@property (nonatomic, assign) NSInteger nodeValue;

@property (nonatomic, strong) BinaryTreeNode *leftNode;

@property (nonatomic, strong) BinaryTreeNode *rightNode;

@end
