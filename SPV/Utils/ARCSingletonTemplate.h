//
//  ARCSingletonTemplate.h
//  Hejiajinrong+
//
//  Created by HeJia on 16/5/3.
//  Copyright © 2016年 HeJia. All rights reserved.
//

#ifndef ARCSingletonTemplate_h
#define ARCSingletonTemplate_h

#define SYNTHESIZE_SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define SYNTHESIZE_SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

#endif /* ARCSingletonTemplate_h */
