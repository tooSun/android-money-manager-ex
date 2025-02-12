-- 描述 ACCOUNTLIST_V1 表
CREATE TABLE ACCOUNTLIST_V1(
ACCOUNTID integer primary key  -- 账户ID，主键
, ACCOUNTNAME TEXT COLLATE NOCASE NOT NULL UNIQUE  -- 账户名称，不区分大小写，非空且唯一
, ACCOUNTTYPE TEXT NOT NULL /* Checking, Term, Investment, Credit Card */  -- 账户类型（支票、定期、投资、信用卡），非空
, ACCOUNTNUM TEXT  -- 账户号码
, STATUS TEXT NOT NULL /* Open, Closed */  -- 状态（开启、关闭），非空
, NOTES TEXT  -- 备注
, HELDAT TEXT  -- 保持信息
, WEBSITE TEXT  -- 网站
, CONTACTINFO TEXT  -- 联系信息
, ACCESSINFO TEXT  -- 访问信息
, INITIALBAL numeric  -- 初始余额
, INITIALDATE TEXT  -- 初始日期
, FAVORITEACCT TEXT NOT NULL  -- 收藏账户，非空
, CURRENCYID integer NOT NULL  -- 货币ID，非空
, STATEMENTLOCKED integer  -- 对账单锁定
, STATEMENTDATE TEXT  -- 对账单日期
, MINIMUMBALANCE numeric  -- 最低余额
, CREDITLIMIT numeric  -- 信用额度
, INTERESTRATE numeric  -- 利率
, PAYMENTDUEDATE text  -- 付款到期日
, MINIMUMPAYMENT numeric  -- 最低付款额
);
CREATE INDEX IDX_ACCOUNTLIST_ACCOUNTTYPE ON ACCOUNTLIST_V1(ACCOUNTTYPE);  -- 为账户类型创建索引

-- 描述 ASSETS_V1 表
CREATE TABLE ASSETS_V1(
ASSETID integer primary key  -- 资产ID，主键
, STARTDATE TEXT NOT NULL  -- 开始日期，非空
, ASSETNAME TEXT COLLATE NOCASE NOT NULL  -- 资产名称，不区分大小写，非空
, ASSETSTATUS TEXT /* Open, Closed */  -- 资产状态（开启、关闭）
, CURRENCYID integer  -- 货币ID
, VALUECHANGEMODE TEXT /* Percentage, Linear */  -- 价值变化模式（百分比、线性）
, VALUE numeric  -- 价值
, VALUECHANGE TEXT /* None, Appreciates, Depreciates */  -- 价值变化（无、升值、贬值）
, NOTES TEXT  -- 备注
, VALUECHANGERATE numeric  -- 价值变化率
, ASSETTYPE TEXT /* Property, Automobile, Household Object, Art, Jewellery, Cash, Other */  -- 资产类型（房产、汽车、家庭用品、艺术品、珠宝、现金、其他）
);
CREATE INDEX IDX_ASSETS_ASSETTYPE ON ASSETS_V1(ASSETTYPE);  -- 为资产类型创建索引

-- 描述 BILLSDEPOSITS_V1 表
CREATE TABLE BILLSDEPOSITS_V1(
BDID integer primary key  -- 账单存款ID，主键
, ACCOUNTID integer NOT NULL  -- 账户ID，非空
, TOACCOUNTID integer  -- 转入账户ID
, PAYEEID integer NOT NULL  -- 收款人ID，非空
, TRANSCODE TEXT NOT NULL /* Withdrawal, Deposit, Transfer */  -- 交易类型（取款、存款、转账），非空
, TRANSAMOUNT numeric NOT NULL  -- 交易金额，非空
, STATUS TEXT /* None, Reconciled, Void, Follow up, Duplicate */  -- 状态（无、对账、无效、跟进、重复）
, TRANSACTIONNUMBER TEXT  -- 交易编号
, NOTES TEXT  -- 备注
, CATEGID integer  -- 分类ID
, TRANSDATE TEXT  -- 交易日期
, FOLLOWUPID integer  -- 跟进ID
, TOTRANSAMOUNT numeric  -- 总交易金额
, REPEATS integer  -- 重复次数
, NEXTOCCURRENCEDATE TEXT  -- 下次发生日期
, NUMOCCURRENCES integer  -- 发生次数
, COLOR integer DEFAULT -1  -- 颜色，默认-1
);
CREATE INDEX IDX_BILLSDEPOSITS_ACCOUNT ON BILLSDEPOSITS_V1 (ACCOUNTID, TOACCOUNTID);  -- 为账户创建索引

-- 描述 BUDGETSPLITTRANSACTIONS_V1 表
CREATE TABLE BUDGETSPLITTRANSACTIONS_V1(
SPLITTRANSID integer primary key  -- 分拆交易ID，主键
, TRANSID integer NOT NULL  -- 交易ID，非空
, CATEGID integer  -- 分类ID
, SPLITTRANSAMOUNT numeric  -- 分拆交易金额
, NOTES TEXT  -- 备注
);
CREATE INDEX IDX_BUDGETSPLITTRANSACTIONS_TRANSID ON BUDGETSPLITTRANSACTIONS_V1(TRANSID);  -- 为交易ID创建索引

-- 描述 BUDGETTABLE_V1 表
CREATE TABLE BUDGETTABLE_V1(
BUDGETENTRYID integer primary key  -- 预算条目ID，主键
, BUDGETYEARID integer  -- 预算年份ID
, CATEGID integer  -- 分类ID
, PERIOD TEXT NOT NULL /* None, Weekly, Bi-Weekly, Monthly, Bi-Monthly, Quarterly, Half-Yearly, Yearly, Daily */  -- 周期（无、每周、每两周、每月、双月、每季度、每半年、每年、每日），非空
, AMOUNT numeric NOT NULL  -- 金额，非空
, NOTES TEXT  -- 备注
, ACTIVE integer  -- 活跃状态
);
CREATE INDEX IDX_BUDGETTABLE_BUDGETYEARID ON BUDGETTABLE_V1(BUDGETYEARID);  -- 为预算年份ID创建索引

-- 描述 BUDGETYEAR_V1 表
CREATE TABLE BUDGETYEAR_V1(
BUDGETYEARID integer primary key  -- 预算年份ID，主键
, BUDGETYEARNAME TEXT NOT NULL UNIQUE  -- 预算年份名称，非空且唯一
);
CREATE INDEX IDX_BUDGETYEAR_BUDGETYEARNAME ON BUDGETYEAR_V1(BUDGETYEARNAME);  -- 为预算年份名称创建索引

-- 描述 CATEGORY_V1 表
CREATE TABLE CATEGORY_V1
( CATEGID INTEGER PRIMARY KEY,  -- 分类ID，主键
  CATEGNAME TEXT NOT NULL COLLATE NOCASE,  -- 分类名称，不区分大小写，非空
  ACTIVE INTEGER,  -- 活跃状态
  PARENTID INTEGER,  -- 父分类ID
  UNIQUE(CATEGNAME, PARENTID)  -- 分类名称和父分类ID唯一约束
);
CREATE INDEX IDX_CATEGORY_CATEGNAME ON CATEGORY_V1(CATEGNAME);  -- 为分类名称创建索引
CREATE INDEX IDX_CATEGORY_CATEGNAME_PARENTID ON CATEGORY_V1(CATEGNAME, PARENTID);  -- 为分类名称和父分类ID创建索引

-- Note: All strings requiring translation are prefix by: ''
-- The _tr_ prefix is removed when generating .h files by sqlite2cpp.py
-- strings containing unicode should not be translated.
INSERT INTO CATEGORY_V1 VALUES(1,'账单',1,-1);
INSERT INTO CATEGORY_V1 VALUES(2,'电话',1,1);
INSERT INTO CATEGORY_V1 VALUES(3,'电费',1,1);
INSERT INTO CATEGORY_V1 VALUES(4,'燃气',1,1);
INSERT INTO CATEGORY_V1 VALUES(5,'互联网',1,1);
INSERT INTO CATEGORY_V1 VALUES(6,'租金',1,1);
INSERT INTO CATEGORY_V1 VALUES(7,'有线电视',1,1);
INSERT INTO CATEGORY_V1 VALUES(8,'水费',1,1);
INSERT INTO CATEGORY_V1 VALUES(9,'食品',1,-1);
INSERT INTO CATEGORY_V1 VALUES(10,'杂货',1,9);
INSERT INTO CATEGORY_V1 VALUES(11,'外出就餐',1,9);
INSERT INTO CATEGORY_V1 VALUES(12,'休闲',1,-1);
INSERT INTO CATEGORY_V1 VALUES(13,'电影',1,12);
INSERT INTO CATEGORY_V1 VALUES(14,'视频租赁',1,12);
INSERT INTO CATEGORY_V1 VALUES(15,'杂志',1,12);
INSERT INTO CATEGORY_V1 VALUES(16,'汽车',1,-1);
INSERT INTO CATEGORY_V1 VALUES(17,'维护',1,16);
INSERT INTO CATEGORY_V1 VALUES(18,'燃料',1,16);
INSERT INTO CATEGORY_V1 VALUES(19,'停车',1,16);
INSERT INTO CATEGORY_V1 VALUES(20,'注册',1,16);
INSERT INTO CATEGORY_V1 VALUES(21,'教育',1,-1);
INSERT INTO CATEGORY_V1 VALUES(22,'书籍',1,21);
INSERT INTO CATEGORY_V1 VALUES(23,'学费',1,21);
INSERT INTO CATEGORY_V1 VALUES(24,'其他',1,21);
INSERT INTO CATEGORY_V1 VALUES(25,'家庭需求',1,-1);
INSERT INTO CATEGORY_V1 VALUES(26,'服装',1,25);
INSERT INTO CATEGORY_V1 VALUES(27,'家具',1,25);
INSERT INTO CATEGORY_V1 VALUES(28,'其他',1,25);
INSERT INTO CATEGORY_V1 VALUES(29,'医疗保健',1,-1);
INSERT INTO CATEGORY_V1 VALUES(30,'健康',1,29);
INSERT INTO CATEGORY_V1 VALUES(31,'牙科',1,29);
INSERT INTO CATEGORY_V1 VALUES(32,'眼科',1,29);
INSERT INTO CATEGORY_V1 VALUES(33,'医生',1,29);
INSERT INTO CATEGORY_V1 VALUES(34,'处方',1,29);
INSERT INTO CATEGORY_V1 VALUES(35,'保险',1,-1);
INSERT INTO CATEGORY_V1 VALUES(36,'汽车',1,35);
INSERT INTO CATEGORY_V1 VALUES(37,'人寿',1,35);
INSERT INTO CATEGORY_V1 VALUES(38,'家居',1,35);
INSERT INTO CATEGORY_V1 VALUES(39,'健康',1,35);
INSERT INTO CATEGORY_V1 VALUES(40,'假期',1,-1);
INSERT INTO CATEGORY_V1 VALUES(41,'旅行',1,40);
INSERT INTO CATEGORY_V1 VALUES(42,'住宿',1,40);
INSERT INTO CATEGORY_V1 VALUES(43,'观光',1,40);
INSERT INTO CATEGORY_V1 VALUES(44,'税收',1,-1);
INSERT INTO CATEGORY_V1 VALUES(45,'所得税',1,44);
INSERT INTO CATEGORY_V1 VALUES(46,'房产税',1,44);
INSERT INTO CATEGORY_V1 VALUES(47,'水税',1,44);
INSERT INTO CATEGORY_V1 VALUES(48,'其他',1,44);
INSERT INTO CATEGORY_V1 VALUES(49,'杂项',1,-1);
INSERT INTO CATEGORY_V1 VALUES(50,'礼物',1,-1);
INSERT INTO CATEGORY_V1 VALUES(51,'收入',1,-1);
INSERT INTO CATEGORY_V1 VALUES(52,'工资',1,51);
INSERT INTO CATEGORY_V1 VALUES(53,'报销/退款',1,51);
INSERT INTO CATEGORY_V1 VALUES(54,'投资收入',1,51);
INSERT INTO CATEGORY_V1 VALUES(55,'其他收入',1,-1);
INSERT INTO CATEGORY_V1 VALUES(56,'其他费用',1,-1);
INSERT INTO CATEGORY_V1 VALUES(57,'转账',1,-1);

-- 描述 CHECKINGACCOUNT_V1 表
CREATE TABLE CHECKINGACCOUNT_V1(
TRANSID integer primary key  -- 交易ID，主键
, ACCOUNTID integer NOT NULL  -- 账户ID，非空
, TOACCOUNTID integer  -- 转入账户ID
, PAYEEID integer NOT NULL  -- 收款人ID，非空
, TRANSCODE TEXT NOT NULL /* Withdrawal, Deposit, Transfer */  -- 交易类型（取款、存款、转账），非空
, TRANSAMOUNT numeric NOT NULL  -- 交易金额，非空
, STATUS TEXT /* None, Reconciled, Void, Follow up, Duplicate */  -- 状态（无、对账、无效、跟进、重复）
, TRANSACTIONNUMBER TEXT  -- 交易编号
, NOTES TEXT  -- 备注
, CATEGID integer  -- 分类ID
, TRANSDATE TEXT  -- 交易日期
, LASTUPDATEDTIME TEXT  -- 最后更新时间
, DELETEDTIME TEXT  -- 删除时间
, FOLLOWUPID integer  -- 跟进ID
, TOTRANSAMOUNT numeric  -- 总交易金额
, COLOR integer DEFAULT -1  -- 颜色，默认-1
);
CREATE INDEX IDX_CHECKINGACCOUNT_ACCOUNT ON CHECKINGACCOUNT_V1 (ACCOUNTID, TOACCOUNTID);  -- 为账户创建索引
CREATE INDEX IDX_CHECKINGACCOUNT_TRANSDATE ON CHECKINGACCOUNT_V1 (TRANSDATE);  -- 为交易日期创建索引

-- 描述 CURRENCYHISTORY_V1 表
CREATE TABLE CURRENCYHISTORY_V1(
CURRHISTID INTEGER PRIMARY KEY  -- 货币历史ID，主键
, CURRENCYID INTEGER NOT NULL  -- 货币ID，非空
, CURRDATE TEXT NOT NULL  -- 货币日期，非空
, CURRVALUE NUMERIC NOT NULL  -- 货币值，非空
, CURRUPDTYPE INTEGER  -- 货币更新类型
, UNIQUE(CURRENCYID, CURRDATE)  -- 货币ID和货币日期唯一约束
);
CREATE INDEX IDX_CURRENCYHISTORY_CURRENCYID_CURRDATE ON CURRENCYHISTORY_V1(CURRENCYID, CURRDATE);  -- 为货币ID和货币日期创建索引

-- 描述 CURRENCYFORMATS_V1 表
CREATE TABLE CURRENCYFORMATS_V1(
CURRENCYID integer primary key  -- 货币ID，主键
, CURRENCYNAME TEXT COLLATE NOCASE NOT NULL UNIQUE  -- 货币名称，不区分大小写，非空且唯一
, PFX_SYMBOL TEXT  -- 前缀符号
, SFX_SYMBOL TEXT  -- 后缀符号
, DECIMAL_POINT TEXT  -- 小数点
, GROUP_SEPARATOR TEXT  -- 组分隔符
, UNIT_NAME TEXT COLLATE NOCASE  -- 单位名称，不区分大小写
, CENT_NAME TEXT COLLATE NOCASE  -- 分名称，不区分大小写
, SCALE integer  -- 规模
, BASECONVRATE numeric  -- 基础转换率
, CURRENCY_SYMBOL TEXT COLLATE NOCASE NOT NULL UNIQUE  -- 货币符号，不区分大小写，非空且唯一
, CURRENCY_TYPE TEXT NOT NULL /* Fiat, Crypto */  -- 货币类型（法定货币、加密货币），非空
);
CREATE INDEX IDX_CURRENCYFORMATS_SYMBOL ON CURRENCYFORMATS_V1(CURRENCY_SYMBOL);  -- 为货币符号创建索引


-- Note: All strings requiring translation are prefix by: ''
-- The _tr_ prefix is removed when generating .h files by sqlite2cpp.py
-- strings containing unicode should not be translated.
INSERT INTO CURRENCYFORMATS_V1 VALUES(1,'美元','$','','.',',','Dollar','Cent',100,1,'USD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(2,'欧元','€','','.',' ','','',100,1,'EUR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(3,'英镑','£','','.',' ','Pound','Pence',100,1,'GBP','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(4,'俄罗斯卢布','','р',',',' ','руб.','коп.',100,1,'RUB','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(5,'乌克兰格里夫纳','₴','',',',' ','','',100,1,'UAH','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(6,'阿富汗尼','؋','','.',' ','','pul',100,1,'AFN','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(7,'阿尔巴尼亚列克','','L','.',' ','','',1,1,'ALL','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(8,'阿尔及利亚第纳尔','دج','','.',' ','','',100,1,'DZD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(9,'安哥拉宽扎','','Kz','.',' ','','Céntimo',100,1,'AOA','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(10,'东加勒比元','EC$','','.',' ','','',100,1,'XCD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(11,'阿根廷比索','AR$','',',','.','','centavo',100,1,'ARS','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(12,'亚美尼亚德拉姆','','','.',' ','','',1,1,'AMD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(13,'阿鲁巴弗罗林','ƒ','','.',' ','','',100,1,'AWG','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(14,'澳大利亚元','$','','.',',','','',100,1,'AUD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(15,'阿塞拜疆马纳特','','','.',' ','','',100,1,'AZN','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(16,'巴哈马元','B$','','.',' ','','',100,1,'BSD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(17,'巴林第纳尔','','','.',' ','','',100,1,'BHD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(18,'孟加拉塔卡','','','.',' ','','',100,1,'BDT','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(19,'巴巴多斯元','Bds$','','.',' ','','',100,1,'BBD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(20,'白俄罗斯卢布 (2000-2016)','Br','',',',' ','','',1,1,'BYR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(21,'伯利兹元','BZ$','','.',' ','','',100,1,'BZD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(22,'西非CFA法郎','CFA','','.',' ','','',100,1,'XOF','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(23,'百慕大元','BD$','','.',' ','','',100,1,'BMD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(24,'不丹努扎姆','Nu.','','.',' ','','',100,1,'BTN','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(25,'玻利维亚诺','Bs.','','.',' ','','',100,1,'BOB','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(26,'波黑可兑换马克','KM','',',','.','','',100,1,'BAM','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(27,'博茨瓦纳普拉','P','','.',' ','','',100,1,'BWP','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(28,'巴西雷亚尔','R$','','.',' ','','',100,1,'BRL','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(29,'文莱元','B$','','.',' ','','',100,1,'BND','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(30,'保加利亚列弗','','','.',' ','','',100,1,'BGN','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(31,'布隆迪法郎','FBu','','.',' ','','',1,1,'BIF','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(32,'柬埔寨瑞尔','','','.',' ','','',100,1,'KHR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(33,'中非CFA法郎','CFA','','.',' ','','',1,1,'XAF','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(34,'加拿大元','$','','.',' ','','',100,1,'CAD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(35,'佛得角埃斯库多','Esc','','.',' ','','',100,1,'CVE','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(36,'开曼群岛元','KY$','','.',' ','','',100,1,'KYD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(37,'智利比索','$','','.',' ','','',1,1,'CLP','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(38,'人民币','¥','','.',' ','','',100,1,'CNY','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(39,'哥伦比亚比索','Col$','','.',' ','','',100,1,'COP','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(40,'科摩罗法郎','','','.',' ','','',1,1,'KMF','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(41,'刚果法郎','F','','.',' ','','',100,1,'CDF','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(42,'哥斯达黎加科朗','₡','','.',' ','','',1,1,'CRC','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(43,'克罗地亚库纳','kn','','.',' ','','',100,1,'HRK','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(44,'捷克克朗','Kč','','.',' ','','',100,1,'CZK','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(45,'丹麦克朗','Kr','','.',' ','','',100,1,'DKK','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(46,'吉布提法郎','Fdj','','.',' ','','',1,1,'DJF','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(47,'多米尼加比索','RD$','','.',' ','','',100,1,'DOP','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(48,'埃及镑','£','','.',' ','','',100,1,'EGP','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(49,'厄立特里亚纳克法','Nfa','','.',' ','','',100,1,'ERN','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(50,'埃塞俄比亚比尔','Br','','.',' ','','',100,1,'ETB','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(51,'福克兰群岛镑','£','','.',' ','','',100,1,'FKP','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(52,'斐济元','FJ$','','.',' ','','',100,1,'FJD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(53,'CFP法郎','F','','.',' ','','',100,1,'XPF','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(54,'冈比亚达拉西','D','','.',' ','','',100,1,'GMD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(55,'格鲁吉亚拉里','','','.',' ','','',100,1,'GEL','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(56,'加纳塞地','','','.',' ','','',100,1,'GHS','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(57,'直布罗陀镑','£','','.',' ','','',100,1,'GIP','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(58,'危地马拉格查尔','Q','','.',' ','','',100,1,'GTQ','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(59,'几内亚法郎','FG','','.',' ','','',1,1,'GNF','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(60,'圭亚那元','GY$','','.',' ','','',100,1,'GYD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(61,'海地古德','G','','.',' ','','',100,1,'HTG','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(62,'洪都拉斯伦皮拉','L','','.',' ','','',100,1,'HNL','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(63,'港元','HK$','','.',' ','','',100,1,'HKD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(64,'匈牙利福林','Ft','','.',' ','','',1,1,'HUF','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(65,'冰岛克朗','kr','','.',' ','','',1,1,'ISK','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(66,'印度卢比','₹','','.',' ','','',100,1,'INR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(67,'印尼盾','Rp','','.',' ','','',1,1,'IDR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(68,'特别提款权','SDR','','.',' ','','',100,1,'XDR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(69,'伊朗里亚尔','','','.',' ','','',1,1,'IRR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(70,'伊拉克第纳尔','','','.',' ','','',1,1,'IQD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(71,'以色列新谢克尔','₪','','.',' ','','',100,1,'ILS','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(72,'牙买加元','J$','','.',' ','','',100,1,'JMD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(73,'日元','¥','','.',' ','','',1,1,'JPY','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(74,'约旦第纳尔','','','.',' ','','',100,1,'JOD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(75,'哈萨克斯坦坚戈','T','','.',' ','','',100,1,'KZT','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(76,'肯尼亚先令','KSh','','.',' ','','',100,1,'KES','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(77,'朝鲜元','W','','.',' ','','',100,1,'KPW','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(78,'韩元','W','','.',' ','','',1,1,'KRW','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(79,'科威特第纳尔','','','.',' ','','',100,1,'KWD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(80,'吉尔吉斯斯坦索姆','','','.',' ','','',100,1,'KGS','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(81,'老挝基普','KN','','.',' ','','',100,1,'LAK','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(82,'拉脱维亚拉特','Ls','','.',' ','','',100,1,'LVL','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(83,'黎巴嫩镑','','','.',' ','','',1,1,'LBP','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(84,'莱索托洛蒂','M','','.',' ','','',100,1,'LSL','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(85,'利比里亚元','L$','','.',' ','','',100,1,'LRD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(86,'利比亚第纳尔','LD','','.',' ','','',100,1,'LYD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(87,'立陶宛立特','Lt','','.',' ','','',100,1,'LTL','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(88,'澳门元','P','','.',' ','','',100,1,'MOP','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(89,'马其顿第纳尔','','','.',' ','','',100,1,'MKD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(90,'马达加斯加阿里亚里','FMG','','.',' ','','',100,1,'MGA','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(91,'马拉维克瓦查','MK','','.',' ','','',1,1,'MWK','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(92,'马来西亚林吉特','RM','','.',' ','','',100,1,'MYR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(93,'马尔代夫拉菲亚','Rf','','.',' ','','',100,1,'MVR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(94,'毛里塔尼亚乌吉亚 (1973-2017)','UM','','.',' ','','',100,1,'MRO','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(95,'毛里求斯卢比','Rs','','.',' ','','',1,1,'MUR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(96,'墨西哥比索','$','','.',' ','','',100,1,'MXN','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(97,'摩尔多瓦列伊','','','.',' ','','',100,1,'MDL','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(98,'蒙古图格里克','₮','','.',' ','','',100,1,'MNT','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(99,'摩洛哥迪拉姆','','','.',' ','','',100,1,'MAD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(100,'缅元','K','','.',' ','','',1,1,'MMK','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(101,'纳米比亚元','N$','','.',' ','','',100,1,'NAD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(102,'尼泊尔卢比','NRs','','.',' ','','',100,1,'NPR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(103,'荷属安的列斯盾','NAƒ','','.',' ','','',100,1,'ANG','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(104,'新西兰元','NZ$','','.',' ','','',100,1,'NZD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(105,'尼加拉瓜科多巴','C$','','.',' ','','',100,1,'NIO','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(106,'尼日利亚奈拉','₦','','.',' ','','',100,1,'NGN','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(107,'挪威克朗','kr','','.',' ','','',100,1,'NOK','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(108,'阿曼里亚尔','','','.',' ','','',100,1,'OMR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(109,'巴基斯坦卢比','Rs.','','.',' ','','',1,1,'PKR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(110,'巴拿马巴波亚','B./','','.',' ','','',100,1,'PAB','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(111,'巴布亚新几内亚基那','K','','.',' ','','',100,1,'PGK','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(112,'巴拉圭瓜拉尼','','','.',' ','','',1,1,'PYG','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(113,'秘鲁新索尔','S/.','','.',' ','','',100,1,'PEN','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(114,'菲律宾比索','₱','','.',' ','','',100,1,'PHP','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(115,'波兰兹罗提','','zł',',','.','złoty','grosz',100,1,'PLN','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(116,'卡塔尔里亚尔','QR','','.',' ','','',100,1,'QAR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(117,'罗马尼亚列伊','L','','.',' ','','',100,1,'RON','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(118,'卢旺达法郎','RF','','.',' ','','',1,1,'RWF','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(119,'圣多美和普林西比多布拉 (1977-2017)','Db','','.',' ','','',100,1,'STD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(120,'沙特里亚尔','SR','','.',' ','','',100,1,'SAR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(121,'塞尔维亚第纳尔','din.','','.',' ','','',1,1,'RSD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(122,'塞舌尔卢比','SR','','.',' ','','',100,1,'SCR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(123,'塞拉利昂利昂 (1964-2022)','Le','','.',' ','','',100,1,'SLL','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(124,'新加坡元','S$','','.',' ','','',100,1,'SGD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(125,'所罗门群岛元','SI$','','.',' ','','',100,1,'SBD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(126,'索马里先令','Sh.','','.',' ','','',1,1,'SOS','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(127,'南非兰特','R','','.',' ','','',100,1,'ZAR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(128,'斯里兰卡卢比','Rs','','.',' ','','',100,1,'LKR','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(129,'圣赫勒拿镑','£','','.',' ','','',100,1,'SHP','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(130,'苏丹镑','','','.',' ','','',100,1,'SDG','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(131,'苏里南元','$','','.',' ','','',100,1,'SRD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(132,'斯威士兰里兰吉尼','E','','.',' ','','',100,1,'SZL','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(133,'瑞典克朗','kr','','.',' ','','',100,1,'SEK','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(134,'瑞士法郎','Fr.','','.',' ','','',100,1,'CHF','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(135,'叙利亚镑','','','.',' ','','',1,1,'SYP','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(136,'新台币','NT$','','.',' ','','',100,1,'TWD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(137,'塔吉克斯坦索莫尼','','','.',' ','','',100,1,'TJS','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(138,'坦桑尼亚先令','','','.',' ','','',1,1,'TZS','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(139,'泰铢','฿','','.',' ','','',100,1,'THB','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(140,'特立尼达和多巴哥元','TT$','','.',' ','','',100,1,'TTD','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(141,'突尼斯第纳尔','DT','','.',' ','','',100,1,'TND','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(142,'土耳其里拉','₺','','.',' ','','',100,1,'TRY','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(143,'土库曼斯坦马纳特','m','','.',' ','','',100,1,'TMT','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(144,'乌干达先令','USh','','.',' ','','',1,1,'UGX','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(145,'阿联酋迪拉姆','','','.',' ','','',100,1,'AED','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(146,'乌拉圭比索','$U','','.',' ','','',100,1,'UYU','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(147,'乌兹别克斯坦苏姆','','','.',' ','','',1,1,'UZS','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(148,'瓦努阿图瓦图','VT','','.',' ','','',100,1,'VUV','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(149,'越南盾','₫','','.',' ','','',1,1,'VND','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(150,'萨摩亚塔拉','WS$','','.',' ','','',100,1,'WST','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(151,'也门里亚尔','','','.',' ','','',1,1,'YER','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(152,'委内瑞拉玻利瓦尔 (2008-2018)','Bs.','','.',',','bolívar','céntimos',100,1,'VEF','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(153,'比特币','Ƀ','','.',',','','',100000000,1,'BTC','Crypto');
INSERT INTO CURRENCYFORMATS_V1 VALUES(154,'白俄罗斯卢布','BYN','','.',',','','',100,1,'BYN','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(155,'古巴可兑换比索','$','','.',',','','',100,1,'CUC','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(156,'古巴比索','$','','.',',','','',100,1,'CUP','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(157,'毛里塔尼亚乌吉亚','MRU','','.',',','','',100,1,'MRU','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(158,'莫桑比克梅蒂卡尔','MZN','','.',',','','',100,1,'MZN','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(159,'塞拉利昂利昂','SLE','','.',',','','',100,1,'SLE','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(160,'南苏丹镑','£','','.',',','','',100,1,'SSP','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(161,'圣多美和普林西比多布拉','Db','','.',',','','',100,1,'STN','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(162,'萨尔瓦多科朗','SVC','','.',',','','',100,1,'SVC','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(163,'汤加潘加','T$','','.',',','','',100,1,'TOP','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(164,'乌拉圭名义工资指数单位','UYW','','.',',','','',10000,1,'UYW','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(165,'主权玻利瓦尔','VED','','.',',','','',100,1,'VED','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(166,'委内瑞拉玻利瓦尔','VES','','.',',','','',100,1,'VES','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(167,'赞比亚克瓦查','ZK','','.',',','','',100,1,'ZMW','Fiat');
INSERT INTO CURRENCYFORMATS_V1 VALUES(168,'津巴布韦元 (2009)','ZWL','','.',',','','',100,1,'ZWL','Fiat');

-- 描述 INFOTABLE_V1 表
CREATE TABLE INFOTABLE_V1(
INFOID integer not null primary key  -- 信息ID，主键
, INFONAME TEXT COLLATE NOCASE NOT NULL UNIQUE  -- 信息名称，不区分大小写，非空且唯一
, INFOVALUE TEXT NOT NULL  -- 信息值，非空
);
CREATE INDEX IDX_INFOTABLE_INFONAME ON INFOTABLE_V1(INFONAME);  -- 为信息名称创建索引

-- 描述 PAYEE_V1 表
CREATE TABLE PAYEE_V1(
PAYEEID integer primary key  -- 收款人ID，主键
, PAYEENAME TEXT COLLATE NOCASE NOT NULL UNIQUE  -- 收款人名称，不区分大小写，非空且唯一
, CATEGID integer  -- 分类ID
, NUMBER TEXT  -- 编号
, WEBSITE TEXT  -- 网站
, NOTES TEXT  -- 备注
, ACTIVE integer  -- 活跃状态
, PATTERN TEXT DEFAULT ''  -- 模式，默认空字符串
);
CREATE INDEX IDX_PAYEE_INFONAME ON PAYEE_V1(PAYEENAME);  -- 为收款人名称创建索引

-- 描述 SPLITTRANSACTIONS_V1 表
CREATE TABLE SPLITTRANSACTIONS_V1(
SPLITTRANSID integer primary key  -- 分拆交易ID，主键
, TRANSID integer NOT NULL  -- 交易ID，非空
, CATEGID integer  -- 分类ID
, SPLITTRANSAMOUNT numeric  -- 分拆交易金额
, NOTES TEXT  -- 备注
);
CREATE INDEX IDX_SPLITTRANSACTIONS_TRANSID ON SPLITTRANSACTIONS_V1(TRANSID);  -- 为交易ID创建索引

-- 描述 STOCK_V1 表
CREATE TABLE STOCK_V1(
STOCKID integer primary key  -- 股票ID，主键
, HELDAT integer  -- 持有地
, PURCHASEDATE TEXT NOT NULL  -- 购买日期，非空
, STOCKNAME TEXT COLLATE NOCASE NOT NULL  -- 股票名称，不区分大小写，非空
, SYMBOL TEXT  -- 符号
, NUMSHARES numeric  -- 股票数量
, PURCHASEPRICE numeric NOT NULL  -- 购买价格，非空
, NOTES TEXT  -- 备注
, CURRENTPRICE numeric NOT NULL  -- 当前价格，非空
, VALUE numeric  -- 价值
, COMMISSION numeric  -- 佣金
);
CREATE INDEX IDX_STOCK_HELDAT ON STOCK_V1(HELDAT);  -- 为持有地创建索引

-- 描述 STOCKHISTORY_V1 表
CREATE TABLE STOCKHISTORY_V1(
HISTID integer primary key  -- 历史ID，主键
, SYMBOL TEXT NOT NULL  -- 符号，非空
, DATE TEXT NOT NULL  -- 日期，非空
, VALUE numeric NOT NULL  -- 价值，非空
, UPDTYPE integer  -- 更新类型
, UNIQUE(SYMBOL, DATE)  -- 符号和日期唯一约束
);
CREATE INDEX IDX_STOCKHISTORY_SYMBOL ON STOCKHISTORY_V1(SYMBOL);  -- 为符号创建索引

-- 描述 REPORT_V1 表
CREATE TABLE REPORT_V1(
REPORTID integer not null primary key  -- 报告ID，主键
, REPORTNAME TEXT COLLATE NOCASE NOT NULL UNIQUE  -- 报告名称，不区分大小写，非空且唯一
, GROUPNAME TEXT COLLATE NOCASE  -- 组名称，不区分大小写
, ACTIVE integer  -- 活跃状态
, SQLCONTENT TEXT  -- SQL内容
, LUACONTENT TEXT  -- Lua内容
, TEMPLATECONTENT TEXT  -- 模板内容
, DESCRIPTION TEXT  -- 描述
);
CREATE INDEX INDEX_REPORT_NAME ON REPORT_V1(REPORTNAME);  -- 为报告名称创建索引

-- 描述 ATTACHMENT_V1 表
CREATE TABLE ATTACHMENT_V1(
ATTACHMENTID INTEGER NOT NULL PRIMARY KEY  -- 附件ID，主键
, REFTYPE TEXT NOT NULL /* Transaction, Stock, Asset, Bank Account, Repeating Transaction, Payee */  -- 参考类型（交易、股票、资产、银行账户、重复交易、收款人），非空
, REFID INTEGER NOT NULL  -- 参考ID，非空
, DESCRIPTION TEXT COLLATE NOCASE  -- 描述，不区分大小写
, FILENAME TEXT NOT NULL COLLATE NOCASE  -- 文件名，不区分大小写，非空
);
CREATE INDEX IDX_ATTACHMENT_REF ON ATTACHMENT_V1(REFTYPE, REFID);  -- 为参考类型和参考ID创建索引

-- 描述 CUSTOMFIELD_V1 表
CREATE TABLE CUSTOMFIELD_V1(
FIELDID INTEGER NOT NULL PRIMARY KEY  -- 字段ID，主键
, REFTYPE TEXT NOT NULL /* Transaction, Stock, Asset, Bank Account, Repeating Transaction, Payee */  -- 参考类型（交易、股票、资产、银行账户、重复交易、收款人），非空
, DESCRIPTION TEXT COLLATE NOCASE  -- 描述，不区分大小写
, TYPE TEXT NOT NULL /* String, Integer, Decimal, Boolean, Date, Time, SingleChoice, MultiChoice */  -- 类型（字符串、整数、小数、布尔、日期、时间、单选、多选），非空
, PROPERTIES TEXT NOT NULL  -- 属性，非空
);
CREATE INDEX IDX_CUSTOMFIELD_REF ON CUSTOMFIELD_V1(REFTYPE);  -- 为参考类型创建索引

-- 描述 CUSTOMFIELDDATA_V1 表
CREATE TABLE CUSTOMFIELDDATA_V1(
FIELDATADID INTEGER NOT NULL PRIMARY KEY  -- 字段数据ID，主键
, FIELDID INTEGER NOT NULL  -- 字段ID，非空
, REFID INTEGER NOT NULL  -- 参考ID，非空
, CONTENT TEXT  -- 内容
, UNIQUE(FIELDID, REFID)  -- 字段ID和参考ID唯一约束
);
CREATE INDEX IDX_CUSTOMFIELDDATA_REF ON CUSTOMFIELDDATA_V1(FIELDID, REFID);  -- 为字段ID和参考ID创建索引

-- 描述 TRANSLINK_V1 表
CREATE TABLE TRANSLINK_V1(
TRANSLINKID integer NOT NULL primary key  -- 交易链接ID，主键
, CHECKINGACCOUNTID integer NOT NULL  -- 支票账户ID，非空
, LINKTYPE TEXT NOT NULL /* Asset, Stock */  -- 链接类型（资产、股票），非空
, LINKRECORDID integer NOT NULL  -- 链接记录ID，非空
);
CREATE INDEX IDX_LINKRECORD ON TRANSLINK_V1(LINKTYPE, LINKRECORDID);  -- 为链接类型和链接记录ID创建索引
CREATE INDEX IDX_CHECKINGACCOUNT ON TRANSLINK_V1(CHECKINGACCOUNTID);  -- 为支票账户ID创建索引

-- 描述 SHAREINFO_V1 表
CREATE TABLE SHAREINFO_V1(
SHAREINFOID integer NOT NULL primary key  -- 分享信息ID，主键
, CHECKINGACCOUNTID integer NOT NULL  -- 支票账户ID，非空
, SHARENUMBER numeric  -- 分享数量
, SHAREPRICE numeric  -- 分享价格
, SHARECOMMISSION numeric  -- 分享佣金
, SHARELOT TEXT  -- 分享批次
);
CREATE INDEX IDX_SHAREINFO ON SHAREINFO_V1(CHECKINGACCOUNTID);  -- 为支票账户ID创建索引

-- 描述 TAG_V1 表
CREATE TABLE TAG_V1(
TAGID INTEGER PRIMARY KEY  -- 标签ID，主键
, TAGNAME TEXT COLLATE NOCASE NOT NULL UNIQUE  -- 标签名称，不区分大小写，非空且唯一
, ACTIVE INTEGER  -- 活跃状态
);
CREATE INDEX IDX_TAGNAME ON TAG_V1(TAGNAME);  -- 为标签名称创建索引

-- 描述 TAGLINK_V1 表
CREATE TABLE TAGLINK_V1(
TAGLINKID INTEGER PRIMARY KEY  -- 标签链接ID，主键
, REFTYPE TEXT NOT NULL  -- 参考类型，非空
, REFID INTEGER NOT NULL  -- 参考ID，非空
, TAGID INTEGER NOT NULL  -- 标签ID，非空
, FOREIGN KEY (TAGID) REFERENCES TAG_V1 (TAGID)  -- 外键约束，引用TAG_V1表的TAGID
, UNIQUE(REFTYPE, REFID, TAGID)
);
CREATE INDEX IDX_TAGLINK ON TAGLINK_V1 (REFTYPE, REFID, TAGID);
