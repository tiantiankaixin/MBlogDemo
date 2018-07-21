//
//  UnitTestTests.m
//  UnitTestTests
//
//  Created by mal on 2018/2/26.
//  Copyright © 2018年 mal. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface UnitTestTests : XCTestCase

@end

@implementation UnitTestTests

- (void)testOnePlusOne {
    //Given
    NSInteger a = 1;
    NSInteger b = 1;
    //When
    NSInteger result = a + b;
    //then
    XCTAssertTrue(result == 2);
}

- (void)testAsyncFunction
{
    XCTestExpectation *exp = [self expectationWithDescription:@"异步操作出错"];
    
    //Given
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        //When
        sleep(2);
        //Then
        XCTAssertEqual(@"a", @"a");
        //如果断言没问题，就调用fulfill宣布测试完成
        [exp fulfill];
    }];
    
    //设置延迟三秒后，如果还没调用fulfill,则报错
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
         sleep(2);
    }];
}

@end
