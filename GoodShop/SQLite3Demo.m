//
//  SQLite3Demo.m
//  GoodShop
//
//  Created by mike on 6/23/16.
//  Copyright © 2016 mike. All rights reserved.
//

#import "SQLite3Demo.h"
#import "NSString+MikePath.h"

//not null - 非空
//unique - 唯一
//primary key - 主键
//foreign key - 外键
//check - 条件检查，确保一列中的所有值满足一定条件
//default - 默认
//autoincreatement - 自增型变量
//创建数据库命令——create database
//修改数据库命令——alter database
//创建新表的命令——create table
//变更数据库中的表——alter table
//删除表——drop table
//创建索引——create index
//删除索引——drop index
//一般情况下只有一个数据库,我们可以在数据库中创建多张表来保存不同的信息,但是千万不要创建多个数据库,每个数据库中只有一张表,因为不断的连接,关闭数据库是很耗性能的

static NSString * const sqlp = @"mike.sqlite";
static NSString * const createSutdentTable = @"CREATE TABLE IF NOT EXISTS SutdentName (stuId TEXT PRIMARY KEY, name TEXT);";

@interface SQLite3Demo ()



@end

@implementation SQLite3Demo


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //database file path
    NSString *filePath = [[NSString documentsPath] stringByAppendingString:sqlp];
    
    //create
//    sqlite3_open([filePath UTF8String], &db);

    if (sqlite3_open([filePath UTF8String], &db) != SQLITE_OK ) {
        sqlite3_close(db);
        NSAssert(NO, @"数据库打开失败！");
    }else{
        //success
        
        //dosomething！
        
        char *err;
       //创建表 第三个是毁掉函数，第四个是毁掉函数传递的参数
        if ( sqlite3_exec(db, [createSutdentTable UTF8String], NULL, NULL, &err) != SQLITE_OK){
            
            sqlite3_close(db);
            NSAssert(NO, @"表创建失败！");
        }else{
            //success
        };
        
        
       sqlite3_close(db);
    }
    
    
}

//查询

- (void)check{
    NSString *filePath = [[NSString documentsPath] stringByAppendingString:sqlp];
    if (sqlite3_open([filePath UTF8String], &db) != SQLITE_OK ) {
        sqlite3_close(db);
        NSAssert(NO, @"数据库打开失败！");
    }else{

        NSString *qsql = @"SELECT stuId,name FROM SutdentName Where stuId = ?;";
        
        sqlite3_stmt *statement;//语句对象
        
        //预处理
        /**
         1:database
         2:sql 
         3:sql语句执行长度
         4:语句对象
         5:sql语句没有执行的部分
         */
        ;
        if (sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, NULL) != SQLITE_OK ) {
        //error
            sqlite3_close(db);
           
        
        }else{
            //进行查询
            NSString *stuID = @"123";
            
            //绑定
            /**
             1:语句对象
             2:参数开始执行序号
             3:需要绑定的值
             4:绑定的字符串长度
             5:块
             */
            
            //填入查询参数 stuID
            sqlite3_bind_text(statement, 1, [stuID UTF8String], -1, NULL);
            
            
            //遍历
            if (sqlite3_step(statement) == SQLITE_ROW) {
                //查出来了
                
                //提取数据
                //第二个是字段索引，
                char *ids = (char *)sqlite3_column_text(statement, 0);
                NSString *idNumStr = [[NSString alloc] initWithUTF8String:ids];
                char *oneName = (char *)sqlite3_column_text(statement, 1);
                NSString *idNumOfName = [[NSString alloc] initWithUTF8String:oneName];
                
                NSLog(@"%@,%@", idNumStr, idNumOfName);
                sqlite3_finalize(statement);
                sqlite3_close(db);
            };
            
            sqlite3_finalize(statement);
            sqlite3_close(db);
        }
        
        sqlite3_close(db);
    
    }
    
    
    
    
    
    
}

- (void)insert{
    
    //待插入的东西
    NSString *ids = @"123";
    NSString *name = @"abc";
    
     NSString *filePath = [[NSString documentsPath] stringByAppendingString:sqlp];
    if (sqlite3_open([filePath UTF8String], &db) != SQLITE_OK ) {
        sqlite3_close(db);
        NSAssert(NO, @"数据库打开失败！");
    }else{
        NSString *sql = @"INSERT OR REPLACE INTO SutdentName (stuId, name) VALUES (?, ?);";
         sqlite3_stmt *statement;//语句对象
        
        if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, NULL) != SQLITE_OK ) {
            //绑定操作
            sqlite3_bind_text(statement, 1, [ids UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 2, [name UTF8String], -1, NULL);
            
            if(sqlite3_step(statement) != SQLITE_DONE){
                NSAssert(NO, @"插入数据失败");
                sqlite3_finalize(statement);
                sqlite3_close(db);
            }else{
                sqlite3_finalize(statement);
                sqlite3_close(db);
            }
            
        }
    }
}



- (void)update{
    
    //待插入的东西
    NSString *ids = @"123";
    NSString *name = @"QQQ";

     // 更新指定ID下的姓名和性别
    NSString *filePath = [[NSString documentsPath] stringByAppendingString:sqlp];
    if (sqlite3_open([filePath UTF8String], &db) != SQLITE_OK ) {
        sqlite3_close(db);
        NSAssert(NO, @"数据库打开失败！");
    }else{
        
//        "update Student set name = ?, gender = ? where ID = ?"

        NSString *sql = @"UPDATE  SutdentName (stuId, name) set name= ? where stuId = ?;";
        sqlite3_stmt *statement;//语句对象
         if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, NULL) == SQLITE_OK ) {
             
             sqlite3_bind_text(statement, 1, [ids UTF8String], -1, NULL);
             sqlite3_bind_text(statement, 2, [name UTF8String], -1, NULL);
               sqlite3_step(statement);
         }
        
        sqlite3_finalize(statement);
        sqlite3_close(db);
        
    }
}

- (void)deleteStudentByID:(NSString *)ID {
    
    // 打开数据库
    
    NSString *filePath = [[NSString documentsPath] stringByAppendingString:sqlp];
    if (sqlite3_open([filePath UTF8String], &db) != SQLITE_OK ) {
        sqlite3_close(db);
        NSAssert(NO, @"数据库打开失败！");
    }else{

    
        sqlite3_stmt *statement;//语句对象
        NSString *sql = @"delete from SutdentName where ID = ?;";
        int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, NULL);
        if (result == SQLITE_OK) {
            
            sqlite3_bind_text(statement, 1, [ID UTF8String], -1, NULL);
            sqlite3_step(statement);
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    
  }
}


@end
