-- 创建项目需要的数据库和表
-- 创建数据库furns
CREATE DATABASE furns;
USE furns;

###
-- 创建用户表member
CREATE TABLE `member`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`username` VARCHAR(32) NOT NULL UNIQUE,
`password` VARCHAR(32) NOT NULL,
`email` VARCHAR(64)
)CHARSET utf8 ENGINE INNODB;

-- 插入测试数据
INSERT INTO member (`username`,`password`,`email`)
VALUES('admin',MD5('admin'),'li@qq.com');

SELECT * FROM member;

###
-- 创建admin表
CREATE TABLE `admin`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`username` VARCHAR(32) NOT NULL UNIQUE,
`password` VARCHAR(32) NOT NULL,
`email` VARCHAR(64) 
)CHARSET utf8 ENGINE INNODB;

-- 插入测试数据
INSERT INTO admin (`username`,`password`,`email`)
VALUES('admin',MD5('admin'),'admin@qq.com');

SELECT * FROM admin;

### 
-- 设计家居表furn
-- 根据 需求-文档-界面
-- 有时会看到id int(11), 11为显示的宽度，配合零填充zerofill
-- 		int(2), 2表示的也是显示宽度
-- 也就是说, int(11)和int(2)存储的范围是一样的,两者存放的数据范围和int相关
-- 例如，67890使用int(11)来存储，显示为 00000067890
-- 	 67890使用int(2)来存储，显示为 67890
-- 也就是说当存储的数据位数不够时，使用0来填充剩下的宽度
CREATE TABLE `furn`(
`id` INT UNSIGNED PRIMARY KEY AUTO_INCREMENT, #id-设计为无符号
`name` VARCHAR(64) NOT NULL, #家居名
`maker` VARCHAR(64) NOT NULL, #制造商
`price` DECIMAL(11,2) NOT NULL, #价格 建议用DECIMAL定点数
`sales` INT UNSIGNED NOT NULL, #销量
`stock` INT UNSIGNED NOT NULL, #库存
`img_path` VARCHAR(256) NOT NULL #存放图片的路径即可，不建议存放图片到数据库中
)CHARSET utf8 ENGINE INNODB;

-- 增加测试数据
INSERT INTO furn(`id` , `name` , `maker` , `price` , `sales` , `stock` , `img_path`) 
VALUES(NULL , '北欧风格小桌子' , '熊猫家居' , 180 , 666 , 7 , 'assets/images/product-image/6.jpg');
 
INSERT INTO furn(`id` , `name` , `maker` , `price` , `sales` , `stock` , `img_path`) 
VALUES(NULL , '简约风格小椅子' , '熊猫家居' , 180 , 666 , 7 , 'assets/images/product-image/4.jpg');
 
INSERT INTO furn(`id` , `name` , `maker` , `price` , `sales` , `stock` , `img_path`) 
VALUES(NULL , '典雅风格小台灯' , '蚂蚁家居' , 180 , 666 , 7 , 'assets/images/product-image/14.jpg');
 
INSERT INTO furn(`id` , `name` , `maker` , `price` , `sales` , `stock` , `img_path`) 
VALUES(NULL , '温馨风格盆景架' , '蚂蚁家居' , 180 , 666 , 7 , 'assets/images/product-image/16.jpg');

SELECT * FROM `furn`;

###
-- 设计 订单表order
-- 字段参考前端给的界面
-- mysql每个字段应尽量使用not null约束
-- 字段类型的设计应当和关联的表的字段保持一致
-- 外键是否要给? 
-- 因为外键对效率有影响，应当从程序的业务保证数据的一致性，而不是db层保证
CREATE TABLE `order`(
`id` VARCHAR(64) PRIMARY KEY, #订单号，主键
`create_time` DATETIME NOT NULL, #订单生成时间
`price` DECIMAL(11,2) NOT NULL, #订单的总金额，类型应该和furn表的price类型对应
`status` TINYINT NOT NULL, #订单状态 0-未发货 1-已发货 2-已结账
`member_id` INT NOT NULL  #从属的会员id -不需要外键约束
)CHARSET utf8 ENGINE INNODB;

-- 插入数据
INSERT INTO `order`(`id`,`create_time`,`price`,`status`,`member_id`) 
VALUES( 'sn000001' , NOW() , 100 , 0 , 2 );

SELECT * FROM `order`;

###
-- 设计 订单项表order_item
CREATE TABLE `order_item`(
`id` INT PRIMARY KEY AUTO_INCREMENT, #订单项id,自增长
`name` VARCHAR(64) NOT NULL, #家居名
`price` DECIMAL(11,2) NOT NULL, #家居单价
`count` INT NOT NULL, #某项的家居数量
`total_price` DECIMAL(11,2) NOT NULL, #订单项 的总价
`order_id` VARCHAR(64) NOT NULL #从属的订单号
)CHARSET utf8 ENGINE INNODB;

-- 插入测试数据
INSERT INTO `order_item`(`id`,`name`,`price`,`count`,`total_price`,`order_id`) 
VALUES(NULL,'深蓝沙发',999,2,1998,'sn000001');

SELECT * FROM `order_item`;