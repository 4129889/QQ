DROP SCHEMA IF EXISTS `NewView`;
CREATE SCHEMA `NewView` ;
use `NewView`;

-- DROP TABLE IF EXISTS user;
-- DROP TABLE IF EXISTS publisher;
-- DROP TABLE IF EXISTS administrator;
-- DROP TABLE IF EXISTS discount;
-- DROP TABLE IF EXISTS useDiscount;
-- DROP TABLE IF EXISTS postCategory;
-- DROP TABLE IF EXISTS post;
-- DROP TABLE IF EXISTS likes;
-- DROP TABLE IF EXISTS report;
-- DROP TABLE IF EXISTS postMessage;
-- DROP TABLE IF EXISTS postPic;
-- DROP TABLE IF EXISTS actCategory;
-- DROP TABLE IF EXISTS city;
-- DROP TABLE IF EXISTS act;
-- DROP TABLE IF EXISTS actPic;
-- DROP TABLE IF EXISTS orders;
-- DROP TABLE IF EXISTS myLike;
-- DROP TABLE IF EXISTS cartAct;
-- DROP TABLE IF EXISTS orderList;
-- DROP TABLE IF EXISTS comPic;
-- DROP TABLE IF EXISTS pubUser;


-- 顧客資料 
CREATE TABLE `user` (
  `userID` INT NOT NULL AUTO_INCREMENT,
  `userName` VARCHAR(10) NOT NULL,
  `userAccount` VARCHAR(10) NOT NULL,
  `userPassword` VARCHAR(255) NOT NULL,
  `userBirth` DATE NOT NULL,
  `userCell` VARCHAR(10) NOT NULL,
  `userEmail` VARCHAR(50) NOT NULL,
  `userNickname` VARCHAR(10) NULL,
  `buyAuthority` TINYINT DEFAULT '0',
  `speakAuthority` TINYINT DEFAULT '0',
  PRIMARY KEY (`userID`));
  
  -- 廠商資料
CREATE TABLE `publisher` (
	`pubID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `pubName` VARCHAR(10) NOT NULL,
    `pubEmail` VARCHAR(50) NOT NULL
);

-- 管理者資料
CREATE TABLE `administrator` (
	`adminID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `adminName` VARCHAR(10) NOT NULL,
    `adminAccount` VARCHAR(10) NOT NULL,
    `adminPassword` VARCHAR(255) NOT NULL,
    `adminEmail` VARCHAR(50) NOT NULL
);

-- 優惠活動
CREATE TABLE `discount` (
  `discountNO` int NOT NULL AUTO_INCREMENT,
  `pubID` int DEFAULT NULL,
  `adminID` int DEFAULT NULL,
  `discountContent` varchar(50) NOT NULL,
  `disAmount` int NOT NULL,
  `discountCode` varchar(10) NOT NULL,
  `disStartDate` datetime NOT NULL,
  `disFinishDate` datetime NOT NULL,
  PRIMARY KEY (`discountNO`),
  KEY `FK_discount_adminID` (`adminID`),
  KEY `FK_discount_pubID` (`pubID`),
  CONSTRAINT `FK_discount_adminID` FOREIGN KEY (`adminID`) REFERENCES `administrator` (`adminID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_discount_pubID` FOREIGN KEY (`pubID`) REFERENCES `publisher` (`pubID`) ON DELETE CASCADE ON UPDATE CASCADE
);


-- 用戶優惠
CREATE TABLE `usediscount` (
  `useDisID` int NOT NULL AUTO_INCREMENT,
  `discountNO` int DEFAULT NULL,
  `userID` int DEFAULT NULL,
  `ditUsed` tinyint DEFAULT '0',
  PRIMARY KEY (`useDisID`),
  KEY `FK_useDiscount_discountNO` (`discountNO`),
  KEY `FK_useDiscount_userID` (`userID`),
  CONSTRAINT `FK_useDiscount_discountNO` FOREIGN KEY (`discountNO`) REFERENCES `discount` (`discountNO`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_useDiscount_userID` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
);


-- 文章分類
  CREATE TABLE `postCategory` (
  `postCategoryID` INT NOT NULL AUTO_INCREMENT,
  `postCategoryName` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`postCategoryID`));

-- 文章
CREATE TABLE `post` (
  `postID` int NOT NULL AUTO_INCREMENT,
  `userID` int NOT NULL,
  `postCategoryID` int NOT NULL,
  `postHeader` varchar(45) NOT NULL,
  `postDateTime` datetime DEFAULT CURRENT_TIMESTAMP,
  `lastEditedTime` datetime DEFAULT CURRENT_TIMESTAMP,
  `postContent` varchar(10000) NOT NULL,
  `dislikeCount` int DEFAULT NULL,
  `likeCount` int DEFAULT NULL,
  `postStatus` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`postID`),
  KEY `FK_post_postCategoryID` (`postCategoryID`),
  KEY `FK_post_userID` (`userID`),
  CONSTRAINT `FK_post_postCategoryID` FOREIGN KEY (`postCategoryID`) REFERENCES `postcategory` (`postCategoryID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_post_userID` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
);


-- 用戶按讚
CREATE TABLE `likes` (
  `likeID` int NOT NULL AUTO_INCREMENT,
  `postID` int NOT NULL,
  `userID` int ,
  `likeOrNot` tinyint DEFAULT NULL,
  `visitorID` int,
  PRIMARY KEY (`likeID`),
  KEY `FK_likes_postID` (`postID`),
  KEY `FK_likes_userID` (`userID`),
  CONSTRAINT `FK_likes_postID` FOREIGN KEY (`postID`) REFERENCES `post` (`postID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_likes_userID` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
);


-- 文章檢舉
CREATE TABLE `report` (
  `reportID` int NOT NULL AUTO_INCREMENT,
  `userID` int NOT NULL,
  `postID` int NOT NULL,
  `reportContent` varchar(50) NOT NULL,
  `reportStatus` tinyint NOT NULL,
  PRIMARY KEY (`reportID`),
  KEY `FK_report_postID` (`postID`),
  KEY `FK_report_userID` (`userID`),
  CONSTRAINT `FK_report_postID` FOREIGN KEY (`postID`) REFERENCES `post` (`postID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_report_userID` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
);

 -- 文章留言 
CREATE TABLE `postmessage` (
  `postMessageID` int NOT NULL AUTO_INCREMENT,
  `postID` int NOT NULL,
  `userID` int NOT NULL,
  `mesContent` varchar(1000) NOT NULL,
  `messageDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`postMessageID`),
  KEY `FK_postMessage_postID` (`postID`),
  KEY `FK_postMessage_userID` (`userID`),
  CONSTRAINT `FK_postMessage_postID` FOREIGN KEY (`postID`) REFERENCES `post` (`postID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_postMessage_userID` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
);

  
-- 文章圖片
CREATE TABLE `postpic` (
  `postPicID` int NOT NULL AUTO_INCREMENT,
  `postID` int NOT NULL,
  `postPic` longblob,
  PRIMARY KEY (`postPicID`),
  KEY `FK_postPic_postID` (`postID`),
  CONSTRAINT `FK_postPic_postID` FOREIGN KEY (`postID`) REFERENCES `post` (`postID`) ON DELETE CASCADE ON UPDATE CASCADE
);


 -- 活動分類
CREATE TABLE `actCategory` (
`actCategoryID` INT NOT NULL AUTO_INCREMENT,
`actCategoryName` VARCHAR(50) NOT NULL,
 PRIMARY KEY (`actCategoryID`));
 
-- 縣市資料
CREATE TABLE `city` (
`cityAddressID` INT NOT NULL,
`cityName` VARCHAR(1000) NOT NULL,
PRIMARY KEY (`cityAddressID`));

-- 活動資料
CREATE TABLE `act` (
  `actID` int NOT NULL AUTO_INCREMENT,
  `actName` varchar(20) NOT NULL,
  `actPrice` int NOT NULL,
  `actCategoryID` int NOT NULL,
  `pubID` int NOT NULL,
  `actTime` date NOT NULL,
  `cityAddressID` int NOT NULL,
  `actScope` int NOT NULL,
  `actIntroduce` varchar(255) NOT NULL,
  `actContent` text NOT NULL,
  `time` time NOT NULL,
  `actDate` date NOT NULL,
  `approvalCondition` tinyint NOT NULL,
  `cityAddress` varchar(100) NOT NULL,
  PRIMARY KEY (`actID`),
  KEY `FK_act_actCategoryID` (`actCategoryID`),
  KEY `FK_act_cityAddressID` (`cityAddressID`),
  KEY `FK_act_pubID` (`pubID`),
  CONSTRAINT `FK_act_actCategoryID` FOREIGN KEY (`actCategoryID`) REFERENCES `actcategory` (`actCategoryID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_act_cityAddressID` FOREIGN KEY (`cityAddressID`) REFERENCES `city` (`cityAddressID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_act_pubID` FOREIGN KEY (`pubID`) REFERENCES `publisher` (`pubID`) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 活動圖片
CREATE TABLE `actpic` (
  `actPicID` int NOT NULL AUTO_INCREMENT,
  `actID` int NOT NULL,
  `actPic` longblob,
  PRIMARY KEY (`actPicID`),
  KEY `FK_actPic_actID` (`actID`),
  CONSTRAINT `FK_actPic_actID` FOREIGN KEY (`actID`) REFERENCES `act` (`actID`) ON DELETE CASCADE ON UPDATE CASCADE
);


-- 訂單
CREATE TABLE `orders` (
  `orderID` int NOT NULL AUTO_INCREMENT,
  `userID` int NOT NULL,
  `ordTotal` int NOT NULL,
  `discount` int DEFAULT NULL,
  `discountPrice` int DEFAULT NULL,
  `ordTime` datetime DEFAULT CURRENT_TIMESTAMP,
  `pubID` int NOT NULL,
  `ordType` tinyint NOT NULL DEFAULT '0',
  `actQuantity` int NOT NULL,
  `discountNO` int DEFAULT NULL,
  PRIMARY KEY (`orderID`),
  KEY `FK_orders_discountNO` (`discountNO`),
  KEY `FK_orders_pubID` (`pubID`),
  KEY `FK_orders_userID` (`userID`),
  CONSTRAINT `FK_orders_discountNO` FOREIGN KEY (`discountNO`) REFERENCES `discount` (`discountNO`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_orders_pubID` FOREIGN KEY (`pubID`) REFERENCES `publisher` (`pubID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_orders_userID` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
);


-- 我的最愛
CREATE TABLE `mylike` (
  `myLikeID` int NOT NULL AUTO_INCREMENT,
  `userID` int NOT NULL,
  `actID` int NOT NULL,
  PRIMARY KEY (`myLikeID`),
  KEY `FK_myLike_actID` (`actID`),
  KEY `FK_myLike_userID` (`userID`),
  CONSTRAINT `FK_myLike_actID` FOREIGN KEY (`actID`) REFERENCES `act` (`actID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_myLike_userID` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
);


-- 購物車擁有活動
CREATE TABLE `cartact` (
  `cartActID` int NOT NULL AUTO_INCREMENT,
  `userID` int NOT NULL,
  `actID` int NOT NULL,
  `cartQuantity` int NOT NULL,
  PRIMARY KEY (`cartActID`),
  KEY `FK_cartAct_userID` (`userID`),
  KEY `FK_cartAct_actID` (`actID`),
  CONSTRAINT `FK_cartAct_actID` FOREIGN KEY (`actID`) REFERENCES `act` (`actID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_cartAct_userID` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
);


-- 拆單後訂單明細
CREATE TABLE `orderlist` (
  `orderListID` int NOT NULL AUTO_INCREMENT,
  `orderID` int DEFAULT NULL,
  `actID` int DEFAULT NULL,
  `actTotal` int NOT NULL,
  `QRcodeID` longblob,
  `orderListTime` datetime DEFAULT CURRENT_TIMESTAMP,
  `reviewContent` varchar(2550) DEFAULT NULL,
  `fiveStarReview` tinyint DEFAULT NULL,
  `seatRowsColumns` varchar(2000) NOT NULL,
  `usedType` tinyint DEFAULT NULL,
  PRIMARY KEY (`orderListID`),
  KEY `FK_orderList_actID` (`actID`),
  KEY `FK_orderList_orderID` (`orderID`),
  CONSTRAINT `FK_orderList_actID` FOREIGN KEY (`actID`) REFERENCES `act` (`actID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_orderList_orderID` FOREIGN KEY (`orderID`) REFERENCES `orders` (`orderID`) ON DELETE CASCADE ON UPDATE CASCADE
);

  
-- 評論圖片
CREATE TABLE `compic` (
  `comPicID` int NOT NULL AUTO_INCREMENT,
  `orderListID` int NOT NULL,
  `comPic` longblob,
  PRIMARY KEY (`comPicID`),
  KEY `FK_comPic_orderListID` (`orderListID`),
  CONSTRAINT `FK_comPic_orderListID` FOREIGN KEY (`orderListID`) REFERENCES `orderlist` (`orderListID`) ON DELETE CASCADE ON UPDATE CASCADE
);


-- 廠商擁有使用者
CREATE TABLE `pubuser` (
  `pubUserID` int NOT NULL AUTO_INCREMENT,
  `pubID` int NOT NULL,
  `pubNickname` varchar(10) DEFAULT NULL,
  `pubAccount` varchar(10) NOT NULL,
  `pubPassword` varchar(255) NOT NULL,
  `pubAuthority` tinyint DEFAULT '0',
  PRIMARY KEY (`pubUserID`),
  KEY `FK_pubUser_pubID` (`pubID`),
  CONSTRAINT `FK_pubUser_pubID` FOREIGN KEY (`pubID`) REFERENCES `publisher` (`pubID`) ON DELETE CASCADE ON UPDATE CASCADE
);


-- 建立假資料 actCategory -- ok
INSERT INTO actcategory (actCategoryID,actCategoryName) VALUES (1, "音樂");
INSERT INTO actcategory (actCategoryID,actCategoryName) VALUES (2, "戲劇");
INSERT INTO actcategory (actCategoryID,actCategoryName) VALUES (3, "舞蹈");
INSERT INTO actcategory (actCategoryID,actCategoryName) VALUES (4, "歌舞秀");
INSERT INTO actcategory (actCategoryID,actCategoryName) VALUES (5, "脫口秀");
INSERT INTO actcategory (actCategoryID,actCategoryName) VALUES (6, "講座");
INSERT INTO actcategory (actCategoryID,actCategoryName) VALUES (7, "演唱會");

-- 建立假資料 publisher -- ok
INSERT INTO publisher (pubName,pubEmail) VALUES ('笑點娛樂工作室','humor@gmail.com');
INSERT INTO publisher (pubName,pubEmail) VALUES ('喜劇開講俱樂部','comedy@gmail.com');
INSERT INTO publisher (pubName,pubEmail) VALUES ('樂樂傳媒公司','happymusic@gmail.com');
INSERT INTO publisher (pubName,pubEmail) VALUES ('嗨嗨人生劇場','highhigh@gmail.com');
INSERT INTO publisher (pubName,pubEmail) VALUES ('搖滾創造有限公司','rock@gmail.com');

-- 建立假資料city -- ok
INSERT INTO city VALUES (1, "臺北市");
INSERT INTO city VALUES (2, "新北市");
INSERT INTO city VALUES (3, "基隆市");
INSERT INTO city VALUES (4, "新竹市");
INSERT INTO city VALUES (5, "桃園市");
INSERT INTO city VALUES (6, "新竹縣");
INSERT INTO city VALUES (7, "宜蘭縣");
INSERT INTO city VALUES (8, "臺中市");
INSERT INTO city VALUES (9, "苗栗縣");
INSERT INTO city VALUES (10, "彰化縣");
INSERT INTO city VALUES (11, "南投縣");
INSERT INTO city VALUES (12, "雲林縣");
INSERT INTO city VALUES (13, "高雄市");
INSERT INTO city VALUES (14, "臺南市");
INSERT INTO city VALUES (15, "嘉義市");
INSERT INTO city VALUES (16, "嘉義縣");
INSERT INTO city VALUES (17, "屏東縣");
INSERT INTO city VALUES (18, "澎湖縣");
INSERT INTO city VALUES (19, "花蓮縣");
INSERT INTO city VALUES (20, "臺東縣");
INSERT INTO city VALUES (21, "金馬特別行政區");

-- 建立假資料 act -- ok
INSERT INTO act (actID,actName,actPrice,actCategoryID,pubID,actTime,cityAddressID,actScope,actIntroduce,actContent,time,actDate,approvalCondition,cityAddress) VALUES (1, '炎上',1200,5,1,20230908,1,3,'超好笑的王世堅來了!','科P與王世堅的愛情見證','17:00:00','20230908',0,'小巨蛋');
INSERT INTO act (actID,actName,actPrice,actCategoryID,pubID,actTime,cityAddressID,actScope,actIntroduce,actContent,time,actDate,approvalCondition,cityAddress) VALUES (2, '華燈初上沉浸劇場',1200,2,1,20230908,2,3,'兇手到底是誰!!','帶你實境體驗','13:00:00','2023-09-09',0,'小巨蛋');
INSERT INTO act (actID,actName,actPrice,actCategoryID,pubID,actTime,cityAddressID,actScope,actIntroduce,actContent,time,actDate,approvalCondition,cityAddress) VALUES (3, '火焰之舞',500,3,1,20230908,3,3,'今年最值得一看的踢踏舞','用整齊的舞蹈給你視覺饗宴','17:00:00','2023-09-08',0,'松菸文創');
INSERT INTO act (actID,actName,actPrice,actCategoryID,pubID,actTime,cityAddressID,actScope,actIntroduce,actContent,time,actDate,approvalCondition,cityAddress) VALUES (4, '國家音樂盛典',500,1,1,20230908,3,3,'震撼的交響樂','邀請你一起共襄盛舉','17:00:00','2023-09-08',0,'國家音樂廳');
INSERT INTO act (actID,actName,actPrice,actCategoryID,pubID,actTime,cityAddressID,actScope,actIntroduce,actContent,time,actDate,approvalCondition,cityAddress) VALUES (5, '貓Cat',500,4,1,20230908,3,3,'經典的百老匯劇場','邀請你一起共襄盛舉','17:00:00','2023-09-08',0,'國家音樂廳');

-- 建立假資料 actPic -- ok
INSERT INTO actPic (actPicID,actID,actPic) VALUES (1, 1, null);
INSERT INTO actPic (actPicID,actID,actPic) VALUES (2, 2, null);
INSERT INTO actPic (actPicID,actID,actPic) VALUES (3, 3, null);
INSERT INTO actPic (actPicID,actID,actPic) VALUES (4, 4, null);
INSERT INTO actPic (actPicID,actID,actPic) VALUES (5, 5, null);

-- 建立假資料administrator -- ok
INSERT INTO administrator (adminName,adminAccount,adminPassword,adminEmail) VALUES ('NewView','NewView','newviewpd','NewView@gmail.com');

-- 假資料user -- ok
INSERT INTO user (userID,userName, userAccount, userPassword, userBirth, userCell, userEmail, userNickname, buyAuthority, speakAuthority) VALUES (1, 'Amanda', 'aa123', '202cb962ac59075b964b07152d234b70','20230907', '0987654321', 'test@test.com', 'manda', '0', '0');
INSERT INTO user (userID,userName, userAccount, userPassword, userBirth, userCell, userEmail, userNickname, buyAuthority, speakAuthority) VALUES (2, 'Leo', 'abs44', '202cb962ac59075b964b07152d234b70','20230907', '0987780601', 'test2@test.com', 'o', '0', '0');
INSERT INTO user (userID,userName, userAccount, userPassword, userBirth, userCell, userEmail, userNickname, buyAuthority, speakAuthority) VALUES (3, 'John', 'a7123', '202cb962ac59075b964b07152d234b70','20230907', '0987087087', 'test3@test.com', 'J', '0', '0');

-- 建立假資料cartAct -- ok
INSERT INTO cartAct (cartactID,userID,actID,cartQuantity) VALUES (1,1,1,2);
INSERT INTO cartAct (cartactID,userID,actID,cartQuantity) VALUES (2,2,2,2);
INSERT INTO cartAct (cartactID,userID,actID,cartQuantity) VALUES (3,3,3,2);

-- 建立假資料discount -- ok
INSERT INTO discount (adminID,discountContent,disAmount,discountCode,disStartDate,disFinishDate) VALUES (1,'newview測試優惠',100,'nw100','20230920','20230930');
INSERT INTO discount (pubID,discountContent,disAmount,discountCode,disStartDate,disFinishDate) VALUES (1,'humor測試優惠',50,'humor50','20230910','20230916');
INSERT INTO discount (pubID,discountContent,disAmount,discountCode,disStartDate,disFinishDate) VALUES (5,'comedy測試優惠',60,'comedy60','20230915','20230930');

-- 建立假資料 orders -- ok
INSERT INTO orders (orderID,userID,ordTotal,discount,discountPrice,ordTime,pubID,ordType,actQuantity,discountNO) VALUES (1,1,1500,100,1400,'20230906',1,0,2,1);
INSERT INTO orders (orderID,userID,ordTotal,discount,discountPrice,ordTime,pubID,ordType,actQuantity,discountNO) VALUES (2,1,1000,0,1000,'20230907',2,0,2,2);
INSERT INTO orders (orderID,userID,ordTotal,discount,discountPrice,ordTime,pubID,ordType,actQuantity,discountNO) VALUES (3,1,1000,0,1000,'20230908',3,1,2,3);
INSERT INTO orders (orderID,userID,ordTotal,discount,discountPrice,ordTime,pubID,ordType,actQuantity,discountNO) VALUES (4,1,1000,0,1000,'20230909',3,1,2,3);

-- 建立假資料 orderlist -- ok
INSERT INTO orderlist (orderListID,orderID,actID,actTotal,QRcodeID,orderListTime,reviewContent,fivestarReview,seatRowsColumns,usedType) VALUES (1,1,1,500,12345678,20230909,NULL,NULL,'第 01排,第 02列',0);
INSERT INTO orderlist (orderListID,orderID,actID,actTotal,QRcodeID,orderListTime,reviewContent,fivestarReview,seatRowsColumns,usedType) VALUES (2,2,2,2500,12444678,20230909,NULL,NULL,'第 01排,第 03列',0);
INSERT INTO orderlist (orderListID,orderID,actID,actTotal,QRcodeID,orderListTime,reviewContent,fivestarReview,seatRowsColumns,usedType) VALUES (3,3,3,3500,123467778,20230909,NULL,NULL,'第 01排,第 04列',0);
INSERT INTO orderlist (orderListID,orderID,actID,actTotal,QRcodeID,orderListTime,reviewContent,fivestarReview,seatRowsColumns,usedType) VALUES (4,1,1,500,12345678,20230909,NULL,NULL,'第 01排,第 05列',0);
INSERT INTO orderlist (orderListID,orderID,actID,actTotal,QRcodeID,orderListTime,reviewContent,fivestarReview,seatRowsColumns,usedType) VALUES (5,1,1,500,12345678,20230909,NULL,NULL,'第 01排,第 06列',1);
INSERT INTO orderlist (orderListID,orderID,actID,actTotal,QRcodeID,orderListTime,reviewContent,fivestarReview,seatRowsColumns,usedType) VALUES (6,1,1,500,12345678,20230909,NULL,NULL,'第 01排,第 07列',1);
INSERT INTO orderlist (orderListID,orderID,actID,actTotal,QRcodeID,orderListTime,reviewContent,fivestarReview,seatRowsColumns,usedType) VALUES (7,2,1,500,12345678,20230909,NULL,NULL,'第 01排,第 08列',0);
INSERT INTO orderlist (orderListID,orderID,actID,actTotal,QRcodeID,orderListTime,reviewContent,fivestarReview,seatRowsColumns,usedType) VALUES (8,2,1,500,12345678,20230909,NULL,NULL,'第 01排,第 09列',0);
INSERT INTO orderlist (orderListID,orderID,actID,actTotal,QRcodeID,orderListTime,reviewContent,fivestarReview,seatRowsColumns,usedType) VALUES (9,2,1,500,12345678,20230909,NULL,NULL,'第 01排,第 10列',1);
INSERT INTO orderlist (orderListID,orderID,actID,actTotal,QRcodeID,orderListTime,reviewContent,fivestarReview,seatRowsColumns,usedType) VALUES (10,2,1,500,12345678,20230909,NULL,NULL,'第 02排,第 01列',1);
INSERT INTO orderlist (orderListID,orderID,actID,actTotal,QRcodeID,orderListTime,reviewContent,fivestarReview,seatRowsColumns,usedType) VALUES (11,3,1,500,12345678,20230909,NULL,NULL,'第 02排,第 02列',1);
INSERT INTO orderlist (orderListID,orderID,actID,actTotal,QRcodeID,orderListTime,reviewContent,fivestarReview,seatRowsColumns,usedType) VALUES (12,3,1,500,12345678,20230909,NULL,NULL,'第 02排,第 03列',1);
INSERT INTO orderlist (orderListID,orderID,actID,actTotal,QRcodeID,orderListTime,reviewContent,fivestarReview,seatRowsColumns,usedType) VALUES (13,3,1,500,12345678,20230909,NULL,NULL,'第 02排,第 04列',1);
INSERT INTO orderlist (orderListID,orderID,actID,actTotal,QRcodeID,orderListTime,reviewContent,fivestarReview,seatRowsColumns,usedType) VALUES (14,3,1,500,12345678,20230909,NULL,NULL,'第 02排,第 05列',1);
INSERT INTO orderlist (orderListID,orderID,actID,actTotal,QRcodeID,orderListTime,reviewContent,fivestarReview,seatRowsColumns,usedType) VALUES (15,4,1,500,12345678,20230909,NULL,NULL,'第 02排,第 06列',1);
INSERT INTO orderlist (orderListID,orderID,actID,actTotal,QRcodeID,orderListTime,reviewContent,fivestarReview,seatRowsColumns,usedType) VALUES (16,4,1,500,12345678,20230909,NULL,NULL,'第 02排,第 07列',1);
INSERT INTO orderlist (orderListID,orderID,actID,actTotal,QRcodeID,orderListTime,reviewContent,fivestarReview,seatRowsColumns,usedType) VALUES (17,4,1,500,12345678,20230909,NULL,NULL,'第 02排,第 08列',1);
INSERT INTO orderlist (orderListID,orderID,actID,actTotal,QRcodeID,orderListTime,reviewContent,fivestarReview,seatRowsColumns,usedType) VALUES (18,4,1,500,12345678,20230909,NULL,NULL,'第 02排,第 09列',1);




-- 建立假資料 comPic -- ok
INSERT INTO compic (compicID,orderlistID,comPic) VALUES (1, 1, null);
INSERT INTO compic (compicID,orderlistID,comPic) VALUES (2, 2, null);
INSERT INTO compic (compicID,orderlistID,comPic) VALUES (3, 3, null);

-- 建立假資料 postcategory -- ok
INSERT INTO postCategory (postCategoryID,postCategoryName) VALUES (1, "綜合討論(換票揪團)All");
INSERT INTO postCategory (postCategoryID,postCategoryName) VALUES (2, "音樂表演Music");
INSERT INTO postCategory (postCategoryID,postCategoryName) VALUES (3, "戲劇表演Drama");
INSERT INTO postCategory (postCategoryID,postCategoryName) VALUES (4, "舞蹈表演Dance");
INSERT INTO postCategory (postCategoryID,postCategoryName) VALUES (5, "脫口秀TalkShow");
INSERT INTO postCategory (postCategoryID,postCategoryName) VALUES (6, "演唱會SingConcert");
INSERT INTO postCategory (postCategoryID,postCategoryName) VALUES  (7, "講座Lecture");

-- 建立假資料 post -- ok
INSERT INTO post (postID,userID,postCategoryID,postHeader,postDateTime,lastEditedTime,postContent,dislikecount,likecount,postStatus) VALUES (1, 1,1,'有趣的活動',CURRENT_TIMESTAMP,20230908,'很棒',0,5,0);
INSERT INTO post (postID,userID,postCategoryID,postHeader,postDateTime,lastEditedTime,postContent,dislikecount,likecount,postStatus) VALUES (2, 2,2,'有趣的活動',CURRENT_TIMESTAMP,20230908,'很棒',0,5,0);
INSERT INTO post (postID,userID,postCategoryID,postHeader,postDateTime,lastEditedTime,postContent,dislikecount,likecount,postStatus) VALUES (3, 3,3,'有趣的活動',CURRENT_TIMESTAMP,20230908,'很棒',0,5,0);
INSERT INTO post (postID,userID,postCategoryID,postHeader,postDateTime,lastEditedTime,postContent,dislikecount,likecount,postStatus) VALUES (4, 3,4,'有趣的活動',CURRENT_TIMESTAMP,20230908,'很棒',0,5,0);

-- 建立假資料Likes -- ok
INSERT INTO Likes (likeID,postID,userID,likeOrNot,visitorID) VALUES (1,1,1,0,0);
INSERT INTO Likes (likeID,postID,userID,likeOrNot,visitorID) VALUES (2,2,2,1,0);
INSERT INTO Likes (likeID,postID,userID,likeOrNot,visitorID) VALUES (3,3,3,0,0);
INSERT INTO Likes (likeID,postID,userID,likeOrNot,visitorID) VALUES (4,4,1,1,0);

-- 建立假資料myLike -- ok
INSERT INTO myLike (mylikeID,userID,actID) VALUES (1,1,1);
INSERT INTO myLike (mylikeID,userID,actID) VALUES (2,2,2);
INSERT INTO myLike (mylikeID,userID,actID) VALUES (3,3,3);

-- 建立假資料postMessage  -- ok
INSERT INTO postMessage(postMessageID,postID,userID,mesContent,messageDate) VALUES (1,1,1,'真的好讚','20230920');
INSERT INTO postMessage(postMessageID,postID,userID,mesContent,messageDate) VALUES (2,2,2,'真的好讚','20230920');
INSERT INTO postMessage(postMessageID,postID,userID,mesContent,messageDate) VALUES (3,3,3,'真的好讚','20230920');

-- 建立假資料 postPic -- ok
INSERT INTO postPic (postPicID,postID,postPic) VALUES (1, 1, null);
INSERT INTO postPic (postPicID,postID,postPic) VALUES (2, 2, null);
INSERT INTO postPic (postPicID,postID,postPic) VALUES (3, 3, null);

-- 建立假資料 pubUser -- ok
INSERT INTO pubUser (pubID,pubNickname,pubAccount,pubPassword,pubAuthority) VALUES (1,'小點','humor01','humorpw',1);
INSERT INTO pubUser (pubID,pubNickname,pubAccount,pubPassword,pubAuthority) VALUES (2,'小喜','comedy01','comedypd',1);
INSERT INTO pubUser (pubID,pubNickname,pubAccount,pubPassword,pubAuthority) VALUES (3,'小樂','hamusic01','hamusicpd',1);
INSERT INTO pubUser (pubID,pubNickname,pubAccount,pubPassword,pubAuthority) VALUES (4,'小嗨','highhigh01','highpd',1);
INSERT INTO pubUser (pubID,pubNickname,pubAccount,pubPassword,pubAuthority) VALUES (5,'小滾','rock01','rockpd',1);

-- 建立假資料report -- ok
INSERT INTO report(reportID,userID,postID,reportContent,reportStatus) VALUES (1,1,1,'講話很糟糕',0);
INSERT INTO report(reportID,userID,postID,reportContent,reportStatus) VALUES (2,2,2,'講話很糟糕',0);
INSERT INTO report(reportID,userID,postID,reportContent,reportStatus) VALUES (3,3,3,'講話很糟糕',0);

-- 假資料usediscount -- ok
INSERT INTO usediscount (useDisID,discountNO,userID,ditUsed) VALUES (1,1,1,0);
INSERT INTO usediscount (useDisID,discountNO,userID,ditUsed) VALUES (2,2,2,0);
INSERT INTO usediscount (useDisID,discountNO,userID,ditUsed) VALUES (3,1,3,0);
INSERT INTO usediscount (useDisID,discountNO,userID,ditUsed) VALUES (4,3,3,0);