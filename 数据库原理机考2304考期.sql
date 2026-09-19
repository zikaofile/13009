create table supplier(
	sid int(11) not null,
	sname varchar(100) not null,
	address varchar(200) not null,
	contact varchar(30) ,
	phone varchar(30) not null,
	updated datetime default null,
	remarks varchar(100) default null,
	primary key (sid)
);









create table goods(
	gid int(11) not null,
	gname varchar(100) not null,
	type_id int(11) not null,
	sid int(11) not null,
	purchasing_price decimal(9,2) default null,
	selling_price decimal(9,2) default null,
	updated datetime default null,
	remarks varchar(100) default null,
	constraint fk_sid foreign key(sid) references supplier(sid),
	primary key (gid)
);




create table warehouse(
	wid int(11) not null,
	name varchar(100) not null,
	address varchar(200) default null,
	space float default null,
	updated datetime default null,
	remarks varchar(100) default null,
	primary key (wid)
);




create table inventory(
	iid int(11) not null,
	gid int(11)  not null,
	wid int(11) not null,
	quantity int(11) not null,
	updated datetime default null,
	remarks varchar(100) default null,
	constraint fk_gid foreign key(gid) references goods(gid),
	constraint fk_wid foreign key(wid) references warehouse(wid),
	primary key (iid)
);
















INSERT INTO supplier
(sid, sname, address, contact, phone, updated, remarks)
VALUES(1, '供应商1', '供应商地址1', '供应商联系人1', '13011111111', now(), '备注1'),
(2, '供应商2', '供应商地址2', '供应商联系人2', '13011111112', now(), '备注2'),
(3, '供应商3', '供应商地址3', '供应商联系人3', '13011111113', now(), '备注3');






INSERT INTO goods
(gid, gname, type_id, sid, purchasing_price, selling_price, updated, remarks)
VALUES(1, '商品1', 1, 1, 100, 200, now(), '备注'),
(2, '商品2', 2, 2, 10, 50, now(), '备注'),
(3, '商品3', 3, 3, 30, 60, now(), '备注')
;


INSERT INTO warehouse
(wid, name, address, `space`, updated, remarks)
VALUES(1, '仓库1', '仓库1地址', 100, now(), '')
,(2, '仓库2', '仓库2地址', 200, now(), ''),
(3, '仓库3', '仓库3地址', 300, now(), '')
;

INSERT INTO inventory
(iid, gid, wid, quantity, updated, remarks)
VALUES(1, 1, 1, 1000, now(), '库存1'),
(2, 2, 2, 2000, now(), '库存2'),
(3, 3, 3, 2000, now(), '库存3')
;







select
	g.gname as '商品名称',
	w.name as '所在仓库',
	i.quantity as '库存数量'
from
	inventory_guohongwei.inventory i
left join inventory_guohongwei.goods g 
on
	i.gid = g.gid
left join inventory_guohongwei.supplier s on
	s.sid = g.sid
left join inventory_guohongwei.warehouse w on
	w.wid  = i.wid 
where
	s.sname = '供应商1';

-- 商品编号 商品名称 采购价格 销售价格 库存量

select
	g.gid as '商品编号',
	g.gname as '商品名称',
	g.purchasing_price as '采购价格',
	g.selling_price as '销售价格',
	sum(i.quantity) as '库存量' 
from
	goods g
join inventory i on
	g.gid = i.gid group by g.gid ,g.gname,g.purchasing_price ,g.selling_price ;



create  view goodsView as 
select
	g.gid as '商品编号',
	g.gname as '商品名称',
	g.purchasing_price as '采购价格',
	g.selling_price as '销售价格',
	sum(i.quantity) as '库存量' 
from
	goods g
join inventory i on
	g.gid = i.gid group by g.gid ,g.gname,g.purchasing_price ,g.selling_price ;

select * from goodsview ;

create user 'guohongwei'@'localhost' identified by 'guohongwei';

-- drop user guohongwei;


grant all privileges on inventory_guohongwei.* to 'guohongwei'@'localhost';



