# 这里主要是在项目开发过程中需要用到的sql语句，首先在sql软件测试一下

SELECT `id`,`username`,`password`,`email` FROM `member` 
WHERE `username`='admin';

-- 插入数据语句
-- id是自增长的
INSERT INTO member (`username`,`password`,`email`)
VALUES('milan123',MD5('milan'),'milan123@qq.com');

# 用过用户名和密码查询用户（用户登录界面）
SELECT * FROM `member` WHERE `username`='king' AND `password`=MD5('king');

# 查询furn表中的所有信息
SELECT `id` , `name` , `maker` , `price` , `sales` , `stock` , `img_path` AS imgPath 
FROM `furn`;

# 在furn表中插入数据
INSERT INTO furn(`id` , `name` , `maker` , `price` , `sales` , `stock` , `img_path`) 
VALUES(NULL , '温馨风格盆景架' , '蚂蚁家居' , 180 , 666 , 7 , 'assets/images/product-image/16.jpg');

# 根据id删除furn表中对应记录
DELETE FROM `furn` WHERE `id`=20;

# 根据id查询furn表中对应记录
SELECT `id` , `name` , `maker` , `price` , `sales` , `stock` , `img_path` AS imgPath 
FROM `furn` WHERE id=30;

# 修改furn表对应记录的字段值
UPDATE `furn`
SET `name`='jack', `maker`='juju',`price`=999,`sales`=100,`stock`=888,`img_path`='ksksksk'
WHERE `id`=39;

# 查找表的总记录数
SELECT COUNT(*) FROM `furn`;

# 根据分页查找对应记录
# SELECT * FROM emp 
# LIMIT 每页显示记录数*（第几页-1）,每页显示记录数
SELECT `id` , `name` , `maker` , `price` , `sales` , `stock` , `img_path` AS imgPath
FROM `furn`
LIMIT 0,5;

# 根据name搜索furn表对应的记录(使用模糊查询)
# 在上面的基础上进行分页
SELECT  `id` , `name` , `maker` , `price` , `sales` , `stock` , `img_path` AS imgPath
FROM `furn`
WHERE `name` LIKE '%桌子%'
LIMIT 0,5;

# 模糊查询返回数量
SELECT  COUNT(*)
FROM `furn`
WHERE `name` LIKE '%桌子%';

# 将数据插入order表
INSERT INTO `order`(`id`,`create_time`,`price`,`status`,`member_id`) 
VALUES( 'sn000001' , NOW() , 100 , 0 , 2 );

# 将数据插入order_item表
INSERT INTO `order_item`(`id`,`name`,`price`,`count`,`total_price`,`order_id`) 
VALUES(NULL,'深蓝沙发',999,2,1998,'sn000001');

# 根据用户id查询该用户的所有订单order
SELECT `id`,`create_time` AS createTime,`price`,`status`,`member_id` AS memberId 
FROM `order` 
WHERE `member_id`=2;

# 根据订单id查询对应的订单项orderItem
SELECT `id`,`name`,`price`,`count`,`total_price` AS totalPrice,`order_id` AS orderId 
FROM `order_item` 
WHERE `order_id`='16722358644142'