# VVDocumenter(更改版)

解决老项目数模转换格式问题

旧：
` ``- (instancetype)initWithDict:(NSDictionary *)dict{
if(self = [super init]){
self.aid=[dict objectForKey:@"id"];
self.type=[dict objectForKey:@"type"];
self.privilege=[dict objectForKey:@"privilege"];

}
return self;
}` ``

新（yymodel样式）
` ``
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
return @{@"aid" : @"id",
@"type" : @"type",
@"privilege" : @"privilege",
};
}
` ``
用法和VVDocumenter类似，扩展了mmm的操作

# Goodbye World
